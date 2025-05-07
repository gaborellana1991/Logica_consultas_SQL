-- DATA PROJECT: LÓGICA CONSIULTAS SQL


-- P2 Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
select "title", "rating"
from "film"
where "rating" = 'R';


-- P3 Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
select CONCAT("first_name", ' ', "last_name"), "actor_id"
from "actor"
where "actor_id" between 30 and 40;


-- P4 Obtén las películas cuyo idioma coincide con el idioma original.
	-- (** en la columna "original_language_id" todos los datos son NULL)

select "language_id" , "original_language_id"
from "film"
where "language_id" = "original_language_id";


-- P5 Ordena las películas por duración de forma ascendente.
select "title", "length"
from "film"
order by "length" asc;


-- P6 Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
select "first_name", "last_name"
from "actor"
where "last_name" = 'ALLEN';

-- P7 Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
select COUNT("film_id"), "rating"
from "film"
group by "rating";

-- P8 Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
select "title", "rating", "length"
from "film"
where "rating" = 'PG-13' or length > 180;

-- P9 Encuentra la variabilidad de lo que costaría reemplazar las películas.
select 
	VARIANCE("replacement_cost") as "Varianza", 
	STDDEV("replacement_cost") as "Desv_Estándar"
from "film";

-- P10 Encuentra la mayor y menor duración de una película de nuestra BBDD.
select
	MIN(length) as "Menor duración",
	MAX (length) as "Mayor duración"
from "film";

-- P11 Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select "amount", "payment_date"
from "payment"
order by "payment_date" desc
limit 1
offset 2;


-- P12 Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.
select "title", "rating"
from "film"
where "rating" <> 'NC-17' and "rating" <> 'G';

-- P13 Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
select "rating", AVG(length)
from "film"
group by "rating";

-- P14 Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select "title", "length"
from "film"
where "length" > 180
order by "length" ASC;

-- P15 ¿Cuánto dinero ha generado en total la empresa?
select SUM("amount") as "total ingresos empresa"
from "payment";

-- P16 Muestra los 10 clientes con mayor valor de id.
select CONCAT("first_name", ' ', "last_name"), "customer_id"
from "customer"
order by "customer_id" desc
limit 10;

-- P17 Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
select    
    CONCAT("a"."first_name",' ', "a"."last_name") as "Nombre",
    "f"."title" as "Película"
from "actor" as "a" 
inner join "film_actor" as "fa" ON "a"."actor_id" = "fa"."actor_id"
inner join "film" as "f" ON "fa"."film_id" = "f"."film_id"
where "f"."title" = 'EGG IGBY';

-- P18 Selecciona todos los nombres de las películas únicos.
select distinct("title")
from "film";

-- P19 Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”
select 
	"f"."title", 
	"f"."length", 
	"c"."name"
from 
	"film" as "f"
inner join 
	"film_category" as "fc" on "f"."film_id" = "fc"."film_id"
inner join 
	"category" as "c" on "fc"."category_id" = "c"."category_id"
where 
	"f"."length" > 180 and 
	"c"."name" = 'Comedy';

-- P20 Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
select 
	"c"."name",
	AVG ("f"."length") as "Promedio_Duración"
from 
	"film" as "f"
inner join 
	"film_category" as "fc" on "f"."film_id" = "fc"."film_id"
inner join
	"category" as "c" on "fc"."category_id" = "c"."category_id"
group by 
	"c"."name"
having
	AVG ("f"."length") > 110;
	
-- P21 ¿Cuál es la media de duración del alquiler de las películas?
select AVG("rental_duration") as "Media_duración_alquiler"
from "film";

-- P22 Crea una columna con el nombre y apellidos de todos los actores y actrices.
select CONCAT("first_name", ' ', "last_name")
from "actor";

-- P23 Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select 
	date("rental_date") as "fecha",
	count(date("rental_date")) 
from "rental"
group by date("rental_date")
order by count(date("rental_date")) desc;
	
-- P24 Encuentra las películas con una duración superior al promedio.
select 
	"title",
	"length"
from "film"
where "length" > (
	select AVG("length")
	from "film"
);

-- P25 Averigua el número de alquileres registrados por mes.
select
	extract(month from "rental_date") as "Mes",
	count(rental_id) as "Alquileres"
from "rental"
group by "mes"
order by "mes" ASC;

-- P26 Encuentra el promedio, la desviación estándar y varianza del total pagado.
select
	AVG(amount) as "Promedio",
	VARIANCE(amount) as "Varianza",
	STDDEV(amount) as "Desviación Estándar"
from "payment"
;

-- P27 ¿Qué películas se alquilan por encima del precio medio?
select
	"title",
	"rental_rate"
from "film"
where "rental_rate" > (
	select AVG("rental_rate")
	from "film"
);

-- P28 Muestra el id de los actores que hayan participado en más de 40 películas.
select  
	CONCAT("a"."first_name", ' ', "a"."last_name") as "Nombre",
	COUNT("fa"."film_id") as "Cantidad películas"
from "film_actor" as "fa"
inner join "actor" as "a" on "fa"."actor_id" = "a"."actor_id"
group by CONCAT("a"."first_name", ' ', "a"."last_name")
having COUNT("fa"."film_id") > 40
order by COUNT("fa"."film_id") DESC;

-- P29 Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
select 
	"f"."title" as "Película",
	COUNT("i"."inventory_id") as "Cantidad disponible"
from "inventory" as "i"
inner join "film" as "f" on "i"."film_id" = "f"."film_id"
group by "f"."title"
order by "f"."title" asc;


-- P30 Obtener los actores y el número de películas en las que ha actuado.
select  
	CONCAT("a"."first_name", ' ', "a"."last_name") as "Nombre",
	COUNT("fa"."film_id") as "Cantidad películas"
from "film_actor" as "fa"
inner join "actor" as "a" on "fa"."actor_id" = "a"."actor_id"
group by CONCAT("a"."first_name", ' ', "a"."last_name");

-- P31 Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select 
	"f"."title" as "Película", 
	CONCAT("a"."first_name", ' ', "a"."last_name") as "Nombre actor"
from "film" as f
left join "film_actor" as "fa" on "f"."film_id" = "fa"."film_id"
inner join "actor" as "a" on "fa"."actor_id" = "a"."actor_id"
order by "f"."title" asc;

-- P32 Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select 
	CONCAT("a"."first_name", ' ', "a"."last_name") as "Nombre actor",
	"f"."title" as "Película"
from "film" as f
right join "film_actor" as "fa" on "f"."film_id" = "fa"."film_id"
inner join actor as a on "fa"."actor_id" = "a"."actor_id"
order by "Nombre actor" asc;

-- P33 Obtener todas las películas que tenemos y todos los registros de alquiler.
select
	"f"."title" as "Película",
	"r"."rental_id" as "ID Alquiler"
from "film" as "f"
inner join "inventory" as "i" on "f"."film_id" = "i"."film_id"
inner join "rental" as "r" on "i"."inventory_id" = "r"."inventory_id"
order by "f"."title" asc;

-- P34 Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select
	"customer_id" as "Cliente",
	sum("amount") as "Gasto total"
from "payment"
group by "Cliente"
order by sum("amount") desc
limit 5;

-- P35 Selecciona todos los actores cuyo primer nombre es ' Johnny'.
select "first_name" as "Nombre", "last_name" as "Apellido"
from "actor"
where "first_name" = 'JOHNNY'

-- P36 Renombra la columna “first_name” como Nombre y “last_name” como Apellido.

alter table "actor" rename column "first_name" to "Nombre";
alter table "actor" rename column "last_name" to "Apellido";

-- P37 Encuentra el ID del actor más bajo y más alto en la tabla actor.
select
	MIN("actor_id") as "ID mínimo",
	MAX("actor_id") as "ID máximo"
from actor 

-- P38 Cuenta cuántos actores hay en la tabla “actor”
select COUNT("actor_id") as "Cantidad actores"
from "actor";

-- P39 Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select "Nombre", "Apellido"
from "actor"
order by "Apellido" asc;

-- P40 Selecciona las primeras 5 películas de la tabla “film”
select "title"
from "film"
limit 5; 

-- P41 Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido? 
select 
	distinct("Nombre") as "Nombres únicos",
	count("Nombre") as "Frecuencia"
from "actor"
group by "Nombres únicos" 
order by "Frecuencia" desc;
-- *** Los nombres más repetidos son Julia, Kenneth y Penelope ***

-- P42 Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select 
	CONCAT(c.first_name, ' ' , c.last_name) as "Nombre cliente",
	"rental_id" as "ID Alquiler"
from "rental" as "r"
inner join "customer" as "c" on "r"."customer_id" = "c"."customer_id"

-- P43 Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select 
	CONCAT(c.first_name, ' ' , c.last_name) as "Nombre cliente",
	"rental_id" as "ID Alquiler"
from "customer" as "c"
left join "rental" as "r" on "c"."customer_id" = "r"."customer_id" 

-- P44 Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select "f"."title", c.name
from "film" as "f"
cross join category as "c"
-- *** no, esta contestación no aporta valor, ya que devuelve todas las posibles combinaciones entre ambas tablas, aunque no tengoan mayor relación *** 

-- P45 Encuentra los actores que han participado en películas de la categoría 'Action'.
select 
	CONCAT ("a"."Nombre",' ',"a"."Apellido") as "Nombre actor", 
	"c"."name" as "Categoría"
from "actor" as "a"
inner join "film_actor" as "fa" on "a"."actor_id" = "fa"."actor_id"
inner join "film" as "f" on "fa"."film_id" = "f"."film_id"
inner join "film_category" as "fc" on "f"."film_id" = "fc"."film_id"
inner join "category" as "c" on "fc"."category_id" = "c"."category_id"
where "c"."name" = 'Action';

-- P46 Encuentra todos los actores que no han participado en películas.
select 
	CONCAT("a"."Nombre",' ', "a"."Apellido") as "Nombre actor", 
	"fa"."film_id" as "ID Película"
from "film_actor" as "fa"
inner join "actor" as "a" on "fa"."actor_id" = "a"."actor_id"
where "fa"."film_id" is null;

-- P47 Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select 
	CONCAT("a"."Nombre",' ', "a"."Apellido") as "Nombre actor", 
	count("fa"."film_id") as "Cantidad Películas"
from "film_actor" as "fa"
inner join "actor" as "a" on "fa"."actor_id" = "a"."actor_id"
group by "Nombre actor";

-- P48 Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.
create view "Actor_num_películas" as
	select 
		CONCAT("a"."Nombre",' ', "a"."Apellido") as "Nombre actor", 
		count("fa"."film_id") as "Cantidad Películas"
	from "film_actor" as "fa"
	inner join "actor" as "a" on "fa"."actor_id" = "a"."actor_id"
	group by "Nombre actor";

-- P49 Calcula el número total de alquileres realizados por cada cliente.
select 
	c.customer_id as "ID Cliente", 
	COUNT(r.rental_id) as "Cantidad alquileres"
from customer as c
inner join rental as r on c.customer_id = r.customer_id
group by "ID Cliente"
order by "ID Cliente" asc
;

-- P50 Calcula la duración total de las películas en la categoría 'Action'.
select 
	c.name as "Categoría", 
	sum(f.length) as "Duración total"
from film as f
inner join film_category as fc on f.film_id = fc.film_id
inner join category as c on fc.category_id = c.category_id
group by c."name"
having c.name = 'Action'
;

-- P51 Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
 -- ** Del enunciado, se considera "el total de alquileres por cliente" como el listado de todos los alquileres.
create view "cliente_rentas_temporal" as
	select 
		c.customer_id as "ID Cliente", 
		r.rental_id as "ID Alquiler"
	from customer as c
	inner join rental as r on c.customer_id = r.customer_id
	order by "ID Cliente" asc
;

-- P52 Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
create view "Películas alquiladas" as
select 
	i.film_id as "ID Película", 
	count (r.rental_id) as "Veces alquiladas"
from inventory as i 
inner join rental as r on i.inventory_id = r.inventory_id
group by "ID Película"
having count(r.rental_id) >= 10
order by "ID Película"
;

-- P53 Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
select 
	CONCAT(c.first_name ,' ', c.last_name) as "Nombre cliente",
	f.title as "Película"
from customer as c
inner join rental as r on c.customer_id = r.customer_id
inner join inventory as i on r.inventory_id = i.inventory_id
inner join film as f on i.film_id = f.film_id
where CONCAT(c.first_name ,' ', c.last_name) = 'TAMMY SANDERS' and r.return_date is null 
order by "Película" ASC
;

-- P54 Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
select 
	CONCAT("a"."Apellido",', ',"a"."Nombre") as "Actor",
	COUNT("c"."name") as "Num películas SCI-FI"
from "category" as "c" 
inner join "film_category" as "fc" on "c"."category_id" = "fc"."category_id"
inner join "film_actor" as "fa" on "fc"."film_id" = "fa"."film_id"
inner join "actor" as "a" on "fa"."actor_id" = "a"."actor_id"
where "c"."name" = 'Sci-Fi'
group by "Actor"
order by "Actor";

-- P55 Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
select "Nombre actor"
from (
	select 
		CONCAT(a."Apellido", ', ', a."Nombre") as "Nombre actor",
		r.rental_id, 
		date(r.rental_date)
	from rental as r
	inner join inventory as i on r.inventory_id = i.inventory_id
	inner join film_actor as fa on i.film_id = fa.film_id
	inner join actor as a on fa.actor_id = a.actor_id
	where date(r.rental_date) > (
		select 
			min(date(r.rental_date)) as "fecha mínima"
		from rental as r
		inner join inventory as i on r.inventory_id = i.inventory_id
		inner join film as f on i.film_id = f.film_id
		where f.title = 'SPARTACUS CHEAPER'
		)
	) as "Tabla actores"
group by "Nombre actor"
order by "Nombre actor";

-- P56 Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
select 
	CONCAT("a"."Nombre",' ', "a"."Apellido") as "Actor"
from "category" as "c"
inner join "film_category" as "fc" on "c"."category_id" = "fc"."category_id"
inner join "film_actor" as "fa" on "fc"."film_id" = "fa".film_id
inner join "actor" as "a" on "fa"."actor_id" = "a"."actor_id"
where "c"."name" <> 'Music'
group by "Actor";

-- P57 Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select 
	r.rental_id as "ID Alquiler",
	"f"."title" as "Película",
	(date("r"."return_date")-date("r"."rental_date")) as "Días alquiler"
from "rental" as "r"
inner join "inventory" as "i" on "r"."inventory_id" = "i".inventory_id
inner join "film" as "f" on "i"."film_id" = "f"."film_id"
where (date("return_date")-date("rental_date")) > 8;

-- P58 Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’
select "f"."title" as "Película"
from "category" as "c"
inner join "film_category" as "fc" on "fc"."category_id" = "c"."category_id"
inner join "film" as "f" on "fc"."film_id" = "f"."film_id"
where "c"."name" = 'Animation';

-- P59 Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
select 
	"f"."title",
	"f".length
from "film" as "f"
where "f"."length" = (
	select f2.length
	from film as f2
	where title = 'DANCING FEVER'
	)
order by "f"."title" asc
offset 1;

-- P60 Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
select 
	CONCAT(c.last_name,', ', c.first_name) as "Cliente", 
	count(i.film_id) as "Alquileres películas distintas"
from customer c 
inner join rental r on c.customer_id = r.customer_id
inner join inventory i on r.inventory_id = i.inventory_id
group by "Cliente"
having count(i.film_id) >= 7
order by "Cliente" ASC;

-- P61 Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

create view "Películas_alquileres" as
select
	i.film_id,
	count(r.rental_id) as "Cantidad alquileres"
from rental as r
inner join inventory as i on r.inventory_id = i.inventory_id
group by i.film_id;

select 
	c.name as "Categoría",
	COUNT(pa.film_id) as "Cantidad Películas",
	SUM(pa."Cantidad alquileres") as "Total alquileres"
from film_category as fc
inner join "Películas_alquileres" as pa on fc.film_id = pa.film_id
inner join category as c on fc.category_id = c.category_id
group by "Categoría";

-- P62 Encuentra el número de películas por categoría estrenadas en 2006.
select 
	"c"."name" as "Categoría",
	COUNT(f.film_id) as "Total estrenos 2006"
from film as f
inner join film_category as fc on f.film_id = fc.film_id
inner join category as c on fc.category_id = c.category_id 
where f.release_year = 2006
group by "Categoría";

-- P63 Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select 
	CONCAT(s.first_name,' ',s.last_name),
	s2.store_id
from staff as s
cross join store as s2;

-- P64 Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
select 
	c.customer_id as "ID Cliente",
	CONCAT(c.first_name,' ', c.last_name) as "Cliente",
	count(i.film_id) as "Cantidad películas alquiladas"
from customer as c
inner join rental as r on c.customer_id = r.customer_id
inner join inventory as i on r.inventory_id = i.inventory_id
group by "ID Cliente"
order by "ID Cliente" ASC;


