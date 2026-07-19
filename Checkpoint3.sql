 -- en cox gelir getiren 5 musterini gosterir 
select c.CompanyName,
       o.OrderID,
       count(o.OrderID) as 'Sifarislerin sayi',
       sum(od.Quantity * od.UnitPrice) as 'Toplam Gelir',	   
	   ROUND(AVG(od.Quantity * od.UnitPrice), 2) as 'Orta Sifarış'
	   FROM Customers c
	   inner join Orders o on c.CustomerID = o.CustomerID
	   inner join 'Order Details' od on o.OrderID = od.OrderID
	   group by c.CustomerID, c.CompanyName
	   having sum(od.Quantity * od.UnitPrice) > 5000000
	   order by sum(od.Quantity * od.UnitPrice) desc
	   limit 5;
	   
--her ayda neqeder satis olub gosterir	   
select strftime('%Y-%m', o.OrderDate)  as "Ay",
       count(DISTINCT o.OrderID) as 'sifaris sayi',
	   count(DISTINCT od.ProductID) as 'Sifaris edilen mehsul sayi',
	   sum(od.Quantity) as 'Toplam Miqdar',
	   round(sum(od.Quantity * od.UnitPrice), 2) as 'Ayliq Satis ($)'
from Orders	o
inner join 'Order Details' od on o.OrderID = od.OrderID
where o.OrderDate IS NOT NULL
group by strftime('%Y-%m', o.OrderDate)
order by strftime('%Y-%m', o.OrderDate) DESC;

-- her categoriyada olan geliri gosterir
select c.CategoryName as "Kateqoriya",
       count(distinct p.ProductName) as "Mehsul Sayi",
	   sum(od.Quantity) as "Toplam Miqdar",
	   round(avg(od.Unitprice), 2) as "Orta Qiymet",
	   round(min(od.Unitprice), 2) as "Min Qiymet",
	   round(max(od.Unitprice), 2) as "Max Qiymet",
	   round(sum(od.Quantity * od.UnitPrice), 2) as "Kategoriyadan Gelir"
	   from Categories c 
	   inner join Products p on p.CategoryID = c.CategoryID
	   inner join 'Order Details' od on od.ProductID = p.ProductID
	   group by c.CategoryName
	   order by round(sum(od.Quantity * od.UnitPrice), 2) desc;
	   
