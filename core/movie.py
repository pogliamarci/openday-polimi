from flask import render_template
from mydb import MyDB

def render_page_content(movie_id):
	content = dict()
	db = MyDB()
	
	content['id'] = movie_id
	movie = db.get_movie_by_id( movie_id )

	content['title'] = movie['title']
	content['actors'] = movie['actors']
	content['reviews'] = db.get_reviews_by_id( movie_id )

	return render_template('movie.html', content = content)
