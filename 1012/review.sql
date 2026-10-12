SELECT
    player_name,
    position,
    height
FROM
    player
WHERE
    height BETWEEN 170 AND 180;

SELECT
    player_name,
    position,
    height
FROM
    player
WHERE
        height >= 170
    AND height <= 180;

SELECT
    player_name,
    position,
    height
FROM
    player
WHERE
    height < 170
    OR height > 180;

SELECT
    player_name,
    position,
    team_id
FROM
    player
WHERE
    ( team_id, position ) IN ( ( 'K04', 'GK' ), ( 'K06', 'MF' ) );

SELECT
    player_name,
    position,
    team_id
FROM
    player
WHERE
    ( team_id = 'K04'
      AND position = 'GK' )
    OR ( team_id = 'K06'
         AND position = 'MF' );

SELECT
    player_name,
    position,
    team_id
FROM
    player
WHERE
    ( team_id, position ) NOT IN ( ( 'K04', 'GK' ), ( 'K06', 'MF' ) );

SELECT
    player_name,
    position,
    team_id
FROM
    player
WHERE
    ( team_id <> 'K04'
      AND position <> 'GK' )
    AND ( team_id <> 'K06'
          AND position <> 'MF' );