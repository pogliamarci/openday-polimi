from flask import render_template
from mydb import MyDB
from flask.ext.login import current_user
import tools

def add_review(movie_id, request):
	review = request.form['review'].strip()

	if len(review) == 0:
		return

	if not current_user.is_authenticated():
		author = "Utente anonimo"
	else:
		author = current_user.username
		
	MyDB.insert_review(author, movie_id, review)

def render_page_content(movie_id):
	content = dict()
	db = MyDB()

	content['login'] = tools.get_user_info()	
	content['id'] = movie_id
	
	movie = db.get_movie_by_id( movie_id )

	content['title'] = movie['title']
	content['actors'] = movie['actors']
	content['description'] = movie['description']
	content['price'] = str(movie['price'])[:-2] + '.' + str(movie['price'])[-2:]
	content['reviews'] = db.get_reviews_by_id( movie_id )

	return render_template('movie.html', content=content)