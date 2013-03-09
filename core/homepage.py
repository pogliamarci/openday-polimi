from flask import render_template
from mydb import MyDB

def render_page_content():
	content = dict()
	db = MyDB()
	
	content['movies'] = db.get_movies()
	
	return render_template('homepage.html', content = content)
