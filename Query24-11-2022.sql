

--A--
declare @Territorio nvarchar(50)
set @Territorio='Northwest'


select count(*) 
from AdventureWorks2019.Sales.SalesOrderHeader
where TerritoryID = (select TerritoryID from AdventureWorks2019.Sales.SalesTerritory
where Name=@Territorio)

--B--

select t.[group], sod.ProductID,count(productID)
from AdventureWorks2019.sales.salesorderdetail sod
inner join AdventureWorks2019.sales.salesorderheader soh
on sod.salesorderid=soh.salesorderid
inner join AdventureWorks2019.sales.salesterritory t
on soh.territoryid=t.territoryid
group by t.[group], sod.ProductID



--C--

update AdventureWorks2019.Production.ProductInventory
set quantity=quantity*1.05
where LocationID=@loc
and ProductID in (select ProductID
				from AdventureWorks2019.Production.Product
				where ProductSubcategoryID in (select ProductSubcategoryID
												from AdventureWorks2019.Production.ProductSubcategory
												where ProductCategoryID=@cat))

--D. Resta de conjuntos--

declare @cliente int
set @cliente=11

select territoryId
from AdventureWorks2019.Sales.Customer
where customerId=@cliente

--Unirlos and--

select territoryId
from AdventureWorks2019.sales.salesorderheader
where customerId=@cliente

--si hay territorios que no estan en el primero, sí se genero ordenes en territorios distintos, en caso de ser iguales no fueron en territorios distintos. 
--(Eliminar valores repetidos, distinct.)--

declare @territorio int
set @territorio=2

select DISTINCT c.CustomerID
from AdventureWorks2019.Sales.Customer c inner join AdventureWorks2019.Sales.SalesOrderHeader soh
on c.TerritoryID=soh.TerritoryID
and c.CustomerID=soh.CustomerID

select c.CustomerID
from AdventureWorks2019.Sales.Customer c inner join AdventureWorks2019.Sales.SalesOrderHeader soh
on c.TerritoryID != soh.TerritoryID
and c.CustomerID = soh.CustomerID

--E.--

declare @NOrden int --Numero de Orden
set @NOrden=43659
declare @NProducto int
set @NProducto=776
declare @NNuevo int --Cantidad
set @NNuevo=1

update AdventureWorks2019.Sales.SalesOrderDetail
set OrderQty=@NNuevo
where SalesOrderID =@NOrden and ProductID=@NProducto

--F--

update AdventureWorks2019.

select * from AdventureWorks2019.Sales.