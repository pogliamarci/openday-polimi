#!/usr/bin/env python

import threading

import MySQLdb
import MySQLdb.cursors

from MySQLdb import escape_string as escape

def synchronized(method):
	def f(*args,**kwargs):
		self = args[0]
		if not hasattr( self, "__lock__" ):
			self.__lock__ = threading.Lock()
		if not hasattr( self, "__lock_owner__" ):
			self.__lock_owner__ = threading.current_thread()
		if self.__lock_owner__ == threading.current_thread() and self.__lock__.locked():
			return method( *args, **kwargs )
		else:
			with self.__lock__:
				self.__lock_owner__ = threading.current_thread()
				return method(*args,**kwargs)
	return f

class MyDB( object ):

	def __init__( self, host='localhost', user='vuln-user', passw='vuln-pass', db='my_movies', cursorclass=MySQLdb.cursors.DictCursor):
		self.create_singleton( lambda : MySQLdb.connect(host=host, user=user, passwd=passw, db=db, cursorclass=cursorclass, charset="utf8", use_unicode=True) )
	
	@classmethod
	@synchronized
	def create_singleton( clazz, instance_creator ):
		if not hasattr( clazz, "conn" ):
			clazz.conn = instance_creator()
	
	@classmethod
	def get_movies( clazz ):
		cur = clazz.conn.cursor()
		cur.execute( "SELECT `index`, `title`, `description`, `actors`, `price` FROM `movie`" )
		return cur.fetchall()
	
	@classmethod
	def get_movie_by_id( clazz, movie_id ):
		cur = clazz.conn.cursor()
		cur.execute( "SELECT `index`, `title`, `description`, `actors`, `price` FROM `movie` WHERE `index` = %d" % movie_id )
		return cur.fetchone()
	
	@classmethod
	def get_reviews_by_id( clazz, movie_id ):
		cur = clazz.conn.cursor()
		cur.execute( "SELECT `username`, `timestamp`, `text` FROM `reviews` WHERE `movie_id` = %d ORDER BY `timestamp` DESC" % movie_id )
		return cur.fetchall()

	@classmethod
	def insert_review( clazz, username, movie_id, text ):
		try:
			clazz.conn.cursor().execute( "INSERT INTO `reviews` (`username`, `movie_id`, `text`, `timestamp` ) VALUES ( '%s', '%d',  '%s', CURRENT_TIMESTAMP )" % (escape(username), movie_id, escape(text)) )
			clazz.conn.commit()
			return True
		except MySQLdb.Error:
			clazz.conn.rollback()
			return False

	@classmethod
	@synchronized
	def create_user( clazz, username, password ):
		try:
			clazz.conn.cursor().execute( "INSERT INTO `users` (`username`,`password`) VALUES ('%s','%s')" % (username,password) )
			clazz.conn.commit()
			return True
		except MySQLdb.Error:
			clazz.conn.rollback()
			return False
	
	@classmethod
	def get_user_id_by_credentials( clazz, username, password ):
		cur = clazz.conn.cursor()
		print "SELECT `user_id` FROM `users` WHERE `username` = '%s' AND `password` = '%s'" % (username, password)
		cur.execute( "SELECT `user_id` FROM `users` WHERE `username` = '%s' AND `password` = '%s'" % (username, password) )
		result = cur.fetchall()
		if result:
			return result[0].values().__iter__().next()

	@classmethod
	def get_username_by_id( clazz, user_id ):
		cur = clazz.conn.cursor()
		cur.execute( "SELECT `username` FROM `users` WHERE `user_id` = %s" % (user_id) )
		result = cur.fetchall()
		if result:
			return result[0].values().__iter__().next()

	@classmethod
	@synchronized
	def add_to_cart( clazz, user_id, movie_id, quantity ):
		try:
			clazz.conn.cursor().execute( "INSERT INTO `cart` (`user_id`,`movie_id`,`quantity`) VALUES ('%s','%s','%d')" % (user_id, movie_id, quantity) )
			clazz.conn.commit()
			return True
		except MySQLdb.Error:
			clazz.conn.rollback()
			return False

	@classmethod
	def get_cart( clazz, user_id ):
		cur = clazz.conn.cursor()
		cur.execute( "SELECT c.`movie_id`, m.title, c.quantity, m.actors, m.description, m.price, c.timestamp FROM `cart` c INNER JOIN `movie` m ON c.movie_id = m.index WHERE c.`user_id` = %s ORDER BY c.timestamp DESC" % (user_id) )

		result = cur.fetchall()

		if result:
			return result