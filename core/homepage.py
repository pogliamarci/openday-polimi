from flask import render_template
from mydb import MyDB
import tools

def render_page_content():
	content = dict()
	db = MyDB()
	
	content['login'] = tools.get_user_info()
	content['movies'] = db.get_movies()
	
	return render_template('homepage.html', content=content)