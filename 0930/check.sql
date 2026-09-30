describe TEAM;
desc TEAM;
desc stadium;
desc schedule;
desc player;

select * from player;
/* select 속성명 from 테이블명(객체명) */

select player_name, e_player_name as 영문이름 from player;


select back_no from player
order by back_no asc;

/*1*/
select player_id, player_name, back_no, position from player
order by back_no asc;
/*2*/
select player_id, player_name from player
order by player_id desc;
/*3*/
select player_id, POSITION, height from player
where position = 'MF'
order by height asc;



select player_id, player_name, team_id from player
where team_id = 'K06'
