--1
select FirstName, LastName, CustomerId, Country
from Customer
where country != 'USA'

--2
Select FirstName, LastName, CustomerId
From Customer
Where country = 'Brazil'

--3
Select c.FirstName, c.LastName, i.InvoiceId, i.InvoiceDate, i.BillingCountry
From Customer c
	Join Invoice i
	ON c.Country = i.BillingCountry
Where c.Country = 'Brazil'

--4
Select *
From Employee
Where Title = 'Sales Support Agent'

--5
Select Distinct BillingCountry
From Invoice

--6
Select e.EmployeeId, e.FirstName, e.LastName, i.InvoiceId, i.BillingAddress, i.BillingCountry, i.Total
From Employee e
	Join Customer c
	ON e.EmployeeId = c.SupportRepId
	Join Invoice i
	ON c.CustomerId = i.CustomerId

--7
Select i.Total, c.FirstName, c.LastName, i.BillingCountry,  
	   e.FirstName as [Sale Agent First Name], e.LastName as [Sale Agent Last Name]
From Employee e
	Join Customer c
	ON e.EmployeeId = c.SupportRepId
	Join Invoice i
	ON c.CustomerId = i.CustomerId

--8
Select count(*) as [2009 Invoices]
From Invoice
Where year(InvoiceDate) = 2009

Select count(*) as [2011 Invoices]
From Invoice
Where year(InvoiceDate) = 2011

--9
Select sum(Total) as [2009 Total]
From Invoice
Where year(InvoiceDate) = 2009

Select sum(Total) as [2011 Total]
From Invoice
Where year(InvoiceDate) = 2011

--10
Select count(*) as [Items from Invoice #37]
From InvoiceLine
Where InvoiceId = 37

--11
Select InvoiceId, count(*) as [Number of Line Items]
From InvoiceLine
Group by InvoiceId

--12
Select i.InvoiceLineId, t.Name
From Track t
	Join InvoiceLine i
	ON t.TrackId = i.TrackId
Order by i.InvoiceLineId

--13
Select il.InvoiceLineId, a.Name as Artist, t.Name as [Track Name]
From Artist a
	Join Album al
	ON a.ArtistId = al.ArtistId
	Join Track t
	ON al.AlbumId = t.AlbumId
	Join InvoiceLine il
	ON t.TrackId = il.TrackId

--14
Select BillingCountry, count(*) as [# of Invoices]
From Invoice
Group By BillingCountry

--15
Select pt.PlaylistId, count(*) as [Total # of Tracks], pl.Name as [Playlist Name]
From Playlist pl
	Join PlaylistTrack pt
	ON pl.PlaylistId = pt.PlaylistId
Group By pt.PlaylistId, pl.Name

--16
Select t.Name as [Track Name], a.Title as [Album Name], 
	m.Name as [Media Type], g.Name as [Genre]
From Track t
	Join Album a
	ON t.AlbumId = a.AlbumId
	Join MediaType m
	ON t.MediaTypeId = m.MediaTypeId
	Join Genre g
	ON t.GenreId = g.GenreId

--17
Select *
From Invoice i
	Join (Select InvoiceId, count(*) as [# of Invoice Line Items]
	From InvoiceLine
	Group By InvoiceId) il
ON i.InvoiceId = il.InvoiceId

--18
Select employ.SupportRepId, employ.FirstName, employ.LastName, 
	sum(employ.Total) as [Total Sales]
From 
(Select i.Total, c.SupportRepId, e.FirstName, e.LastName
From Invoice i
	JOIN Customer c
	ON i.CustomerId = c.CustomerId
	JOIN Employee e
	ON c.SupportRepId = e.EmployeeId
) employ
Group By employ.SupportRepId, employ.FirstName, employ.LastName
--different method
Select c.SupportRepId, e.FirstName, e.LastName, sum(i.Total) as [Total Sales]
From Invoice i
	JOIN Customer c
	ON i.CustomerId = c.CustomerId
	JOIN Employee e
	ON c.SupportRepId = e.EmployeeId
Group By c.SupportRepId, e.FirstName, e.LastName

--19
Select Top 1 employ.SupportRepId, employ.FirstName, employ.LastName, 
	sum(employ.Total) as [2009 Total Sales]
From 
(Select i.Total, c.SupportRepId, e.FirstName, e.LastName
From Invoice i
	JOIN Customer c
	ON i.CustomerId = c.CustomerId
	JOIN Employee e
	ON c.SupportRepId = e.EmployeeId
	Where year(i.InvoiceDate) = 2009
) employ
Group By employ.SupportRepId, employ.FirstName, employ.LastName
Order By [2009 Total Sales] desc

--20
Select Top 1 employ.FirstName, employ.LastName, 
	sum(employ.Total) as [Total Sales]
From 
(Select i.Total, c.SupportRepId, e.FirstName, e.LastName
From Invoice i
	JOIN Customer c
	ON i.CustomerId = c.CustomerId
	JOIN Employee e
	ON c.SupportRepId = e.EmployeeId
) employ
Group By employ.FirstName, employ.LastName
Order By [Total Sales] desc

--21
Select agent.EmployeeId, agent.[Sales Person], count(*) as [# of Customers]
From
(Select e.EmployeeId, concat(e.FirstName, ' ', e.LastName) as [Sales Person]
From Customer c
	JOIN Employee e
	ON c.SupportRepId = e.EmployeeId
) agent
Group By agent.EmployeeId, agent.[Sales Person]

--22
Select BillingCountry, sum(Total) as [Total Sales]
From Invoice
Group By BillingCountry

--23
Select Top 1 BillingCountry, sum(Total) as [Total Sales]
From Invoice
Group By BillingCountry
Order By [Total Sales] desc

--24
Select Top 1 t.Name, count(*) as [Total Purchases] 
From InvoiceLine il
	Join Track t
	ON il.TrackId = t.TrackId
	Join Invoice i
	ON il.InvoiceId = i.InvoiceId
Where year(InvoiceDate) = 2013
Group by t.Name
Order by [Total Purchases] DESC

--25
Select Top 5 t.Name, count(*) as [Top 5 most Purchased Songs]
From InvoiceLine il
	Join Track t
	ON il.TrackId = t.TrackId
Group By t.Name
Order By [Top 5 most Purchased Songs] DESC

--26
Select Top 3 ar.Name as Artist, count(*) as [Total Sales]
From InvoiceLine il
	Join Track t
	ON il.TrackId = t.TrackId
	Join Album al
	ON t.AlbumId = al.AlbumId
	Join Artist ar
	ON al.ArtistId = ar.ArtistId
Group by ar.Name
Order By [Total Sales] DESC

--27
Select Top 1 m.Name, count(*) as [Total Purchases]
From InvoiceLine il
	Join Track t
	ON il.TrackId = t.TrackId
	Join MediaType m
	ON t.MediaTypeId = m.MediaTypeId
Group By m.Name
Order By [Total Purchases] DESC
