from flask import render_template
from mydb import MyDB
from flask.ext.login import current_user
import tools

def add_to_cart(movie_id, request):
	quantity = int(request.form["quantity"])
	MyDB.add_to_cart(current_user.id, movie_id, quantity)

def render_page_content(cart_id):
	content = dict()
	db = MyDB()

	content['login'] = tools.get_user_info()
	content['records'] = list()
	
	total = 0

	cart = db.get_cart(cart_id)
	if cart == None:
		cart = []

	for entry in cart:
		item = dict()
		item['id'] = entry['movie_id']
		item['title'] = entry['title']
		item['actors'] = entry['actors']
		item['quantity'] = entry['quantity']

		price = entry['price']
		subtotal = price * entry['quantity']

		item['price'] = str(price)[:-2] + '.' + str(price)[-2:]
		item['subtotal'] = str(subtotal)[:-2] + '.' + str(subtotal)[-2:]

		total = total + subtotal
		content['records'].append(item)

	total = str(total)
	content['total'] = str(total)[:-2] + '.' + str(total)[-2:]

	content['username'] = db.get_username_by_id(cart_id)

	return render_template('cart.html', content=content)