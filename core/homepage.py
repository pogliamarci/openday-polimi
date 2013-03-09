from flask import render_template


def render_page_content():
	content = dict()

	content['movies'] = list()

	for i in [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]:
		movie = dict()
		movie['id'] = i
		movie['title'] = 'Title'
		movie['actors'] = 'actors'

		content['movies'].append(movie)

	return render_template('homepage.html', content = content)