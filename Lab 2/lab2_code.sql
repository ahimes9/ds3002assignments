SELECT *
FROM moz_historyvisits, moz_places
WHERE moz_historyvisits.place_id = moz_places.id

SELECT h.visit_type, h.visit_date, p.url
FROM moz_historyvisits h, moz_places p
WHERE h.place_id = p.id

SELECT b.title, p.url, b.dateAdded, p.visit_count
FROM moz_bookmarks b, moz_places p
WHERE b.fk = p.id

SELECT *
FROM moz_places
ORDER BY visit_count DESC, url

SELECT host, name, value, expiry
FROM moz_cookies
ORDER BY expiry

SELECT rev_host, sum(visit_count)
FROM moz_places
GROUP BY rev_host
ORDER BY sum(visit_count) DESC

SELECT host, count(name)
FROM moz_cookies
GROUP BY host
ORDER BY count(name)

SELECT title, adjusted, year
FROM movie
WHERE year >= 2000
ORDER BY adjusted DESC
LIMIT 5

SELECT title, author, year, country
FROM book
WHERE country LIKE('%Russia%')

SELECT name, symbol, mass
FROM periodic
WHERE mass>280
ORDER BY mass

SELECT s.title
FROM song s
INNER JOIN movie m on s.film=m.title
WHERE m.rank <=100 AND s.rank<=15

