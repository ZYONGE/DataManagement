select player_name
from player
where player_name like '김%';

insert into player (player_id, player_name, team_id, birth_date) values('29990','손흥민','K07','2000-01-01');

insert into player values ('29991','이승우','K07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

select * from stadium;

INSERT ALL
    INTO stadium (stadium_id, stadium_name)
    VALUES ('TP1', '임시경기장 1')
    INTO stadium (stadium_id, stadium_name)
    VALUES ('TP2', '임시경기장 2')
SELECT * FROM dual;

select *
from stadium
where stadium_id like 'TP1';

select *
from stadium
where stadium_id like 'TP2';


update stadium set stadium_name = '우리경기장'
where stadium_id = 'TP2';

delete from stadium
where stadium_id = 'TP1';

/* 1 */
SELECT *
FROM PLAYER
WHERE PLAYER_NAME LIKE '%우%';

/* 2 */
INSERT INTO STADIUM (
    STADIUM_ID,
    STADIUM_NAME,
    HOMETEAM_ID,
    SEAT_COUNT,
    TEL
)
VALUES (
    'S05',
    'Jeju Stadium',
    'T05',
    15000,
    '742-0000'
);

/* 3 */
INSERT INTO TEAM (
    TEAM_ID,
    REGION_NAME,
    TEAM_NAME,
    E_TEAM_NAME,
    ORIG_YYYY,
    STADIUM_ID,
    ZIP_CODE1,
    OWNER
)
VALUES (
    'T05',
    'Jeju',
    'Jeju Sharks',
    'JEJU SHARKS',
    '2025',
    'S05',
    '630',
    'J-Corp'
);

/* 4 */
UPDATE SCHEDULE
SET HOME_SCORE = 5,
    AWAY_SCORE = 3
WHERE STADIUM_ID = 'S05'
  AND SCHE_DATE = '20250601';


