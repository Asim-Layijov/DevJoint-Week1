-- Sifarisleri oz musterileri ve iscileri ile birlikde gosterir
Select e.FirstName || ' ' || e.LastName as "Ad soyad",
       o.OrderID,
       o.OrderDate,
	   c.CompanyName
from Orders o
INNER JOIN Customers c on o.CustomerID = c.CustomerID
INNER JOIN Employees e on o.EmployeeID = e.EmployeeID
order by o.OrderDate;
	   
--sifaris sayi 20 den cox olan kateqoriyalar uzre mehsullari gosterir	   
select p.ProductName, 
       p.UnitPrice,
	   p.UnitsInStock,
	   c.CategoryName
	   from products p
	   left join Categories c  on p.CategoryID = c.CategoryID
	   where p.UnitsInStock > 20
	   order by p.UnitPrice
	   
--iscilerin rehberlerini gosterir	   
select e.EmployeeID,
       e.FirstName as 'Isci adi', 
       e.Title,
       m.FirstName as 'Rehber adi',
       m.Title
       from Employees e
       left join Employees m on e.ReportsTo = m.EmployeeID;
--her bir sifarisin etrafli melumatini gosterir	   
select o.OrderID,
       c.CompanyName,
       od.ProductID,
       p.ProductName,
       od.Quantity,
       od.UnitPrice,
       (od.Quantity * od.unitprice) as  "Cemi Mebeleg"	   
	   from Orders o
	   INNER JOIN customers c on o.CustomerID = c.CustomerID
	   inner join 'Order Details' od on o.OrderID = od.OrderID
	   INNER join Products p on od.ProductID = p.ProductID
	   
--Secilmis olkelerden olanen cox sifarisleri gosterir	   
Select s.CompanyName,
       p.ProductName,
       count(od.OrderID) as "Sifaris Sayi",
       sum(od.quantity) as "Toplam Miqdar",
       s.Country
       from Suppliers s
	   inner join Products p on s.SupplierID = p.SupplierID
	   inner join 'Order Details' od on p.ProductID = od.ProductID
	   where s.Country in ('USA', 'Germany', 'Japan')
   	   group by s.SupplierID, p.ProductID
	   order by count(od.OrderID) DESC
