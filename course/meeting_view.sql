use meeting;

DROP VIEW  IF EXISTS meeting_m;
CREATE VIEW meeting_m AS SELECT m.id, c.city, s.street, h.house, m.start_date, m.end_date, 
CONCAT(u.lastname, ' ',LEFT(u.firstname,1),'. ', LEFT(u.patronymic,1), '.') as 'init',
meeting_status(m.id) as 'status'
       FROM meetings as m
       JOIN houses as h on h.id=m.houses_id
       JOIN meeting_init as mi on m.id=mi.meetings_id
       JOIN users as u on u.id = mi.user_id
       JOIN streets as s on s.id =h.street_id
       JOIN citys as c on c.id = h.city_id
       JOIN regions as r on r.code_reg= c.code_region;
      
DROP VIEW  IF EXISTS meeting_house;
CREATE VIEW meeting_house AS SELECT h.id, citys.city, regions.region, streets.street, h.house,
       h.apartments,h.living_space, h.total_area, h.year_of__construction
       from houses as h 
       JOIN streets on h.city_id = streets.id
       JOIN citys on h.city_id = citys.id
       JOIN regions on citys.code_region= regions.code_reg
       ORDER by regions.region , citys.city;

DROP VIEW  IF EXISTS meeting_owns;
CREATE VIEW meeting_owns AS SELECT h.id, c.city, s.street, h.house, o.apartment, 
       lastname, firstname, patronymic,
        o.share, ROUND(((o.living_space / h.living_space) * o.share), 4) as hous_share
       from users as u
       JOIN owners as o on u.id=o.users_id
       JOIN houses as h on o.houses_id = h.id
       JOIN streets as s on h.street_id = s.id
       JOIN citys as c on h.city_id = c.id;

