--QUERY SELECT

--1- Selezionare tutte le software house americane (3)
Select *
from software_houses
where country = 'United States';

--2- Selezionare tutti i giocatori della città di 'Rogahnland' (2)
Select *
from players
where city = 'Rogahnland';

--3- Selezionare tutti i giocatori il cui nome finisce per "a" (220)
Select *
from players
where name like '%a';

--4- Selezionare tutte le recensioni scritte dal giocatore con ID = 800 (11)
Select *
from reviews
where player_id = 800;

--5- Contare quanti tornei ci sono stati nell'anno 2015 (9)
Select count(*) as Totale_Tornei 
from tournaments
where year = 2015;

--6- Selezionare tutti i premi che contengono nella descrizione la parola 'facere' (2)
Select *
from awards
where description like '%facere%'

--7- Selezionare tutti i videogame che hanno la categoria 2 (FPS) o 6 (RPG), mostrandoli una sola volta (del videogioco vogliamo solo l'ID) (287)
Select distinct videogame_id
from category_videogame
where category_id = 2 or category_id = 6;

--8- Selezionare tutte le recensioni con voto compreso tra 2 e 4 (2947)
Select *
from reviews
where rating > 1 and rating < 5;

--9- Selezionare tutti i dati dei videogiochi rilasciati nell'anno 2020 (46)
Select *
from videogames
where YEAR(release_date) = 2020;

--10- Selezionare gli id dei videogame che hanno ricevuto almeno una recensione da stelle, mostrandoli una sola volta (443)
Select distinct videogame_id
from reviews
where rating = 5;

--*********** BONUS ***********

--11- Selezionare il numero e la media delle recensioni per il videogioco con ID = 412 (review number = 12, avg_rating = 3)
select AVG(rating) as avg_rating, count(*) as review_number
from reviews
where videogame_id = 412;

--12- Selezionare il numero di videogame che la software house con ID = 1 ha rilasciato nel 2018 (13
Select *
from videogames
where YEAR(release_date) = 2018 and software_house_id = 1;

--QUERY CON GROUPBY

--1- Contare quante software house ci sono per ogni paese (3)
Select count(*) as software_houses_number,country
from software_houses
GROUP BY country;

--2- Contare quante recensioni ha ricevuto ogni videogioco (del videogioco vogliamo solo l'ID) (500)
Select count(*) as reviews_number, videogame_id
from reviews
GROUP BY videogame_id;

--3- Contare quanti videogiochi hanno ciascuna classificazione PEGI (della classificazione PEGI vogliamo solo l'ID) (13)
Select count(*) as PEGI_id
from pegi_label_videogame
GROUP BY pegi_label_id;

--4- Mostrare il numero di videogiochi rilasciati ogni anno (11)
Select count(*) as Videogame_relesed, YEAR(release_date)
from videogames
GROUP BY YEAR(release_date);

--5- Contare quanti videogiochi sono disponbiili per ciascun device (del device vogliamo solo l'ID) (7)
Select count(*) as number_of_viedeogames, device_id
from device_videogame
GROUP BY device_id;

--6- Ordinare i videogame in base alla media delle recensioni (del videogioco vogliamo solo l'ID) (500)
Select AVG(rating) as average_rating, videogame_id
from reviews
GROUP BY videogame_id
ORDER BY AVG(rating) asc;

--QUERY CON JOIN

--1- Selezionare i dati di tutti giocatori che hanno scritto almeno una recensione, mostrandoli una sola volta (996)
Select distinct players.id, players.name, players.lastname
from reviews
INNER JOIN players on player_id = players.id;

--2- Sezionare tutti i videogame dei tornei tenuti nel 2016, mostrandoli una sola volta (226)
Select distinct videogames.id, videogames.name
from tournament_videogame
INNER JOIN tournaments on tournament_id = tournaments.id
INNER JOIN videogames on videogame_id = videogames.id
where tournaments.[year] = 2016;

--3- Mostrare le categorie di ogni videogioco (1718)
select videogames.name, categories.name
from category_videogame
INNER JOIN categories on category_id = categories.id
INNER JOIN videogames on videogame_id = videogames.id

--4- Selezionare i dati di tutte le software house che hanno rilasciato almeno un gioco dopo il 2020, mostrandoli una sola volta (6)
select software_houses.name,software_houses.country
from videogames
INNER JOIN software_houses on software_house_id = software_houses.id
where YEAR(release_date) = 2020
GROUP BY software_houses.name,software_houses.country;

--5- Selezionare i premi ricevuti da ogni software house per i videogiochi che ha prodotto (55)
Select videogames.name,awards.name, software_houses.name
from award_videogame
INNER JOIN awards on award_id = awards.id
INNER JOIN videogames on videogame_id = videogames.id
INNER JOIN software_houses on software_house_id = software_houses.id;


--6- Selezionare categorie e classificazioni PEGI dei videogiochi che hanno ricevuto recensioni da 4 e 5 stelle, mostrandole una sola volta (3363)
select *
from videogames;

--7- Selezionare quali giochi erano presenti nei tornei nei quali hanno partecipato i giocatori il cui nome inizia per 'S' (474)
select distinct videogames.id, videogames.name
from videogames
INNER JOIN tournament_videogame on tournament_videogame.videogame_id = videogames.id
INNER JOIN player_tournament on player_tournament.tournament_id = tournament_videogame.tournament_id
INNER JOIN players on players.id = player_tournament.player_id
where players.name like 'S%'

--8- Selezionare le città in cui è stato giocato il gioco dell'anno del 2018 (36)
select distinct tournaments.id, tournaments.name, tournaments.city
from tournaments
INNER JOIN tournament_videogame on tournament_videogame.tournament_id = tournaments.id
INNER JOIN videogames on videogames.id = tournament_videogame.videogame_id
INNER JOIN award_videogame on award_videogame.videogame_id = videogames.id
INNER JOIN awards on awards.id = award_videogame.award_id
where awards.name = 'Gioco dell''anno' and award_videogame.year = 2018

--9- Selezionare i giocatori che hanno giocato al gioco più atteso del 2018 in un torneo del 2019 (3306)
SELECT p.id AS player_id, p.name AS player_name, p.lastname AS player_lastname, p.nickname AS player_nickname, p.city AS player_city
FROM players p
INNER JOIN player_tournament pt ON p.id = pt.player_id
INNER JOIN tournaments t ON pt.tournament_id = t.id
INNER JOIN tournament_videogame tv ON t.id = tv.tournament_id
INNER JOIN videogames v ON tv.videogame_id = v.id
INNER JOIN award_videogame av ON v.id = av.videogame_id
INNER JOIN awards a ON av.award_id = a.id
WHERE a.name = 'Gioco più atteso' AND av.year = 2018 AND t.year = 2019

--*********** BONUS ***********

--10- Selezionare i dati della prima software house che ha rilasciato un gioco, assieme ai dati del gioco stesso (software house id : 5)
select TOP 1 software_houses.id, software_houses.name, software_houses.city, videogames.id, videogames.name, videogames.release_date
from software_houses
join videogames on software_house_id = software_houses.id
ORDER BY videogames.release_date;

--11- Selezionare i dati del videogame (id, name, release_date, totale recensioni) con più recensioni (videogame id : 398)
select TOP 1 count(*) as Totale_recensioni, videogames.id, videogames.name, videogames.release_date
from reviews
join videogames on videogame_id = videogames.id
group by videogames.id, videogames.name, videogames.release_date
ORDER BY Totale_recensioni desc;

--12- Selezionare la software house che ha vinto più premi tra il 2015 e il 2016 (software house id : 1)
select TOP 1 software_houses.name,  count(*)
from software_houses
join videogames on software_house_id = videogames.software_house_id
INNER JOIN award_videogame ON videogames.id = award_videogame.videogame_id 
INNER JOIN awards ON award_videogame.award_id = awards.id
where award_videogame.[year] = 2016 or award_videogame.[year] = 2015
group by software_houses.name


--13- Selezionare le categorie dei videogame i quali hanno una media recensioni inferiore a 1.5 (10)
select AVG(reviews.rating),categories.name
from videogames
JOIN reviews on videogame_id = videogames.id
Join category_videogame on videogames.id = category_videogame.id
JOIN categories on category_id = categories.id
group by categories.name;
