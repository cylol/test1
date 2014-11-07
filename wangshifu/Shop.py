class Shop(object):
	cityId = 0
	shopId = 0
	name = ""
	address = ""
	addressHtml = ""
	phone = ""
	longitude = ""
	latitude = ""
	star = ""
	reviewTotal = ""
	avgPrice = ""
	cuisine = ""
	hours = ""
	goodFor = ""
	diningOption = ""
	diningStyle = ""
	neighborhood = ""
	crossStreet = ""
	transit = ""
	description = ""
	foodScore = ""
	serviceScore = ""
	valueScore = ""
	atmosphereScore = ""
	
	def __str__(self):
		info = []
		info.append(self.cityId)
		info.append(self.shopId)
		info.append(self.name)
		info.append(self.address)
		info.append(self.addressHtml)
		info.append(self.phone)
		info.append(self.latitude)
		info.append(self.longitude)
		info.append(self.reviewTotal)
		info.append(self.star)
		info.append(self.foodScore)
		info.append(self.serviceScore)
		info.append(self.valueScore)
		info.append(self.atmosphereScore)
		info.append(self.avgPrice)
		info.append(self.cuisine)
		info.append(self.hours)
		info.append(self.goodFor)
		info.append(self.diningOption)
		info.append(self.diningStyle)
		info.append(self.neighborhood)
		info.append(self.crossStreet)
		info.append(self.transit)
		info.append(self.description)

		return "^".join(str(v).replace('\r', '').replace('\n', '').strip() for v in info)