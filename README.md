# 1. Create table
•	 employee table stores employee’s data such as employee id, last name, first name, etc. It also has a field named ReportsTo to specify who reports to whom.

•	 customer table stores customers data.

•	 invoice & invoiceline tables: these two tables store invoice data. The invoice table stores invoice header data and the invoiceline table stores the invoice line items data.

•	 artist table stores artists data. It is a simple table that contains only the artist id and name.

•	 album table stores data about a list of tracks. Each album belongs to one artist. However, one artist may have multiple albums.

•	 mediatype table stores media types such as MPEG audio and AAC audio files.

•	 genre table stores music types such as rock, jazz, metal, etc.

•	 tracks table stores the data of songs. Each track belongs to one album.

•	 playlist & playlisttrack tables: playlist table store data about playlists. Each playlist contains a list of tracks. Each track may belong to multiple playlists. The relationship between the playlist table and track table is many-to-many. The playlisttrack table is used to reflect this relationship.

Table "Album" {
  "AlbumId" INT [pk, not null, increment]
  "Title" NVARCHAR(160) [not null]
  "ArtistId" INT [not null]

Indexes {
  ArtistId [name: "IFK_AlbumArtistId"]
}
}

Table "Artist" {
  "ArtistId" INT [pk, not null, increment]
  "Name" NVARCHAR(120)
}

Table "Customer" {
  "CustomerId" INT [pk, not null, increment]
  "FirstName" NVARCHAR(40) [not null]
  "LastName" NVARCHAR(20) [not null]
  "Company" NVARCHAR(80)
  "Address" NVARCHAR(70)
  "City" NVARCHAR(40)
  "State" NVARCHAR(40)
  "Country" NVARCHAR(40)
  "PostalCode" NVARCHAR(10)
  "Phone" NVARCHAR(24)
  "Fax" NVARCHAR(24)
  "Email" NVARCHAR(60) [not null]
  "SupportRepId" INT

Indexes {
  SupportRepId [name: "IFK_CustomerSupportRepId"]
}
}

Table "Employee" {
  "EmployeeId" INT [pk, not null, increment]
  "LastName" NVARCHAR(20) [not null]
  "FirstName" NVARCHAR(20) [not null]
  "Title" NVARCHAR(30)
  "ReportsTo" INT
  "BirthDate" DATETIME
  "HireDate" DATETIME
  "Address" NVARCHAR(70)
  "City" NVARCHAR(40)
  "State" NVARCHAR(40)
  "Country" NVARCHAR(40)
  "PostalCode" NVARCHAR(10)
  "Phone" NVARCHAR(24)
  "Fax" NVARCHAR(24)
  "Email" NVARCHAR(60)

Indexes {
  ReportsTo [name: "IFK_EmployeeReportsTo"]
}
}

Table "Genre" {
  "GenreId" INT [pk, not null, increment]
  "Name" NVARCHAR(120)
}

Table "Invoice" {
  "InvoiceId" INT [pk, not null, increment]
  "CustomerId" INT [not null]
  "InvoiceDate" DATETIME [not null]
  "BillingAddress" NVARCHAR(70)
  "BillingCity" NVARCHAR(40)
  "BillingState" NVARCHAR(40)
  "BillingCountry" NVARCHAR(40)
  "BillingPostalCode" NVARCHAR(10)
  "Total" NUMERIC(10,2) [not null]

Indexes {
  CustomerId [name: "IFK_InvoiceCustomerId"]
}
}

Table "InvoiceLine" {
  "InvoiceLineId" INT [pk, not null, increment]
  "InvoiceId" INT [not null]
  "TrackId" INT [not null]
  "UnitPrice" NUMERIC(10,2) [not null]
  "Quantity" INT [not null]

Indexes {
  InvoiceId [name: "IFK_InvoiceLineInvoiceId"]
  TrackId [name: "IFK_InvoiceLineTrackId"]
}
}

Table "MediaType" {
  "MediaTypeId" INT [pk, not null, increment]
  "Name" NVARCHAR(120)
}

Table "Playlist" {
  "PlaylistId" INT [pk, not null, increment]
  "Name" NVARCHAR(120)
}

Table "PlaylistTrack" {
  "PlaylistId" INT [not null]
  "TrackId" INT [not null]

Indexes {
  (PlaylistId, TrackId) [pk]
  TrackId [name: "IFK_PlaylistTrackTrackId"]
}
}

Table "Track" {
  "TrackId" INT [pk, not null, increment]
  "Name" NVARCHAR(200) [not null]
  "AlbumId" INT
  "MediaTypeId" INT [not null]
  "GenreId" INT
  "Composer" NVARCHAR(220)
  "Milliseconds" INT [not null]
  "Bytes" INT
  "UnitPrice" NUMERIC(10,2) [not null]

Indexes {
  AlbumId [name: "IFK_TrackAlbumId"]
  GenreId [name: "IFK_TrackGenreId"]
  MediaTypeId [name: "IFK_TrackMediaTypeId"]
}
}

Ref:"Artist"."ArtistId" < "Album"."ArtistId" [update: no action, delete: no action]

Ref:"Employee"."EmployeeId" < "Customer"."SupportRepId" [update: no action, delete: no action]

Ref:"Employee"."EmployeeId" < "Employee"."ReportsTo" [update: no action, delete: no action]

Ref:"Customer"."CustomerId" < "Invoice"."CustomerId" [update: no action, delete: no action]

Ref:"Invoice"."InvoiceId" < "InvoiceLine"."InvoiceId" [update: no action, delete: no action]

Ref:"Track"."TrackId" < "InvoiceLine"."TrackId" [update: no action, delete: no action]

Ref:"Playlist"."PlaylistId" < "PlaylistTrack"."PlaylistId" [update: no action, delete: no action]

Ref:"Track"."TrackId" < "PlaylistTrack"."TrackId" [update: no action, delete: no action]

Ref:"Album"."AlbumId" < "Track"."AlbumId" [update: no action, delete: no action]

Ref:"Genre"."GenreId" < "Track"."GenreId" [update: no action, delete: no action]

Ref:"MediaType"."MediaTypeId" < "Track"."MediaTypeId" [update: no action, delete: no action]

# 3. SELECTING ALBUMS TO PURCHASE
The record label specializes in artists from the USA, and they have given Chinook some money to advertise the new albums in the USA, so we're interested in finding out which genres sell the best in the USA.

You'll need to write a query to find out which genres sell the most tracks in the USA, write up a summary of your findings, and make a recommendation for the three artists whose albums we should purchase for the store.
# 4. Analyzing Employee Sales Performance
Each customer for the Chinook store gets assigned a sales support agent within the company when they first make a purchase. You have been asked to analyze the purchases of customers belonging to each employee to see if any sales support agent is performing either better or worse than the others.
You might like to consider whether any extra columns from the employee table explain any variance you see, or whether the variance might instead be indicative of employee performance.
# 5. Analyzing Sales by Country
Your next task is to analyze the sales data for customers from each different country. You have been given guidance to use the country value from the customers table and ignore the country from the billing address in the invoice table.
In particular, you have been directed to calculate data, for each country, on the:

• total number of customers

• total value of sales

• average value of sales per customer

• average order value 

Because there are a number of countries with only one customer, you should group these customers as "Other" in your analysis. You can use the following 'trick' to force the ordering of "Other" to last in your analysis.
If there is a particular value that you would like to force to the top or bottom of results, you can put what would normally be your most outer query in a subquery with a case statement that adds a numeric column, and then in the outer query sort by that column. Here's an example - let's start by creating a view so we're working with a manageable number of rows.
# 6. Albums vs Individual Tracks
The Chinook store is setup in a way that allows customer to make purchases in one of the two ways:

• purchase a whole album.

• purchase a collection of one or more individual tracks.

The store does not let customers purchase a whole album, and then add individual tracks to that same purchase (unless they do that by choosing each track manually). When customers purchase albums, they are charged the same price as if they had purchased each of those tracks separately. 
Management is currently considering changing their purchasing strategy to save money. The strategy they are considering is to purchase only the most popular tracks from each album from record companies, instead of purchasing every track from an album.
We have been asked to find out what percentage of purchases are individual tracks vs whole albums, so that management can use this data to understand the effect this decision might have on overall revenue.

It is very common when you are performing an analysis to have 'edge cases' which prevent you from getting a 100% accurate answer to your question. In this instance, we have two edge cases to consider:

• Albums that have only one or two tracks are likely to be purchased by 

customers as part of a collection of individual tracks.

• Customers may decide to manually select every track from an album, and 
then add a few individual tracks from other albums to their purchase.

In the first case, since our analysis is concerned with maximizing revenue, we can safely ignore albums consisting of only a few tracks. The company has previously done analysis to confirm that the second case does not happen often, so we can ignore this case also.

In order to answer the question, we're going to have to identify whether each invoice has all the tracks from an album. We can do this by getting the list of tracks from an invoice and comparing it to the list of tracks from an album. We can find the album to compare the purchase to by looking up the album that one of the purchased tracks belongs to. It doesn't matter which track we pick, since if it's an album purchase, that album will be the same for all tracks.
them:

• Which artist is used in the most playlists?

• How many tracks have been purchased vs not purchased? 

• Is the range of tracks in the store reflective of their sales popularity? 

• Do protected vs non-protected media types have an effect on popularity


