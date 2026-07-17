--1.Ən qiymətli pkgs lə bitən 5 məhsulu göstərir
select ProductID, ProductName, QuantityPerUnit, Unitprice
      from Products
	    where QuantityPerUnit like '%pkgs.'
	    order by UnitPrice DESC
	    limit 5;
	  
--2.Londonda olan ilk 10 müştərinin siyahısını göstərir
select 	CustomerID, CompanyName, ContactName, City 
        from Customers
        WHERE city = 'London'
        order by CompanyName ASC		
		    limit 10;
	 

--3.100-dən çox sayda sifariş edən və qiyməti 10 dan yuxarı olan məhsulları göstərir
select ProductName, UnitPrice, CategoryID, UnitsInStock
       from Products
	     where UnitsInStock > 100
	     and UnitPrice > 10
	     order by UnitsInStock ASC
	     limit 5;
	

--4. Almaniyada yaşayan tərəfdaşları göstərir  
select SupplierID, CompanyName, ContactName, Country, City 
       from Suppliers 
       where Country = 'Germany' 
       order by CompanyName asc 
       limit 10;

--5. 2013 dən sonra işə götürülən işçiləri göstərir	   
select FirstName, LastName, HireDate
       from Employees
	     where HireDate > '2013-01-01'
	     order by HireDate asc
	     limit 5;
