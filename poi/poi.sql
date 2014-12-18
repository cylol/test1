## 所有城市 店的数量
SELECT * from TA_DP_CITY , (select distinct(city_id), count(shop_id) from shops group by city_id ) dcc where TA_DP_CITY.TACityID = dcc.city_id

-- 32655 2397  1 United States California  32655 8542
-- 60763 2395  1 United States New York  60763 11586
-- 186338  2464  1 Europe  United Kingdom  186338  17022
-- 187147  2388  1 Europe  France  187147  12643
-- 187309  2427  1 Europe  Germany 187309  2705
-- 187497  2449  1 Europe  Spain 187497  5941
-- 187791  2458  1 Europe  Italy 187791  390
-- 188590  2428  1 Europe  The Netherlands 188590  2260
-- 189400  2455  1 Europe  Greece  189400  1855
-- 293912  2338  1 Asia  Taiwan  293912  2006
-- 293913  2335  1 Asia  Taiwan  293913  9107
-- 293916  2342  1 Asia  Thailand  293916  7835
-- 293917  2345  1 Asia  Thailand  293917  1297
-- 293919  2344  1 Asia  Thailand  293919  537
-- 293920  2343  1 Asia  Thailand  293920  1810
-- 294197  2369  1 Asia  South Korea 294197  12753
-- 294217  341 1 Asia  China 294217  4372
-- 294226  2351  1 Asia  Indonesia 294226  3104
-- 294229  2353  1 Asia  Indonesia 294229  5130
-- 294260  2355  1 Asia  Philippines 294260  205
-- 294265  2311  1 Asia  Singapore 294265  7166
-- 297884  2370  1 Asia  South Korea 297884  1750
-- 297885  2371  1 Asia  South Korea 297885  124
-- 297892  2371  1 Asia  South Korea 297892  90
-- 297907  2336  1 Asia  Taiwan  297907  351
-- 297908  2337  1 Asia  Taiwan  297908  2525
-- 297909  2406  1 Asia  Taiwan  297909  505
-- 297910  2341  1 Asia  Taiwan  297910  3208
-- 298143  2375  1 Asia  Japan 298143  151
-- 298184  2372  1 Asia  Japan 298184  44554
-- 298307  2362  1 Asia  Malaysia  298307  325
-- 298564  2373  1 Asia  Japan 298564  3277
-- 298566  2374  1 Asia  Japan 298566  8127
-- 298570  2359  1 Asia  Malaysia  298570  2346
-- 664891  342 1 Asia  China 664891  336
-- 1432365 2340  1 Asia  Taiwan  1432365 3188


## 商户类别数分布

# ta
select d.cc, count(shop_id) from (select shop_id,count(cuisine_id) as cc from shops_cuisines group by shop_id) d group by d.cc

-- 1 122876
-- 2 11934
-- 3 3587
-- 4 2804
-- 5 564
-- 6 82
-- 7 45
-- 8 34
-- 9 14
-- 10  20
-- 11  2
-- 12  7
-- 13  1

# dp
select d.cc, count(shopID) from (select shopID,count(`CategoryID`) as cc from DP_ShopCategory group by shopID) d group by d.cc

-- 1 16146750
-- 2 244770
-- 3 4148
-- 4 177
-- 5 20


## 生成 dp_city_cuisines

select TAcityID as city_id, DPcityID as dp_city_id, CategoryID as cate_id, CategoryName as cata_name, shopHits as shophits from (select TACityID, DPCityID from TA_DP_CITY where TAcityID in (select distinct city_id from shops)) td, DP_CategoryList dc where td.DPcityID = dc.cityID


## 找不到城市->cuisine的cuisine

select * from cuisines where id in (select cuisine_id from citys_cuisines where map = "{}")



## 某个城市的某类tag

select cuisine_id, count(shop_id) from shops_cuisines where shop_id in (select shop_id from shops_cuisines where cuisine_id = 127) and shop_id in (select shop_id from shops where city_id = 293919) group by cuisine_id



## 某个商户的tag

select * from cuisines where id in (select cuisine_id from shops_cuisines where shop_id = 3339942)


## 所有缺少v1分类的城市 分类分布

select shops.city_id, sr.name, count(sr.shop_id) shop_id_c from shops_cuisine_refs sr , shops where sr.shop_id = shops.shop_id group by shops.city_id, sr.name 


## 同上加city_id

select shops.city_id, sr.name, sr.level, count(sr.shop_id) shop_id_c from shops_cuisine_refs sr , shops where sr.shop_id = shops.shop_id  and shops.city_id = 298184 group by shops.city_id, sr.name 