	###(INIT 시작)
	# DB 세팅
	DROP DATABASE IF EXISTS `24_08_Spring`;
	CREATE DATABASE `24_08_Spring`;
	USE `24_08_Spring`;

	# 게시글 테이블 생성
	CREATE TABLE article(
	      id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	      regDate DATETIME NOT NULL,
	      updateDate DATETIME NOT NULL,
	      title CHAR(100) NOT NULL,
	      `body` TEXT NOT NULL
	);

	# 회원 테이블 생성
	CREATE TABLE `member`(
	      id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	      regDate DATETIME NOT NULL,
	      updateDate DATETIME NOT NULL,
	      loginId CHAR(30) NOT NULL,
	      loginPw CHAR(100) NOT NULL,
	      `authLevel` SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '권한 레벨 (3=일반,7=관리자)',
	      `name` CHAR(20) NOT NULL,
	      nickname CHAR(20) NOT NULL,
	      cellphoneNum CHAR(20) NOT NULL,
	      email CHAR(50) NOT NULL,
	      delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴 여부 (0=탈퇴 전, 1=탈퇴 후)',
	      delDate DATETIME COMMENT '탈퇴 날짜'
	);



	## 게시글 테스트 데이터 생성
	INSERT INTO article
	SET regDate = NOW(),
	updateDate = NOW(),
	title = '제목1',
	`body` = '내용1';

	INSERT INTO article
	SET regDate = NOW(),
	updateDate = NOW(),
	title = '제목2',
	`body` = '내용2';

	INSERT INTO article
	SET regDate = NOW(),
	updateDate = NOW(),
	title = '제목3',
	`body` = '내용3';

	INSERT INTO article
	SET regDate = NOW(),
	updateDate = NOW(),
	title = '제목4',
	`body` = '내용4';


	## 회원 테스트 데이터 생성
	## (관리자)
	INSERT INTO `member`
	SET regDate = NOW(),
	updateDate = NOW(),
	loginId = 'admin',
	loginPw = 'admin',
	`authLevel` = 7,
	`name` = '관리자',
	nickname = '관리자',
	cellphoneNum = '01012341234',
	email = 'abc@gmail.com';

	## (일반)
	INSERT INTO `member`
	SET regDate = NOW(),
	updateDate = NOW(),
	loginId = 'test1',
	loginPw = 'test1',
	`name` = '회원1_이름',
	nickname = '회원1_닉네임',
	cellphoneNum = '01043214321',
	email = 's3496h@gmail.com';

	## (일반)
	INSERT INTO `member`
	SET regDate = NOW(),
	updateDate = NOW(),
	loginId = 'test2',
	loginPw = 'test2',
	`name` = '회원2_이름',
	nickname = '회원2_닉네임',
	cellphoneNum = '01056785678',
	email = 'abcde@gmail.com';

	ALTER TABLE article ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER updateDate;

	UPDATE article
	SET memberId = 2
	WHERE id IN (1,2);

	UPDATE article
	SET memberId = 3
	WHERE id IN (3,4);


	# 게시판(board) 테이블 생성
	CREATE TABLE board (
	      id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	      regDate DATETIME NOT NULL,
	      updateDate DATETIME NOT NULL,
	      `code` CHAR(50) NOT NULL UNIQUE COMMENT 'notice(공지사항) free(자유) QnA(질의응답) ...',
	      `name` CHAR(20) NOT NULL UNIQUE COMMENT '게시판 이름',
	      delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0=삭제 전, 1=삭제 후)',
	      delDate DATETIME COMMENT '삭제 날짜'
	);

	## 게시판(board) 테스트 데이터 생성
	INSERT INTO board
	SET regDate = NOW(),
	updateDate = NOW(),
	`code` = 'NOTICE',
	`name` = '공지사항';

	INSERT INTO board
	SET regDate = NOW(),
	updateDate = NOW(),
	`code` = 'FREE',
	`name` = '자유';

	INSERT INTO board
	SET regDate = NOW(),
	updateDate = NOW(),
	`code` = 'QnA',
	`name` = '질의응답';

	ALTER TABLE article ADD COLUMN boardId INT(10) UNSIGNED NOT NULL AFTER `memberId`;

	UPDATE article
	SET boardId = 1
	WHERE id IN (1,2);

	UPDATE article
	SET boardId = 2
	WHERE id = 3;

	UPDATE article
	SET boardId = 3
	WHERE id = 4;

	ALTER TABLE article ADD COLUMN hitCount INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `body`;



	# reactionPoint 테이블 생성
	CREATE TABLE reactionPoint(
	    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	    regDate DATETIME NOT NULL,
	    updateDate DATETIME NOT NULL,
	    memberId INT(10) UNSIGNED NOT NULL,
	    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
	    relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
	    `point` INT(10) NOT NULL
	);

	# reactionPoint 테스트 데이터 생성
	# 1번 회원이 1번 글에 싫어요
	INSERT INTO reactionPoint
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 1,
	relTypeCode = 'article',
	relId = 1,
	`point` = -1;

	# 1번 회원이 2번 글에 좋아요
	INSERT INTO reactionPoint
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 1,
	relTypeCode = 'article',
	relId = 2,
	`point` = 1;

	# 2번 회원이 1번 글에 싫어요
	INSERT INTO reactionPoint
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 2,
	relTypeCode = 'article',
	relId = 1,
	`point` = -1;

	# 2번 회원이 2번 글에 싫어요
	INSERT INTO reactionPoint
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 2,
	relTypeCode = 'article',
	relId = 2,
	`point` = -1;

	# 3번 회원이 1번 글에 좋아요
	INSERT INTO reactionPoint
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 3,
	relTypeCode = 'article',
	relId = 1,
	`point` = 1;

	# article 테이블에 reactionPoint(좋아요) 관련 컬럼 추가
	ALTER TABLE article ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;
	ALTER TABLE article ADD COLUMN badReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

	# update join -> 기존 게시글의 good bad RP 값을 RP 테이블에서 추출해서 article table에 채운다
	UPDATE article AS A
	INNER JOIN (
	    SELECT RP.relTypeCode, Rp.relId,
	    SUM(IF(RP.point > 0,RP.point,0)) AS goodReactionPoint,
	    SUM(IF(RP.point < 0,RP.point * -1,0)) AS badReactionPoint
	    FROM reactionPoint AS RP
	    GROUP BY RP.relTypeCode,Rp.relId
	) AS RP_SUM
	ON A.id = RP_SUM.relId
	SET A.goodReactionPoint = RP_SUM.goodReactionPoint,
	A.badReactionPoint = RP_SUM.badReactionPoint;

	# reply 테이블 생성
	CREATE TABLE reply (
	    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	    regDate DATETIME NOT NULL,
	    updateDate DATETIME NOT NULL,
	    memberId INT(10) UNSIGNED NOT NULL,
	    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
	    relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
	    `body`TEXT NOT NULL
	);

	# 2번 회원이 1번 글에 댓글 작성
	INSERT INTO reply
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 2,
	relTypeCode = 'article',
	relId = 1,
	`body` = '댓글 1';

	# 2번 회원이 1번 글에 댓글 작성
	INSERT INTO reply
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 2,
	relTypeCode = 'article',
	relId = 1,
	`body` = '댓글 2';

	# 3번 회원이 1번 글에 댓글 작성
	INSERT INTO reply
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 3,
	relTypeCode = 'article',
	relId = 1,
	`body` = '댓글 3';

	# 3번 회원이 1번 글에 댓글 작성
	INSERT INTO reply
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 2,
	relTypeCode = 'article',
	relId = 2,
	`body` = '댓글 4';


	# reply 테이블에 좋아요 관련 컬럼 추가
	ALTER TABLE reply ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;
	ALTER TABLE reply ADD COLUMN badReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

	# reactionPoint 테스트 데이터 생성
	# 1번 회원이 1번 댓글에 싫어요
	INSERT INTO reactionPoint
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 1,
	relTypeCode = 'reply',
	relId = 1,
	`point` = -1;

	# 1번 회원이 2번 댓글에 좋아요
	INSERT INTO reactionPoint
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 1,
	relTypeCode = 'reply',
	relId = 2,
	`point` = 1;

	# 2번 회원이 1번 댓글에 싫어요
	INSERT INTO reactionPoint
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 2,
	relTypeCode = 'reply',
	relId = 1,
	`point` = -1;

	# 2번 회원이 2번 댓글에 싫어요
	INSERT INTO reactionPoint
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 2,
	relTypeCode = 'reply',
	relId = 2,
	`point` = -1;

	# 3번 회원이 1번 댓글에 좋아요
	INSERT INTO reactionPoint
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 3,
	relTypeCode = 'reply',
	relId = 1,
	`point` = 1;

	# update join -> 기존 게시물의 good,bad RP 값을 RP 테이블에서 가져온 데이터로 채운다
	UPDATE reply AS R
	INNER JOIN (
	    SELECT RP.relTypeCode,RP.relId,
	    SUM(IF(RP.point > 0, RP.point, 0)) AS goodReactionPoint,
	    SUM(IF(RP.point < 0, RP.point * -1, 0)) AS badReactionPoint
	    FROM reactionPoint AS RP
	    GROUP BY RP.relTypeCode, RP.relId
	) AS RP_SUM
	ON R.id = RP_SUM.relId
	SET R.goodReactionPoint = RP_SUM.goodReactionPoint,
	R.badReactionPoint = RP_SUM.badReactionPoint;

	# 파일 테이블 추가
	CREATE TABLE genFile (
	  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT, # 번호
	  regDate DATETIME DEFAULT NULL, # 작성날짜
	  updateDate DATETIME DEFAULT NULL, # 갱신날짜
	  delDate DATETIME DEFAULT NULL, # 삭제날짜
	  delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0, # 삭제상태(0:미삭제,1:삭제)
	  relTypeCode CHAR(50) NOT NULL, # 관련 데이터 타입(article, member)
	  relId INT(10) UNSIGNED NOT NULL, # 관련 데이터 번호
	  originFileName VARCHAR(100) NOT NULL, # 업로드 당시의 파일이름
	  fileExt CHAR(10) NOT NULL, # 확장자
	  typeCode CHAR(20) NOT NULL, # 종류코드 (common)
	  type2Code CHAR(20) NOT NULL, # 종류2코드 (attatchment)
	  fileSize INT(10) UNSIGNED NOT NULL, # 파일의 사이즈
	  fileExtTypeCode CHAR(10) NOT NULL, # 파일규격코드(img, video)
	  fileExtType2Code CHAR(10) NOT NULL, # 파일규격2코드(jpg, mp4)
	  fileNo SMALLINT(2) UNSIGNED NOT NULL, # 파일번호 (1)
	  fileDir CHAR(20) NOT NULL, # 파일이 저장되는 폴더명
	  PRIMARY KEY (id),
	  KEY relId (relTypeCode,relId,typeCode,type2Code,fileNo)
	);

	# 기존의 회원 비번을 암호화
	UPDATE `member`
	SET loginPw = SHA2(loginPw,256);

-- 상품 테이블 생성
CREATE TABLE product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    DESCRIPTION TEXT,
    regDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    updateDate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    category VARCHAR(255) NOT NULL DEFAULT 'Uncategorized' -- 카테고리 컬럼 추가
);

-- 상품 디테일 테이블
CREATE TABLE product_details (
    productId INT PRIMARY KEY,
    DESCRIPTION TEXT,
    FOREIGN KEY (productId) REFERENCES product(id)
);

-- 상품 리뷰 테이블
CREATE TABLE product_reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    memberId INT NOT NULL,
    productId INT NOT NULL,
    content TEXT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    regDate DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- 상품 사이즈 테이블
CREATE TABLE product_sizes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    productId INT,
    size VARCHAR(10),
    FOREIGN KEY (productId) REFERENCES product(id) -- 외래키 추가
);

-- 상품 색상 테이블
CREATE TABLE product_colors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    productId INT,
    color VARCHAR(20),
    FOREIGN KEY (productId) REFERENCES product(id) -- 외래키 추가
);
CREATE TABLE cart (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,  -- 장바구니 ID
    memberId BIGINT NOT NULL,                     -- 사용자 ID (참조용)
    productId BIGINT NOT NULL,                  -- 상품 ID (참조용)
    quantity INT NOT NULL,                       -- 상품 수량
    regdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- 상품이 장바구니에 추가된 날짜
);
CREATE TABLE orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,  -- 주문 ID
    memberId BIGINT NOT NULL,                      -- 사용자 ID (참조용)
    regDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- 주문 날짜
    total_amount DECIMAL(10, 2) NOT NULL,        -- 총 주문 금액
    STATUS VARCHAR(20) DEFAULT 'Pending'          -- 주문 상태 (예: Pending, Completed, Cancelled)
);
-- 상품 테스트 데이터 삽입
INSERT INTO product (NAME, price, DESCRIPTION, stock, category) VALUES
('남성 캐주얼 셔츠', 29900, '남성을 위한 스타일리시한 캐주얼 셔츠.', 100, 'men'),
('여성 우아한 드레스', 49900, '여성을 위한 우아한 드레스.', 50, 'women'),
('뷰티 세럼', 79900, '피부를 재생시키는 뷰티 세럼.', 200, 'beauty'),
('브랜드 시계', 199000, '유명 브랜드의 럭셔리 시계.', 30, 'brand'),
('Top 10 트렌드 스니커즈', 129000, '이번 시즌 가장 인기 있는 스니커즈.', 75, 'ranking');

-- 사이즈 데이터 삽입
INSERT INTO product_sizes (productId, size) VALUES
(1, 'S'),
(1, 'M'),
(1, 'L'),
(1, 'XL'),
(2, 'S'),
(2, 'M'),
(2, 'L'),
(3, '50ml'),
(3, '100ml'),
(4, 'One Size'),
(5, '6'),
(5, '7'),
(5, '8'),
(5, '9'),
(5, '10');

-- 색상 데이터 삽입
INSERT INTO product_colors (productId, color) VALUES
(1, 'Blue'),
(1, 'Red'),
(2, 'Black'),
(2, 'White'),
(3, 'Clear'),
(4, 'Silver'),
(4, 'Gold'),
(5, 'Black'),
(5, 'White');
-- 주문 테스트데이터
INSERT INTO orders (memberId, total_amount, regdate, STATUS)
VALUES
    (1, 150.75, NOW(), 'Completed'),   -- 사용자 ID 1의 완료된 주문
    (2, 200.50, NOW(), 'Pending'),      -- 사용자 ID 2의 대기 중인 주문
    (1, 75.00, NOW(), 'Cancelled'),      -- 사용자 ID 1의 취소된 주문
    (3, 99.99, NOW(), 'Completed'),     -- 사용자 ID 3의 완료된 주문
    (4, 120.00, NOW(), 'Pending'),      -- 사용자 ID 4의 대기 중인 주문
    (2, 50.25, NOW(), 'Completed');     -- 사용자 ID 2의 완료된 주문
 -- 장바구니 테스트데이터   
INSERT INTO cart (memberId, productId, quantity, regdate)
VALUES
    (1, 101, 2, NOW()),  -- 사용자 ID 1이 제품 ID 101을 2개 추가
    (1, 102, 1, NOW()),  -- 사용자 ID 1이 제품 ID 102를 1개 추가
    (2, 103, 5, NOW()),  -- 사용자 ID 2가 제품 ID 103을 5개 추가
    (2, 104, 1, NOW()),  -- 사용자 ID 2가 제품 ID 104를 1개 추가
    (3, 101, 3, NOW()),  -- 사용자 ID 3이 제품 ID 101을 3개 추가
    (4, 105, 2, NOW()),  -- 사용자 ID 4가 제품 ID 105를 2개 추가
    (4, 106, 4, NOW());  -- 사용자 ID 4가 제품 ID 106을 4개 추가

###(INIT 끝)
##########################################


SELECT *
FROM article
ORDER BY id DESC;

SELECT * FROM product_reviews;

SELECT * FROM `member`;

SELECT * FROM `reactionPoint`;

SELECT * FROM `reply`;

SELECT * FROM `genFile`;


###############################################################################

SELECT R.*, M.nickname AS extra__writer
			FROM reply AS R
			INNER JOIN `member` AS M
			ON R.memberId = M.id
			WHERE relTypeCode = 'article'
			AND relId = 2
			ORDER BY R.id ASC;

SELECT IFNULL(SUM(RP.point),0)
FROM reactionPoint AS RP
WHERE RP.relTypeCode = 'article'
AND RP.relId = 3
AND RP.memberId = 2

-- 상품 테이블에 데이터 삽입
INSERT INTO product (NAME, price, stock, DESCRIPTION, category)
SELECT
    CONCAT('Product ', FLOOR(RAND() * 1000)), -- 랜덤한 제품 이름
    ROUND(RAND() * 1000, 2), -- 랜덤한 가격 (0.00부터 1000.00까지)
    FLOOR(RAND() * 100) + 1, -- 랜덤한 재고 (1부터 100까지)
    CONCAT('Description for ', CONCAT('Product ', FLOOR(RAND() * 1000))), -- 랜덤한 설명
    CASE -- 랜덤한 카테고리
        WHEN RAND() < 0.2 THEN 'men'
        WHEN RAND() < 0.4 THEN 'women'
        WHEN RAND() < 0.6 THEN 'beauty'
        WHEN RAND() < 0.8 THEN 'brand'
        ELSE 'ranking'
    END
FROM
    (SELECT @rownum := @rownum + 1 AS rownum FROM
    (SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1) a,
    (SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1) b,
    (SELECT @rownum := 0) r
    LIMIT 100) temp;
    -- 상품 리뷰 테이블에 데이터 삽입
INSERT INTO product_reviews (product_id, user_name, content, rating, review_date)
SELECT
    p.id,
    CONCAT('User ', FLOOR(RAND() * 1000)), -- 랜덤한 사용자 이름 생성 (예: User 123)
    CONCAT('This is a review for product ', p.id), -- 랜덤한 리뷰 내용 생성
    FLOOR(RAND() * 5) + 1, -- 랜덤한 별점 생성 (1부터 5까지)
    CURRENT_TIMESTAMP -- 현재 시간
FROM
    product p
JOIN
    (SELECT @rownum := @rownum + 1 AS rownum FROM
    (SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1) a,
    (SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1) b,
    (SELECT @rownum := 0) r
    LIMIT 500) temp
ON p.id = temp.rownum;
-- 상품 사이즈 테이블에 데이터 삽입
INSERT INTO product_sizes (product_id, size)
SELECT
    p.id,
    CASE -- 랜덤한 사이즈
        WHEN RAND() < 0.3 THEN 'S'
        WHEN RAND() < 0.6 THEN 'M'
        WHEN RAND() < 0.9 THEN 'L'
        ELSE 'XL'
    END
FROM
    product p
JOIN
    (SELECT @rownum := @rownum + 1 AS rownum FROM
    (SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1) a,
    (SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1) b,
    (SELECT @rownum := 0) r
    LIMIT 500) temp
ON p.id = temp.rownum;
-- 상품 색상 테이블에 데이터 삽입
INSERT INTO product_colors (product_id, color)
SELECT
    p.id,
    CASE -- 랜덤한 색상
        WHEN RAND() < 0.25 THEN 'Red'
        WHEN RAND() < 0.5 THEN 'Blue'
        WHEN RAND() < 0.75 THEN 'Green'
        ELSE 'Yellow'
    END
FROM
    product p
JOIN
    (SELECT @rownum := @rownum + 1 AS rownum FROM
    (SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1) a,
    (SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1) b,
    (SELECT @rownum := 0) r
    LIMIT 500) temp
ON p.id = temp.rownum;
## 게시글 테스트 데이터 대량 생성
INSERT INTO article
(
    regDate, updateDate, memberId, boardId, title, `body`
)
SELECT NOW(), NOW(), FLOOR(RAND() * 2) + 2, FLOOR(RAND() * 3) + 1, CONCAT('제목__', RAND()), CONCAT('내용__', RAND())
FROM article;


SELECT FLOOR(RAND() * 2) + 2

SELECT FLOOR(RAND() * 3) + 1


INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = CONCAT('제목__', RAND()),
`body` = CONCAT('내용__', RAND());

SHOW FULL COLUMNS FROM `member`;
DESC `member`;

SELECT *
FROM article
WHERE boardId = 1
ORDER BY id DESC;

SELECT *
FROM article
WHERE boardId = 2
ORDER BY id DESC;

SELECT *
FROM article
WHERE boardId = 3
ORDER BY id DESC;

'111'

SELECT COUNT(*) AS cnt
FROM article
WHERE boardId = 1
ORDER BY id DESC;

SELECT *
FROM article
WHERE boardId = 1 AND title LIKE '%123%'
ORDER BY id DESC;

SELECT *
FROM article
WHERE boardId = 1 AND `body` LIKE '%123%'
ORDER BY id DESC;

SELECT *
FROM article
WHERE boardId = 1 AND title LIKE '%123%' OR `body` LIKE '%123%'
ORDER BY id DESC;

SELECT COUNT(*)
FROM article AS A
WHERE A.boardId = 1 
ORDER BY A.id DESC;

boardId=1&searchKeywordTypeCode=nickname&searchKeyword=1

SELECT COUNT(*)
FROM article AS A
WHERE A.boardId = 1 AND A.memberId = 3
ORDER BY A.id DESC;

SELECT hitCount
FROM article WHERE id = 3

SELECT * FROM `reactionPoint`;

SELECT A.* , M.nickname AS extra__writer
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id
WHERE A.id = 1

# LEFT JOIN
SELECT A.*, M.nickname AS extra__writer, RP.point
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id
LEFT JOIN reactionPoint AS RP
ON A.id = RP.relId AND RP.relTypeCode = 'article'
GROUP BY A.id
ORDER BY A.id DESC;

# 서브쿼리
SELECT A.*, 
IFNULL(SUM(RP.point),0) AS extra__sumReactionPoint,
IFNULL(SUM(IF(RP.point > 0,RP.point,0)),0) AS extra__goodReactionPoint,
IFNULL(SUM(IF(RP.point < 0,RP.point,0)),0) AS extra__badReactionPoint
FROM (
    SELECT A.*, M.nickname AS extra__writer 
    FROM article AS A
    INNER JOIN `member` AS M
    ON A.memberId = M.id) AS A
LEFT JOIN reactionPoint AS RP
ON A.id = RP.relId AND RP.relTypeCode = 'article'
GROUP BY A.id
ORDER BY A.id DESC;

# JOIN
SELECT A.*, M.nickname AS extra__writer,
IFNULL(SUM(RP.point),0) AS extra__sumReactionPoint,
IFNULL(SUM(IF(RP.point > 0,RP.point,0)),0) AS extra__goodReactionPoint,
IFNULL(SUM(IF(RP.point < 0,RP.point,0)),0) AS extra__badReactionPoint
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id
LEFT JOIN reactionPoint AS RP
ON A.id = RP.relId AND RP.relTypeCode = 'article'
GROUP BY A.id
ORDER BY A.id DESC;

SELECT IFNULL(SUM(RP.point),0) 
FROM reactionPoint AS RP
WHERE RP.relTypeCode = 'article'
AND RP.relId = 3
AND RP.memberId = 1;

SELECT A.*, M.nickname AS extra__writer, IFNULL(COUNT(R.id),0) AS extra__repliesCount
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id
LEFT JOIN `reply` AS R
ON A.id = R.relId
GROUP BY A.id

