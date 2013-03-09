from flask import render_template


def render_page_content(movie_id):
	content = dict()

	content['id'] = movie_id
	content['title'] = 'Title'
	content['actors'] = 'actors'
	content['reviews'] = list()

	for i in range(10):
		review = dict()
		review['content'] = 'Testo review ' + str(i)
		review['author'] = 'Autor'
		content['reviews'].append(review)

	return render_template('movie.html', content = content)