CREATE TABLE `shops` (
  `shop_id` int(11) NOT NULL DEFAULT '0',
  `city_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `address_html` mediumtext,
  `phone` varchar(255) DEFAULT NULL,
  `latitude` double DEFAULT '0',
  `longitude` double DEFAULT '0',
  `star` double DEFAULT '0',
  `review_total` int(11) DEFAULT NULL,
  `food_score` int(11) DEFAULT NULL,
  `service_score` int(11) DEFAULT NULL,
  `value_score` int(11) DEFAULT NULL,
  `atmosphere_score` int(11) DEFAULT NULL,
  `avg_price` varchar(255) DEFAULT NULL,
  `hours` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `recomand_percent` int(11) DEFAULT NULL,
  `excellent` int(11) DEFAULT NULL,
  `very_good` int(11) DEFAULT NULL,
  `average` int(11) DEFAULT NULL,
  `poor` int(11) DEFAULT NULL,
  `terrible` int(11) DEFAULT NULL,
  PRIMARY KEY (`shop_id`),
  KEY `index_shops_on_city_id` (`city_id`),
  KEY `index_shops_on_name` (`name`),
  KEY `index_shops_on_latitude` (`latitude`),
  KEY `index_shops_on_longitude` (`longitude`),
  KEY `index_shops_on_star` (`star`),
  KEY `index_shops_on_food_score` (`food_score`),
  KEY `index_shops_on_review_total` (`review_total`),
  KEY `index_shops_on_value_score` (`value_score`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `shops_neighborhoods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL,
  `neighborhood_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_shops_neighborhoods_on_shop_id` (`shop_id`),
  KEY `index_shops_neighborhoods_on_neighborhood_id` (`neighborhood_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `shops_cuisines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL,
  `cuisine_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_shops_cuisines_on_shop_id` (`shop_id`),
  KEY `index_shops_cuisines_on_cuisine_id` (`cuisine_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `shops_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL,
  `good_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_shops_goods_on_shop_id` (`shop_id`),
  KEY `index_shops_goods_on_good_id` (`good_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `shops_diningoptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL,
  `diningoption_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_shops_diningoptions_on_shop_id` (`shop_id`),
  KEY `index_shops_diningoptions_on_diningoption_id` (`diningoption_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `neighborhoods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `cuisines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `diningoptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;