use meeting;

drop procedure if exists rezult;
DELIMITER //
CREATE PROCEDURE rezult(in value int)
BEGIN
    select a.solution, all_p(a.id, a.meetings_id) as 'ВСЕГО',
 true_p(a.id, a.meetings_id) as 'ЗА', 
 round(true_p(a.id, a.meetings_id)/all_p(a.id, a.meetings_id)*100,2) as '%',
 false_p(a.id, a.meetings_id) as 'ПРОТИВ',
 round(false_p(a.id, a.meetings_id)/all_p(a.id, a.meetings_id)*100,2) as '%',
 null_p(a.id, a.meetings_id) as 'ВOЗД.',
 round(null_p(a.id, a.meetings_id)/all_p(a.id, a.meetings_id)*100,2) as '%'
 from agendas as a
 where meetings_id=value;
END
//

DROP FUNCTION IF EXISTS meeting_status //
CREATE FUNCTION meeting_status (value int)
RETURNS varchar(25)  not DETERMINISTIC
BEGIN  
	   set @start_d := (select start_date from meetings where id = value);
       set @end_d := (select end_date from meetings where id = value);
	   SET @meeting_chare := (SELECT ROUND(sum(o.share * o.living_space),2)   
       from meetings as m
       JOIN participants as p on m.id =p.meetings_id
       JOIN owners as o on p.owners_id=o.id
       JOIN houses as h on h.id=m.houses_id
       WHERE m.id = value
       GROUP BY p.meetings_id) ;
       set @meeting_liv := (select h.living_space   
       from meetings as m
       JOIN participants as p on m.id =p.meetings_id
       JOIN owners as o on p.owners_id=o.id
       JOIN houses as h on h.id=m.houses_id
       WHERE m.id = value
       GROUP BY p.meetings_id) ;
      if (now()>@end_d) THEN      
          if (@meeting_chare/@meeting_liv * 100<=50 or @meeting_chare is null) THEN     
               RETURN 'Несостоялось';
          else
               RETURN 'Завершено';
          end if;
       else
          if (now()>= @start_d) then
               RETURN 'Идет голосование'; 
          else
             RETURN 'не началось'; 
          end if;  
       end if;
END 
//

DROP FUNCTION IF EXISTS true_p //
CREATE FUNCTION true_p (agen int, met int)
RETURNS FLOAT  not DETERMINISTIC
BEGIN
	set @rezult := (select sum(o.share * o.living_space) from solutions s
    JOIN participants p on p.id=s.participant_id
    JOIN owners o on o.id=p.owners_id
    where s.solution ='true' and s.agendas_id= agen and p.meetings_id =met
    group by s.agendas_id);
    RETURN ROUND(@rezult,2);
END 
//

DROP FUNCTION IF EXISTS false_p //
CREATE FUNCTION false_p (agen int, met int)
RETURNS FLOAT  not DETERMINISTIC
BEGIN
	set @rezult := (select sum(o.share * o.living_space) from solutions s
    JOIN participants p on p.id=s.participant_id
    JOIN owners o on o.id=p.owners_id
    where s.solution ='false' and s.agendas_id= agen and p.meetings_id =met
    group by s.agendas_id);
    RETURN ROUND(@rezult,2);
END 
//

DROP FUNCTION IF EXISTS null_p //
CREATE FUNCTION null_p (agen int, met int)
RETURNS FLOAT  not DETERMINISTIC
BEGIN
	set @rezult := (select sum(o.share * o.living_space) from solutions s
    JOIN participants p on p.id=s.participant_id
    JOIN owners o on o.id=p.owners_id
    where s.solution ='null' and s.agendas_id= agen and p.meetings_id =met
    group by s.agendas_id);
    RETURN ROUND(@rezult,2);
END 
//

DROP FUNCTION IF EXISTS all_p //
CREATE FUNCTION all_p (agen int, met int)
RETURNS FLOAT  not DETERMINISTIC
BEGIN
	set @rezult := (select sum(o.share * o.living_space) from solutions s
    JOIN participants p on p.id=s.participant_id
    JOIN owners o on o.id=p.owners_id
    where s.agendas_id= agen and p.meetings_id =met
    group by s.agendas_id);
    RETURN ROUND(@rezult,2);
END 
//