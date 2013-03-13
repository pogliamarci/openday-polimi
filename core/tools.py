from flask.ext.login import current_user

def get_user_info():
	user_info = dict()

	if current_user.is_authenticated():
		user_info['authenticated'] = True
		user_info['username'] = current_user.username
		user_info['id'] = current_user.id
	else:
			user_info['authenticated'] = False

	return user_info