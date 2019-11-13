USE meeting;

/* Список домов */
select CONCAT('г.', citys.city,' ', regions.region) as city_reg, concat(streets.street,' д.', h.house) as street_hous,
       h.apartments,h.living_space, h.total_area, h.year_of__construction
       from houses as h 
       JOIN streets on h.city_id = streets.id
       JOIN citys on h.city_id = citys.id
       JOIN regions on citys.code_region= regions.code_reg
       ORDER by regions.region , citys.city
       ;

select * from meeting_house where region LIKE 'Чел%';
       

/* Список собственников */             
select CONCAT('г.', c.city, ', ул.', s.street,  ', дом ', h.house, ' кв. ' , o.apartment) as 'адрес', 
       CONCAT(lastname, ' ',firstname , ' ', patronymic) as 'Собственник' ,
        o.share as 'доля',  ROUND(((o.living_space / h.living_space) * o.share), 4)
       from users as u
       JOIN owners as o on u.id=o.users_id
       JOIN houses as h on o.houses_id = h.id
       JOIN streets as s on h.street_id = s.id
       JOIN citys as c on h.city_id = c.id
       WHERE h.id = 69      
       ;

SELECT * from meeting_owns 
where city='Юрюзань'  AND
      street= 'Улица Борьбы' AND
      house= '82';
      
/* Список собраний и инициатора */     
select c.city, s.street, h.house, m.start_date, m.end_date, 
CONCAT(u.lastname, ' ',LEFT(u.firstname,1),'. ', LEFT(u.patronymic,1), '.') as 'init',
meeting_status(m.id) as 'status'
       FROM meetings as m
       JOIN houses as h on h.id=m.houses_id
       JOIN meeting_init as mi on m.id=mi.meetings_id
       JOIN users as u on u.id = mi.user_id
       JOIN streets as s on s.id =h.street_id
       JOIN citys as c on c.id = h.city_id
       JOIN regions as r on r.code_reg= c.code_region
       where h.id = 69
       ;

SELECT * from meeting_m; 

/* Повестка дня ОСС */ 
select question as 'Повестка дня ОСС' from agendas as a 
       JOIN meetings as m on m.id=a.meetings_id
       WHERE m.id=104;
/* Решения ОСС */ 
select solution as 'Решения ОСС' from agendas as a 
       JOIN meetings as m on m.id=a.meetings_id
       WHERE m.id=104;
      
/*количествo участников в собраниях и доля от общего числа */          
SELECT m.id, count(p.owners_id) as 'принили участие', 
       ROUND(sum(o.share * o.living_space),2) as 'количество голосов',
       ROUND(sum(o.share * o.living_space)/h.living_space *100, 2) as 'доля от общего числа'
       from meetings as m
       JOIN participants as p on m.id =p.meetings_id
       JOIN owners as o on p.owners_id=o.id
       JOIN houses as h on h.id=m.houses_id
       WHERE m.id = 104
       GROUP BY p.meetings_id ;
 
/*Список собственников принявших участие в голосовании */
SELECT u.lastname, u.firstname, u.patronymic, o.apartment, o.share as 'принили участие'      
from meetings as m
JOIN participants as p on m.id =p.meetings_id
JOIN owners as o on p.owners_id=o.id
JOIN houses as h on h.id=m.houses_id
JOIN users as u on u.id = o.users_id
WHERE m.id = 104
GROUP BY p.owners_id ;     

/*Решения собственника на ОСС  */

SELECT u.lastname,u.firstname, u.patronymic,o.apartment, a.solution, s.solution from  solutions as s
JOIN agendas as a on a.id= s.agendas_id
JOIN participants as p on p.id= s.participant_id
JOIN owners as o on o.id= p.owners_id
JOIN users as u on u.id=o.users_id
JOIN meetings as m on m.id= p.meetings_id
where m.id=104 and u.id = 88;

;
       
 /* результаты голосования*/
call rezult(104);      

/*  проверка работы триггера */

INSERT INTO participants (meetings_id, owners_id)
VALUES
(100, 77)



INSERT INTO owners (houses_id, apartment, inventory_num, living_space, users_id, 
share, date_title, statement_num)
VALUES 
(86, 1, '74:36:0815121:1517', 30, 4, 0.25, '1991-02-02', '1517');