from flask import Flask, render_template, request, g
#import MySQLdb
import core.homepage as homepage_engine
import core.movie as movie_engine

app = Flask(__name__)

# def connect_db():
# 	return MySQLdb.connect(host="localhost",
# 		user="john",
# 		passwd="megajonhy",
# 		db="jonhydb")

# @app.before_request
# def before_request():
#     g.db = connect_db()

@app.route('/')
def homepage():
    return homepage_engine.render_page_content()

@app.route('/movie/<int:movie_id>')
def movie(movie_id):
    return movie_engine.render_page_content(movie_id)

# @app.errorhandler(404)
# def error_404(error):
#     return render_template('error.html', error = 404), 404

# @app.errorhandler(400)
# def error_400(error):
#     return render_template('error.html', error = 400), 400


if __name__ == '__main__':
    app.run(host = "127.0.0.1", port = 1234, debug = True)
