import re
import sys

def listAt(listObj, index):
	if isinstance(listObj, list) and len(listObj) > index:
		return listObj[index]
	else:
		return None

def removeHtmlTag(html):
	if (html):
		reload(sys) 
		sys.setdefaultencoding('utf8')
		return re.sub(r'<[^>]*>', '', html)
	else:
		return None