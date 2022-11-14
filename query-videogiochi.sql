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
Select distinct tournament_id, videogames.id
from tournament_videogame
INNER JOIN tournaments on tournament_id = tournaments.id
INNER JOIN videogames on videogame_id = videogames.id
where tournaments.[year] = 2016;

--3- Mostrare le categorie di ogni videogioco (1718)

--4- Selezionare i dati di tutte le software house che hanno rilasciato almeno un gioco dopo il 2020, mostrandoli una sola volta (6)

--5- Selezionare i premi ricevuti da ogni software house per i videogiochi che ha prodotto (55)

--6- Selezionare categorie e classificazioni PEGI dei videogiochi che hanno ricevuto recensioni da 4 e 5 stelle, mostrandole una sola volta (3363)

--7- Selezionare quali giochi erano presenti nei tornei nei quali hanno partecipato i giocatori il cui nome inizia per 'S' (474)

--8- Selezionare le città in cui è stato giocato il gioco dell'anno del 2018 (36)

--9- Selezionare i giocatori che hanno giocato al gioco più atteso del 2018 in un torneo del 2019 (3306)


--*********** BONUS ***********

--10- Selezionare i dati della prima software house che ha rilasciato un gioco, assieme ai dati del gioco stesso (software house id : 5)

--11- Selezionare i dati del videogame (id, name, release_date, totale recensioni) con più recensioni (videogame id : 398)

--12- Selezionare la software house che ha vinto più premi tra il 2015 e il 2016 (software house id : 1)

--13- Selezionare le categorie dei videogame i quali hanno una media recensioni inferiore a 1.5 (10)