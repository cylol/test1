select * from (select cuisine_id, count(shop_id) cs from shops_cuisines where shop_id in (select shop_id from shops_cuisines where cuisine_id = 93 ) group by cuisine_id) sc, cuisines where cuisines.id = sc.cuisine_id order by cs desc

select * from shops_cuisines where shop_id in (select shop_id from shops_cuisines where cuisine_id = 93 )

select distinct(city_id) from shops

select dcl.CategoryName, sum(cst.cs)  from (select count(ShopID) cs, CategoryID from DP_ShopCategory group by CategoryID) cst, (select distinct(categoryID), CategoryName, CategoryType from `DP_CategoryList` ) dcl where cst.CategoryID = dcl.CategoryID and dcl.CategoryType = 1 group by dcl.CategoryName


select DP_CategoryList.CategoryName, cst.cs  from (select count(ShopID) cs, Distinct(CategoryID) from DP_ShopCategory group by CategoryID) cst, `DP_CategoryList`	 where cst.CategoryID = `DP_CategoryList`.CategoryID and DP_CategoryList.CategoryType = 1 


select count(ShopID) cs, CategoryID from DP_ShopCategory group by CategoryID

select * from DP_CategoryList where CategoryID = 35


select cuisines.id , cuisines.name, sg.cs from (select cuisine_id, count(shop_id) cs from shops_cuisines group by cuisine_id) sg, cuisines where cuisines.id = sg.cuisine_id

select chinesename from cuisines 

select tp.TACityID, tp.DPcityID, CategoryID, CategorySearchName, ShopHits from (select TACityID, DPcityID from TA_DP_City where TACityID in (select distinct(city_id) from shops)) tp, DP_CategoryList dl where tp.DPcityID = dl.cityID 


select distinct(city_id) from shops

#ta城市tag
select cuisine_id, count(shop_id) from shops_cuisines where shop_id in (select shop_id from shops where city_id = 32655) group by cuisine_id
select cuisine_id, count(shop_id) from shops_cuisines where shop_id in (select shop_id from shops where cuisine_id = 121) group by cuisine_id

select count(cuisine_id), shop_id from shops_cuisines where shop_id in (select shop_id from shops where city_id = 32655) and shop_id in (select shop_id from shops_cuisines where cuisine_id = 121) group by `shop_id`


