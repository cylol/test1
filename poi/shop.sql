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
  `chinesename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `keyword` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `keyword_v2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `keyword_v3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `simple_trans` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `diningoptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



CREATE TABLE `simple_cata_maps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ta_cata` varchar(255) NOT NULL,
  `dp_cata` varchar(255),
  `order_id` int(11) NOT NULL DEFAULT 1,
  `last` tinyint(1) DEFAULT 0,
  `cuisine_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_simple_map_catas_on_ta_cata` (`ta_cata`),
  KEY `index_simple_map_catas_on_dp_cata` (`dp_cata`),
  KEY `index_simple_map_catas_on_order_id` (`order_id`),
  KEY `index_simple_map_catas_on_last_id` (`last`),
  KEY `index_simple_map_catas_on_cuisine_id` (`cuisine_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `citys_cuisines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city_id` int(11) NOT NULL,
  `cuisine_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_shops_cuisines_on_city_id` (`city_id`),
  KEY `index_shops_cuisines_on_cuisine_id` (`cuisine_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `dp_city_cuisines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city_id` int(11) NOT NULL,
  `dp_city_id` int(11) NOT NULL,
  `cata_id` int(11) NOT NULL,
  `cata_name` varchar(255) NOT NULL,
  `shophits` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_dp_city_cuisines_on_city_id` (`city_id`),
  KEY `index_dp_city_cuisines_on_cuisine_id` (`dp_city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `shops_cuisine_refs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL,
  `name` varchar(255),
  `level` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_shops_cuisine_refs_on_shop_id` (`shop_id`),
  KEY `index_shops_cuisine_refs_on_name` (`name`),
  KEY `index_shops_cuisine_refs_on_level` (`level`),
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `citys_new_cuisines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city_id` int(11) NOT NULL,
  `name` varchar(255),
  `level` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_citys_new_cuisine_on_shop_id` (`city_id`),
  KEY `index_citys_new_cuisine_on_name` (`name`),
  KEY `index_citys_new_cuisine_on_level` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `catas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL,
  `name` varchar(255),
  `cata_type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_shops_catas_on_shop_id` (`shop_id`),
  KEY `index_shops_catas_on_name` (`name`),
  KEY `index_shops_catas_on_level` (`cata_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



