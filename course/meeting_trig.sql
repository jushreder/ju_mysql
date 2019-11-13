use meeting;

DROP TRIGGER IF EXISTS insert_part;
DELIMITER //
CREATE TRIGGER insert_part BEFORE INSERT ON participants
FOR EACH ROW
BEGIN
	DECLARE date_p date;
    select meetings.end_date  INTO date_p FROM meetings
    where meetings.id= NEW.meetings_id;     
    IF  date_p < now() then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'голосование закончено';
    END IF;
   select meetings.start_date  INTO date_p FROM meetings
    where meetings.id= NEW.meetings_id; 
    IF  date_p > now() then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'голосование не началось';
    END IF;

END//


DROP TRIGGER IF EXISTS insert_owners;
DELIMITER //
CREATE TRIGGER insert_owners BEFORE INSERT ON owners
FOR EACH ROW
BEGIN
	DECLARE share_sum  float;
    select sum(share) into share_sum from owners 
    WHERE apartment=new.apartment and houses_id =new.houses_id and expiration_date is NULL;
    if share_sum+  new.share > 1 then
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'указана неверная доля в квартире';
    end if;
END //