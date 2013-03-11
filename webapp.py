from flask import Flask, render_template, request, g, flash, redirect
from flask.ext.login import (LoginManager, current_user, login_required,
							login_user, logout_user, UserMixin, AnonymousUser,
							confirm_login, fresh_login_required)

import core.homepage as homepage_engine
import core.movie as movie_engine

from core.mydb import MyDB; MyDB()

app = Flask(__name__)
app.secret_key = 'why would I tell you my secret key?'

login_manager = LoginManager()
login_manager.login_view = "login"
login_manager.login_message = u"Please log in to access this page."

login_manager.setup_app(app)

class MyUser(UserMixin):
	def __init__( self, user_id, username ):
		self.id = user_id
		self.username = username
	def is_active( self ):
		return True
@login_manager.user_loader
def load_user(user_id):
    username = MyDB.get_username_by_id( user_id )
    return MyUser( user_id, username )

@app.route('/')
def homepage():
	return homepage_engine.render_page_content()

@app.route("/login", methods=["GET", "POST"])
def login():
	if request.method == "POST" and request.form.has_key("username") and request.form.has_key("password"):
		username = request.form["username"]
		password = request.form["password"]
		user_id = MyDB.get_user_id_by_credentials( username, password )
		if user_id is not None:
			login_user( MyUser( user_id, username ), remember="no" )
			flash("Logged in!")
			return homepage_engine.render_page_content()
		else:
			return render_template("login.html", error=True)
	else:
		return render_template("login.html")

@app.route('/movie/<int:movie_id>')
def movie(movie_id):
	return movie_engine.render_page_content(movie_id)

# @app.errorhandler(404)
# def error_404(error):
#	 return render_template('error.html', error = 404), 404

# @app.errorhandler(400)
# def error_400(error):
#	 return render_template('error.html', error = 400), 400


if __name__ == '__main__':
	app.run(host = "0.0.0.0", port = 80, debug = True)
