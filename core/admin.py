from flask import render_template
from mydb import MyDB
from flask.ext.login import current_user
import tools

def add_to_cart(movie_id, request):
	quantity = int(request.form["quantity"])
	MyDB.add_to_cart(current_user.id, movie_id, quantity)

def render_page_content():
	content = dict()
	db = MyDB()

	content['login'] = tools.get_user_info()
	content['records'] = list()
	content['username'] = content['login']['username']

	users = db.get_users()
	if users == None:
		users = []

	for entry in users:
		item = dict()
		item['id'] = entry['user_id']
		item['username'] = entry['username']
		item['password'] = entry['password']
		item['isAdmin'] = "Yes" if entry['isAdmin'] else "No"
		content['records'].append(item)


	return render_template('admin.html', content=content)

def render_page_notadmin():
	content = dict()
	return render_template('adminfail.html', content=content)

