 --Sorğu optimallaşdırma anlayışı (index-in nəyə kömək edəcəyini izah, correlated subquery-ni JOIN-a çevirmək)
-- Bu sorgu p2.CategoryID = p1.CategoryID sertine gore hər setir ucun yeniden icra edilir
select
    p1.ProductName, 
    p1.UnitPrice
from Products p1
where p1.UnitPrice > (
    select avg(p2.UnitPrice)
    from Products p2
    where p2.CategoryID = p1.CategoryID
);

-- Bu sorgu tekce bir defe icra edilir
select 
    p1.ProductName, 
    p1.UnitPrice
from Products p1
join (
    select CategoryID, avg(UnitPrice) as AvgCategoryPrice
    from Products
    group by CategoryID
) p2 on p1.CategoryID = p2.CategoryID
where p1.UnitPrice > p2.AvgCategoryPrice;
