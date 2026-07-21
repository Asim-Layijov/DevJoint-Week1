	   --Çox addımlı məntiq üçün subquery və CTE (WITH)
	   --1.Subquerry - Ortalama qiymetden daha baha olan 5 mehsulu gosterir
	  select  ProductID,
              ProductName,
              UnitPrice
              from Products
              where UnitPrice > (
              select avg(UnitPrice) 
              from Products)
              order by UnitPrice desc
              limit 5;

	--2. Her ayliq satis ortalama satisdan neqeder ferqlidir
with MonthlySales as (
     Select
	 strftime('%Y-%m', o.OrderDate) as Month,
	 sum(od.Quantity * od.UnitPrice) as MonthSale
	 from Orders o
	 inner join 'Order Details' od on o.OrderID = od.OrderID
	 group by  strftime('%Y-%m', o.OrderDate)
)	

Select Month,
       round(MonthSale, 2) as 'Ayliq Satis',
	   round(avg(MonthSale) over(), 2) as 'Orta Ayliq Satis',
	   round(MonthSale - Avg(MonthSale) over(), 2) as 'Ferq'
	   from MonthlySales
	   order by Month desc;

--3. Satis ranki uzre top 5 musteri
With CustomerSales as (
     select
	 c.CustomerID,
	 c.CompanyName,
	 c.Country,
	 sum(od.Quantity * od.UnitPrice) as ToplamSatis
	 from Customers c
	 inner join Orders o on c.CustomerID = o.CustomerID
	 inner join "Order Details" od on o.OrderID = od.OrderID
	 group by c.CustomerID),
	 
	 RankedCustomers AS (
	                 SELECT *,
					 rank() Over(Order by ToplamSatis desc) as SatisRanki,
					 round(ToplamSatis*100.0 / sum(ToplamSatis) over(), 2) as SatisFaizi
					 from CustomerSales)

Select 
       SatisRanki,
	   CompanyName,
	   Country,
	   Round(ToplamSatis, 2) as ToplamSatis
	   from RankedCustomers
	   Where SatisRanki <= 5
	   order by SatisRanki
