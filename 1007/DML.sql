SELECT
    *
FROM
    player;

/* 산술 연산자의 사용으로 파생 컬럼 생성 */
SELECT
    player_name,
    ( height - 100 ) * 0.9 - weight AS balance
FROM
    player
WHERE
    ( height - 100 ) * 0.9 - weight > 0;

SELECT
    player_name,
    height,
    height + 100
FROM
    player
WHERE
    player_name = '김경태';

SELECT
    player_name,
    nation
FROM
    player
WHERE
    nation IS NOT NULL;

SELECT
    player_name,
    height || 'cm' AS "선수 신장"
FROM
    player;

/* Between */
SELECT
    player_name,
    position,
    height
FROM
    player
WHERE
    height BETWEEN 170 AND 180
ORDER BY
    height;

SELECT
    player_name,
    position,
    height
FROM
    player
WHERE
    height NOT BETWEEN 170 AND 180
ORDER BY
    height;

/* IN */

SELECT
    player_name,
    team_id,
    position
FROM
    player
WHERE
    ( team_id, position ) IN ( ( 'K01', 'FW' ), ( 'K04', 'DF' ) )
ORDER BY
    team_id;
    
select player_name, team_id, position
from player
where (team_id, position) in (('K04', 'GK'),('K06','MF'));


/* 1 */
SELECT
    player_name 선수이름,
    team_id,
    position
FROM
    player
WHERE
    ( team_id = 'K04'
      AND position = 'GK' )
    OR ( team_id = 'K06'
         AND position = 'MF' );

/* 2 */
SELECT
    player_name 선수이름,
    team_id,
    position
FROM
    player
WHERE
    NOT ( team_id = 'K04'
          AND position = 'GK' )
        AND NOT ( team_id = 'K06'
                  AND position = 'MF' );