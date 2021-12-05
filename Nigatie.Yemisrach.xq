(:1 
1db:open("Bookstore_XML", "Bookstore_XML.xml")
/catalog/book/(author/text() | title/text())
 :)
 
(:2
 db:open("Bookstore_XML", "Bookstore_XML.xml")
/catalog/book/(price/text() | genre/text())
:)

(:2 along with the titles
 db:open("Bookstore_XML", "Bookstore_XML.xml")
/catalog/book/(title/text() | price/text() | genre/text())
:)

(:3
db:open("Bookstore_XML", "Bookstore_XML.xml")
/catalog/book[12]/(title/text() | price/text() | description/text() )
:)

(:4
 db:open("Bookstore_XML", "Bookstore_XML.xml")
/catalog/book/
(
  if (price>40)
  then (author/text() | title/text()| price/text())
  else 
       ()
)
:)

(:5
 db:open("Bookstore_XML", "Bookstore_XML.xml")
/catalog/book/
(
  if (genre="Computer")
  then (author/text() | price/text())
  else  ()
)
:)

(:6
for $book in db:open('Bookstore_XML')//book
let $author := $book/author
return $book/author/text()
:)

(:7
for $book in db:open('Bookstore_XML')//book
let $price := $book/price
let $title := $book/title
where $price > 30
order by $title 
return $title
:)

(:7 without path description
for $book in db:open('Bookstore_XML')//book
let $price := $book/price
let $title := $book/title
where $price > 30
order by $title 
return $book/title/text()
:)

(:8
for $book in db:open('Bookstore_XML')//book
let $price := $book/price
let $description := $book/description
where $price < 5
order by $description 
return $description
:)

(:8 without path description
for $book in db:open('Bookstore_XML')//book
let $price := $book/price
let $description := $book/description
where $price < 5
order by $description 
return $book/description/text()
:)

(:9
for $book in db:open('Bookstore_XML')//book
let $title := $book/title
let $genre := $book/genre
order by $genre 
return $genre | $title/text()
:)

(:10
for $book in db:open('Bookstore_XML')//book
let $genre := $book/genre
let $description := $book/description
where $genre = "Fantasy"
order by $description 
return $genre | $book/description/text()
:)

(:11
for $book in db:open('Bookstore_XML')//book
return if ($book/price < 30)
then $book/author
else
$book/title
:)

(: with out path descriptions
for $book in db:open('Bookstore_XML')//book
return if ($book/price < 30)
then $book/author/text()
else
$book/title/text()
:)