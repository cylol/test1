import urllib
import urllib2
import re
from Helper import listAt
from Helper import removeHtmlTag
from Grinder import Grinder

import traceback

class ImageQuery(Grinder):
	Base_Uri = "http://images.search.yahoo.com/search/images?p=%s&imgsz=large&imgc=color"

	def __init__(self, proxy = None):
		super(ImageQuery, self).__init__(proxy)

	def query(self, keyword):
		url = self.Base_Uri % urllib.quote(keyword)
		headers = self.headers.copy()
		headers['Referer'] = "http://images.search.yahoo.com/images"
		try:
			request = urllib2.Request(url, None, headers)
			response = urllib2.urlopen(request)
			if response and response.geturl().lower() == '':
				return None
			html = response.read().decode('utf8')
			if (html):
				images = re.findall('\&imgurl=(.*?)\&rurl',html)
				if isinstance(images, list) and len(images) > 0:
					return images
				else:
					print 'no images'
					return False
			else:
				print html
				return False
		except Exception, e:
			print e
			#print traceback.format_exc()
			return False
		return None