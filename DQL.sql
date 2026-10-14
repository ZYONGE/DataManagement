/* ████████████████████████████████████████████████████████████
   DQL — 데이터 질의어 (Data Query Language)
   ------------------------------------------------------------
   테이블에서 원하는 데이터를 "읽어 오는" 명령. SELECT 하나뿐이다.
   (교재에 따라 DML에 포함시키기도 하지만, 데이터를 바꾸지 않는다는
    점이 INSERT/UPDATE/DELETE 와 완전히 달라 따로 묶었다.)

   SELECT 문의 절(clause) 작성 순서와 실제 실행 순서는 다르다.
     작성 순서 : SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY
     실행 순서 : FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY
   → WHERE 절에서 SELECT 절의 별칭을 못 쓰는 이유가 여기에 있다.
     (ORDER BY 는 SELECT 다음에 실행되므로 별칭을 쓸 수 있다.)
   ████████████████████████████████████████████████████████████ */


/* ============================================================
   [1] 접속 확인용 조회
   ------------------------------------------------------------
   - HELP 는 Oracle이 제공하는 도움말 테이블이다.
   - 설치 직후 "접속이 되는지" 확인하는 용도로 한 번 돌려 보는 쿼리.
   ============================================================ */
select * from HELP;


/* ============================================================
   [2] 전체 조회 : SELECT *
   ------------------------------------------------------------
   문법 : SELECT 속성명 FROM 테이블명(객체명);
   - * (애스터리스크)는 "모든 컬럼"을 의미한다.
   - 컬럼 순서는 테이블을 만들 때 정의한 순서대로 출력된다.
   - 실습용으로는 편하지만, 실무에서는 필요한 컬럼만 적는 것이 좋다.
     (네트워크 낭비 + 테이블 구조가 바뀌면 결과가 달라진다)
   ============================================================ */
select * from player;


/* ============================================================
   [3] 특정 컬럼 조회 + 별칭(ALIAS) : AS
   ------------------------------------------------------------
   문법 : SELECT 컬럼명 [AS] 별칭 FROM 테이블명;
   - 조회할 컬럼을 쉼표(,)로 구분해 원하는 것만 나열한다.
   - AS 별칭 : 결과 화면에 표시되는 컬럼 제목만 바꾼다.
     (실제 테이블의 컬럼명은 바뀌지 않음)
   - AS 는 생략 가능 → e_player_name 영문이름 도 같은 의미.
   - 별칭에 공백·특수문자가 있거나 대소문자를 그대로 살리려면
     큰따옴표로 감싼다. 예) e_player_name AS "English Name"
   ============================================================ */
select player_name, e_player_name as 영문이름 from player;


/* ============================================================
   [4] 정렬 : ORDER BY
   ------------------------------------------------------------
   문법 : SELECT ... FROM ... ORDER BY 컬럼명 [ASC | DESC];
   - ASC  : 오름차순 (작은 값 → 큰 값), 기본값이라 생략 가능
   - DESC : 내림차순 (큰 값 → 작은 값)
   - ORDER BY 는 항상 SELECT 문의 "맨 마지막"에 위치한다.
   - Oracle에서 NULL은 가장 큰 값으로 취급되어
     ASC일 때 맨 뒤, DESC일 때 맨 앞에 나온다.
   - 정렬 기준 컬럼은 SELECT 목록에 없어도 사용할 수 있다.
   ============================================================ */
select back_no from player
order by back_no asc;

-- 선수 ID·이름·등번호·포지션을 등번호 오름차순으로
select player_id, player_name, back_no, position from player
order by back_no asc;

/* 주의 : player_id 가 문자형(VARCHAR2)이면 숫자 크기가 아니라
   "문자열 사전순"으로 비교된다. 예) '9' 가 '10' 보다 크다 ('9' > '1') */
select player_id, player_name from player
order by player_id desc;


/* ============================================================
   [5] 조건 검색 : WHERE
   ------------------------------------------------------------
   문법 : SELECT ... FROM ... WHERE 조건 [ORDER BY ...];
   - WHERE 절 : 조건이 참(TRUE)인 행(row)만 결과에 남긴다.
   - 문자 값은 작은따옴표(' ')로 감싼다. → 'MF'
   - 컬럼명(POSITION / position)은 대소문자를 구분하지 않지만,
     따옴표 안의 "데이터 값"은 대소문자를 구분한다. ('mf' ≠ 'MF')
   - 비교 연산자 : =  <>(또는 !=)  >  <  >=  <=
   ============================================================ */
-- 포지션이 미드필더인 선수를 키 오름차순으로
select player_id, POSITION, height from player
where position = 'MF'
order by height asc;

-- 특정 팀 소속 선수만
select player_id, player_name, team_id from player
where team_id = 'K06';


/* ============================================================
   [6] 산술 연산자와 파생 컬럼 : + - * /
   ------------------------------------------------------------
   문법 : SELECT 컬럼 연산자 값 [AS 별칭] FROM ... WHERE 식 비교 값;
   - SELECT 절에 계산식을 쓰면 테이블에 없는 "파생 컬럼"이 만들어진다.
     원본 데이터는 전혀 바뀌지 않는다. 화면에만 계산 결과가 보인다.
   - 연산 우선순위는 수학과 같다. ( ) → * / → + -
   - WHERE 절에서도 같은 계산식을 쓸 수 있다. 다만 SELECT 절에서 붙인
     별칭(balance)은 WHERE 에서 쓸 수 없어 식을 다시 적어야 한다.
     (실행 순서가 WHERE → SELECT 이기 때문. 맨 위 설명 참고)
   - 계산에 쓰이는 값이 NULL 이면 결과도 NULL 이 된다.
   ============================================================ */
-- 표준체중 대비 여유분(balance)이 양수인 선수
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


/* ============================================================
   [7] 연결 연산자 : ||
   ------------------------------------------------------------
   문법 : SELECT 컬럼 || '문자열' [AS 별칭] FROM 테이블명;
   - || 는 값을 "이어 붙여" 하나의 문자열로 만든다. (Oracle 표준)
   - 숫자 컬럼이라도 자동으로 문자로 바뀌어 붙는다.
   - 결과 컬럼 제목이 식 전체로 길게 나오므로 별칭을 붙이는 것이 보통이다.
   - 별칭에 공백이 있으므로 큰따옴표가 반드시 필요하다. → "선수 신장"
   ============================================================ */
SELECT
    player_name,
    height || 'cm' AS "선수 신장"
FROM
    player;


/* ============================================================
   [8] 부분 일치 검색 : LIKE 와 와일드카드
   ------------------------------------------------------------
   문법 : WHERE 컬럼 [NOT] LIKE '패턴';
   - %  : 0글자 이상의 아무 문자   ( '김%'  → 김으로 시작 )
   - _  : 정확히 1글자            ( '김_'  → 김 + 한 글자 )
   - '%우%'  → 어느 위치든 '우'가 들어가면 일치
   - 와일드카드가 없는 LIKE 'TP1' 은 = 'TP1' 과 결과가 같다.
   - 앞쪽에 % 를 붙이면('%우%') 인덱스를 못 타서 느려진다.
   ============================================================ */
-- 성이 '김'인 선수
select player_name
from player
where player_name like '김%';

-- 이름 아무 곳에나 '우'가 들어간 선수
SELECT *
FROM PLAYER
WHERE PLAYER_NAME LIKE '%우%';


/* ============================================================
   [9] NULL 판별 : IS NULL / IS NOT NULL
   ------------------------------------------------------------
   문법 : WHERE 컬럼 IS [NOT] NULL;
   - NULL 은 "값이 없음"이지 0이나 빈 문자열이 아니다.
   - ★ = NULL, <> NULL 로는 절대 찾을 수 없다. 결과가 참도 거짓도 아닌
     UNKNOWN 이 되어 한 행도 안 나온다. 반드시 IS NULL 을 써야 한다.
   - NULL 이 섞인 산술 연산의 결과도 NULL 이다. ([6] 참고)
   ============================================================ */
SELECT
    player_name,
    nation
FROM
    player
WHERE
    nation IS NOT NULL;


/* ============================================================
   [10] 범위 검색 : BETWEEN ... AND
   ------------------------------------------------------------
   문법 : WHERE 컬럼 [NOT] BETWEEN 하한 AND 상한;
   - 양쪽 끝 값을 "포함"한다. (170, 180 둘 다 결과에 들어감)
   - 하한과 상한의 순서를 바꿔 쓰면 한 건도 안 나온다.
   - 아래 두 쌍은 각각 완전히 같은 결과를 낸다. BETWEEN 은 비교 연산자
     두 개를 짧게 쓴 것뿐이라는 점을 확인해 둘 것.
   ============================================================ */
-- (A) BETWEEN
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

-- (A') 위와 동치 : >= 와 <= 를 AND 로 묶은 형태
SELECT
    player_name,
    position,
    height
FROM
    player
WHERE
        height >= 170
    AND height <= 180;

-- (B) NOT BETWEEN : 범위 "밖"
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

-- (B') 위와 동치 : < 와 > 를 OR 로 묶은 형태
--     NOT (A AND B) = (NOT A) OR (NOT B)  → AND가 OR로 바뀌는 점에 주의
SELECT
    player_name,
    position,
    height
FROM
    player
WHERE
    height < 170
    OR height > 180;


/* ============================================================
   [11] 목록 검색 : IN
   ------------------------------------------------------------
   문법 : WHERE 컬럼 IN (값1, 값2, ...);
          WHERE (컬럼1, 컬럼2) IN ( (값1, 값2), (값3, 값4) );   ← 다중 컬럼
   - IN 은 "이 목록 중 하나라도 같으면" 참. OR 를 짧게 쓴 것이다.
   - 다중 컬럼 IN : 괄호로 묶인 컬럼 쌍과 값 쌍이 "통째로" 일치해야 한다.
     (team_id, position) IN (('K04','GK'), ...) 는
     team_id='K04' "그리고" position='GK' 인 조합만 찾는다.
     → 컬럼 순서와 값 순서가 1:1로 맞아야 한다.
   ============================================================ */
-- 공격수 중 K01 소속, 수비수 중 K04 소속
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

-- (C) 다중 컬럼 IN
select player_name, team_id, position
from player
where (team_id, position) in (('K04', 'GK'),('K06','MF'));

-- (C') 위와 동치 : AND 로 묶은 조합을 OR 로 연결
--      IN 이 어떻게 풀리는지 보여 주는 형태. 괄호를 빼면 의미가 달라진다.
--      (AND 가 OR 보다 우선순위가 높지만, 괄호를 쓰는 편이 안전하다)
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


/* ============================================================
   [12] 부정 조건 : NOT IN / NOT (...) 과 드모르간 법칙
   ------------------------------------------------------------
   문법 : WHERE (컬럼1, 컬럼2) NOT IN ( (값1, 값2), ... );
   - [11]의 (C) 를 뒤집은 조건이다.
   - 드모르간 법칙
       NOT (A AND B)        = (NOT A) OR (NOT B)
       NOT (A OR  B)        = (NOT A) AND (NOT B)
     → 부정을 괄호 안으로 밀어 넣으면 AND 와 OR 가 서로 바뀐다.
   - 아래 (D)와 (D')는 같은 결과, (D'')는 "다른" 결과다. 비교해 볼 것.
   - ★ NOT IN 주의 : 목록 안에 NULL 이 하나라도 있으면 결과가 0건이 된다.
   ============================================================ */
-- (D) NOT IN
SELECT
    player_name,
    position,
    team_id
FROM
    player
WHERE
    ( team_id, position ) NOT IN ( ( 'K04', 'GK' ), ( 'K06', 'MF' ) );

-- (D') 위와 동치 : 조합 전체에 NOT 을 씌워 AND 로 연결
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

-- (D'') 비교용 : 흔히 하는 착각. 위와 결과가 다르다.
--       NOT (A AND B) 는 (NOT A) OR (NOT B) 인데
--       아래는 (NOT A) AND (NOT B) 라서 조건이 훨씬 빡빡하다.
--       예) team_id='K04' 이고 position='FW' 인 선수는
--           (D)·(D')에는 나오지만 (D'')에는 나오지 않는다.
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


/* ████ 종합 실습 — 지금까지의 조건·연산·정렬을 섞어서 ████████ */

/* ============================================================
   [13-1] IN + AND + 다중 정렬
   ------------------------------------------------------------
   - ORDER BY 에 컬럼을 쉼표로 여러 개 적으면 "앞 컬럼 먼저" 정렬하고,
     값이 같을 때만 다음 컬럼으로 순서를 가린다.
   - 정렬 방향(ASC/DESC)은 컬럼마다 따로 지정한다.
   ============================================================ */
SELECT PLAYER_NAME, POSITION, HEIGHT, WEIGHT
FROM PLAYER
WHERE POSITION IN ('FW', 'MF')
  AND HEIGHT >= 180
  AND WEIGHT >= 75
ORDER BY HEIGHT DESC, WEIGHT DESC;


/* ============================================================
   [13-2] LIKE + BETWEEN + <> 를 AND 로 묶기
   ------------------------------------------------------------
   - 성격이 다른 조건(부분일치 / 범위 / 부등호)도 AND 로 얼마든지 연결된다.
   - <> 는 "같지 않다". != 로 써도 같다.
   ============================================================ */
SELECT PLAYER_NAME, POSITION, HEIGHT
FROM PLAYER
WHERE PLAYER_NAME LIKE '%김%'
  AND HEIGHT BETWEEN 175 AND 185
  AND POSITION <> 'GK'
ORDER BY HEIGHT ASC;


/* ============================================================
   [13-3] NOT LIKE + 한글 별칭으로 정렬
   ------------------------------------------------------------
   - NOT LIKE '%월드컵%' : 이름에 '월드컵'이 들어가지 않는 경기장.
   - ORDER BY 는 실행 순서상 SELECT 다음이라 별칭을 그대로 쓸 수 있다.
     여기서는 원본 컬럼명(SEAT_COUNT)으로 정렬했지만
     "수용인원" 이라고 적어도 똑같이 동작한다.
   ============================================================ */
SELECT STADIUM_NAME AS "경기장명",
       SEAT_COUNT   AS "수용인원"
FROM STADIUM
WHERE STADIUM_NAME NOT LIKE '%월드컵%'
  AND SEAT_COUNT BETWEEN 20000 AND 50000
ORDER BY SEAT_COUNT DESC;


/* ============================================================
   [13-4] (A AND B) OR (C AND D)
   ------------------------------------------------------------
   - "공격수인데 키가 크거나, 수비수인데 몸무게가 많이 나가거나"
   - AND 가 OR 보다 먼저 계산되지만, 괄호로 묶어야 의도가 분명해진다.
   ============================================================ */
SELECT PLAYER_NAME, POSITION, HEIGHT, WEIGHT
FROM PLAYER
WHERE (POSITION = 'FW' AND HEIGHT >= 185)
   OR (POSITION = 'DF' AND WEIGHT >= 80)
ORDER BY HEIGHT DESC;


/* ============================================================
   [13-5] 함수로 계산한 파생 컬럼 : ROUND, POWER
   ------------------------------------------------------------
   문법 : ROUND(숫자, 자릿수)   → 반올림. 2면 소수 둘째 자리까지
          POWER(밑, 지수)       → 거듭제곱. POWER(x, 2) = x의 제곱
   - BMI = 몸무게(kg) / 키(m)^2 → HEIGHT 가 cm 단위라 /100 으로 m 로 바꾼다.
   - WHERE 절에 HEIGHT > 0 을 넣은 이유 : 0으로 나누면 ORA-01476 오류.
     IS NOT NULL 과 함께 "계산이 깨지는 행"을 미리 걸러 내는 방어 조건이다.
   - ORDER BY "BMI" : 큰따옴표 별칭으로 정렬. 별칭을 그대로 쓸 때는
     대소문자까지 똑같이 적어야 한다.
   ============================================================ */
SELECT PLAYER_NAME                                   AS "선수명",
       HEIGHT                                        AS "키",
       WEIGHT                                        AS "몸무게",
       ROUND(WEIGHT / POWER(HEIGHT / 100, 2), 2)     AS "BMI"
FROM PLAYER
WHERE HEIGHT IS NOT NULL
  AND WEIGHT IS NOT NULL
  AND HEIGHT > 0
  AND WEIGHT / POWER(HEIGHT / 100, 2) >= 25
ORDER BY "BMI" DESC;


/* ============================================================
   [13-6] 컬럼끼리 빼서 파생 컬럼 만들기
   ------------------------------------------------------------
   - 상수가 아니라 "컬럼 - 컬럼" 도 당연히 계산된다.
   - WHERE 에도 같은 식을 쓸 수 있다. (별칭 "득점차" 는 WHERE 에서 불가)
   - 점수가 NULL 인 미경기 행은 식 결과가 NULL 이라 조건에서 빠진다.
   ============================================================ */
SELECT SCHE_DATE,
       HOMETEAM_ID,
       AWAYTEAM_ID,
       HOME_SCORE,
       AWAY_SCORE,
       HOME_SCORE - AWAY_SCORE AS "득점차"
FROM SCHEDULE
WHERE HOME_SCORE - AWAY_SCORE >= 2
ORDER BY "득점차" DESC;


/* ============================================================
   [13-7] 계산식 + OR + 부등호를 모두 섞은 조건
   ------------------------------------------------------------
   - 조건 세 개를 AND 로 묶고, 그중 하나는 OR 를 괄호로 감쌌다.
   - ORDER BY 에 별칭과 원본 컬럼을 함께 쓸 수 있다.
     1순위 "총득점" 내림차순, 같으면 2순위 날짜 오름차순.
   ============================================================ */
SELECT SCHE_DATE,
       HOMETEAM_ID,
       AWAYTEAM_ID,
       HOME_SCORE,
       AWAY_SCORE,
       HOME_SCORE + AWAY_SCORE AS "총득점"
FROM SCHEDULE
WHERE HOME_SCORE + AWAY_SCORE >= 4
  AND (HOME_SCORE >= 3 OR AWAY_SCORE >= 3)
  AND HOME_SCORE <> AWAY_SCORE
ORDER BY "총득점" DESC, SCHE_DATE ASC;
