select * from DP_TA_Mapping where TAShopID in (select shop_id from  `shops_cuisines`  where cuisine_id in (17,19) group by shop_id having count(cuisine_id) > 1)

select distinct(CategoryName) from `DP_CategoryList`


select * from DP_shop where ShopID in (select shopid from DP_TA_Mapping where TASHOPID IN (select distinct(shop_id) from shops_cuisines ) and ShopType != 10 )

select d.cc, count(shop_id) from (select shop_id,count(cuisine_id) as cc from shops_cuisines group by shop_id) d group by d.cc


select * from DP_CategoryList where CateGoryID in (select distinct(CateGoryID) from DP_ShopCategory where shopID in (select shopID from DP_TA_Mapping where TAShopID in (select shop_id from shops)))


select CategoryID, cityID ,CategoryName from DP_CategoryList where CityID in (select distinct(DPcityID) from TA_DP_City where TACityID in (select distinct(city_id) from shops)) and categoryType = 1 


select distinct(CategoryName) from DP_CategoryList where CityID in (select distinct(DPcityID) from TA_DP_City where TACityID in (select distinct(city_id) from shops)) and categoryType = 1 


select shop_id, city_id from shops


select  c.cuisine_id, cuisines.name, c.dd from (select cuisine_id, count(id) dd from shops_cuisines group by cuisine_id) c, cuisines where c.cuisine_id = cuisines.id

select * from shops where shop_id in (select shop_id from shops_cuisines where cuisine_id = 169)