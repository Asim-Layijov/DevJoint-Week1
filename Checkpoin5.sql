	   
	   
--Window funksiyaları (RANK, ROW_NUMBER, SUM() OVER ilə running total
--1. Her kateqoriyada en bahali mehsullar 
       Select 
    c.CategoryName,
    p.ProductName,
    p.UnitPrice,
    row_number() over(partition by c.CategoryName order by p.UnitPrice desc) as ProductRowNumber
from Products p
join Categories c on p.CategoryID = c.CategoryID;

--2. qiymet uzre product reytiniqi
Select 
    ProductName,
    UnitPrice,
    rank() over(order by UnitPrice desc) as PriceRank
from Products;

--3. her kateqoriyada top 2 mehsul
WITH RankedProducts AS (
    select 
        c.CategoryName,
        p.ProductName,
        p.UnitPrice,
        row_number() over(Partition by c.CategoryName order by p.UnitPrice desc)  RowNum
     from Products p
    left join Categories c on p.CategoryID = c.CategoryID
)
select 
    CategoryName,
    ProductName,
    UnitPrice
from RankedProducts
where RowNum <= 2;

--4. Iscilerin Ranki
WITH EmployeeOrderCounts AS (
    select 
        EmployeeID, 
        count(OrderID) as UmumiSatis
    from Orders
    group by EmployeeID
)
select 
    e.FirstName,
    e.LastName,
    eo.UmumiSatis,
    row_number() over(order by eo.UmumiSatis desc) as Strict_Row_Num,
    rank() over(order by eo.UmumiSatis desc) as Order_Rank
from Employees e
join EmployeeOrderCounts eo on e.EmployeeID = eo.EmployeeID;
