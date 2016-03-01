from flask import Flask, render_template, request, redirect, url_for, make_response
from flask.ext.login import LoginManager, current_user, login_required, login_user, logout_user, UserMixin

import core.homepage as homepage_engine
import core.movie as movie_engine
import core.cart as cart_engine
import core.admin as admin_engine

from core.mydb import MyDB; MyDB()

app = Flask(__name__)
app.secret_key = 'why would I tell you my secret key?'

login_manager = LoginManager()
login_manager.login_view = "login"
login_manager.login_message = "Please log in to access this page."
login_manager.setup_app(app)

class MyUser(UserMixin):
	def __init__( self, user_id, username, isAdmin):
		print isAdmin
		self.id = user_id
		self.username = username
		self.isAdmin = isAdmin

	def is_active( self ):
		return True

@login_manager.user_loader
def load_user(user_id):
    username = MyDB.get_username_by_id( user_id )
    isAdmin = MyDB.get_isAdmin_by_id(user_id)
    return MyUser( user_id, username, isAdmin )

@app.route("/login", methods=["GET", "POST"])
def login():
	if current_user.is_authenticated:
		return redirect(url_for('homepage'))

	if request.method == "POST" and request.form.has_key("username") and request.form.has_key("password"):
		username = request.form["username"]
		password = request.form["password"]
		user_id = MyDB.get_user_id_by_credentials( username, password )

		if user_id is not None:
			isAdmin = MyDB.get_isAdmin_by_id(user_id)
			login_user( MyUser( user_id, username, isAdmin ), remember="no")
			red = redirect(url_for('homepage'))
			resp = make_response(red)
			resp.set_cookie('isAdmin',str(isAdmin))
			return resp
		else:
			content = dict()
			return render_template("login.html", error=True, content=content)
	else:
		content = dict()
		return render_template("login.html", content=content)

@app.route("/logout")
@login_required
def logout():
    logout_user()
    return redirect(url_for('homepage'))

@app.route('/', methods=["GET"])
def homepage():
	return homepage_engine.render_page_content()

@app.route('/movie/<int:movie_id>', methods=["GET", "POST"])
def movie(movie_id):
	if request.method == "POST":
		movie_engine.add_review(movie_id, request)

	return movie_engine.render_page_content(movie_id)

@app.route('/addcart/<int:movie_id>', methods=["POST"])
@login_required
def add_cart(movie_id):
	cart_engine.add_to_cart(movie_id, request)
	return cart_engine.render_page_content(current_user.id, True)

@app.route('/cart/<int:cart_id>', methods=["GET"])
def cart(cart_id):
	return cart_engine.render_page_content(cart_id, False)


@app.route('/admin', methods=["GET"])
def admin():
	isAdmin = request.cookies.get('isAdmin')
	if isAdmin=="1":
		return admin_engine.render_page_content()

	return admin_engine.render_page_notadmin()


if __name__ == '__main__':
	app.run(host = "0.0.0.0", port = 8080, debug = True)
