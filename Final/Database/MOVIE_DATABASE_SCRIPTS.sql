DROP DATABASE IF EXISTS MOVIES_DATABASE;
CREATE DATABASE MOVIES_DATABASE CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI;
USE MOVIES_DATABASE;

DROP TABLE IF EXISTS USERS;
CREATE TABLE USERS (
    USER_ID INT PRIMARY KEY,
    USERNAME VARCHAR(255) NOT NULL,
    EMAIL VARCHAR(255) NOT NULL,
    PASSWORD VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS MOVIES;
CREATE TABLE MOVIES (
    MOVIE_ID INT PRIMARY KEY,
    TITLE VARCHAR(255) NOT NULL,
    RELEASE_DATE DATE,
    GENRE VARCHAR(255)
);

DROP TABLE IF EXISTS MOVIE_IMAGES;
CREATE TABLE MOVIE_IMAGES (
    IMAGE_ID INT PRIMARY KEY,
    MOVIE_ID INT,
    IMAGE_URL VARCHAR(255) NOT NULL,
    FOREIGN KEY (MOVIE_ID) REFERENCES MOVIES(MOVIE_ID)
);

DROP TABLE IF EXISTS CLIPS;
CREATE TABLE CLIPS (
    CLIP_ID INT PRIMARY KEY,
    MOVIE_ID INT,
    CLIP_URL VARCHAR(255) NOT NULL,
    FOREIGN KEY (MOVIE_ID) REFERENCES MOVIES(MOVIE_ID)
);

DROP TABLE IF EXISTS REVIEWS;
CREATE TABLE REVIEWS (
    REVIEW_ID INT PRIMARY KEY,
    USER_ID INT,
    MOVIE_ID INT,
    RATING DECIMAL(3, 1) NOT NULL,
    COMMENT TEXT,
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
    FOREIGN KEY (MOVIE_ID) REFERENCES MOVIES(MOVIE_ID)
);

DROP TABLE IF EXISTS LIKES_DISLIKES;
CREATE TABLE LIKES_DISLIKES (
    LIKE_ID INT PRIMARY KEY,
    USER_ID INT,
    MOVIE_ID INT,
    IS_LIKE BOOLEAN NOT NULL,
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
    FOREIGN KEY (MOVIE_ID) REFERENCES MOVIES(MOVIE_ID)
);

DROP TABLE IF EXISTS PEOPLE;
CREATE TABLE PEOPLE (
    PERSON_ID INT PRIMARY KEY,
    NAME VARCHAR(255) NOT NULL,
    OCCUPATION VARCHAR(255),
    IMAGE_URL VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS MOVIE_PEOPLE;
CREATE TABLE MOVIE_PEOPLE (
    MOVIE_ID INT,
    PERSON_ID INT,
    PRIMARY KEY (MOVIE_ID,PERSON_ID),
    FOREIGN KEY (MOVIE_ID) REFERENCES MOVIES(MOVIE_ID),
    FOREIGN KEY (PERSON_ID) REFERENCES PEOPLE(PERSON_ID)
);





INSERT INTO USERS (USER_ID, USERNAME, EMAIL, PASSWORD)
VALUES
    (1, 'Alice', 'alice@email.com', 'password123'),
    (2, 'Bob', 'bob@email.com', 'secret456')
;


INSERT INTO MOVIES (MOVIE_ID, TITLE, RELEASE_DATE, GENRE)
VALUES
    (101, 'Inception', '2010-07-16', 'Science Fiction'),
    (102, 'The Dark Knight', '2008-07-18', 'Action'),
    (103, 'The Shawshank Redemption', '1994-09-22', 'Drama')
;


INSERT INTO MOVIE_IMAGES (IMAGE_ID, MOVIE_ID, IMAGE_URL)
VALUES

    -- Inception
    (1001, 101, 'https://image.tmdb.org/t/p/original/xymM5aW6MDcH5AR9I3CamSegJd6.jpg'),
    (1002, 101, 'https://2.bp.blogspot.com/-Oc8wpBqF0T8/T8iUAPdIjWI/AAAAAAAAAK8/13_3WQsSIOY/s1600/inception-movie-poster2.jpg'),
    (1003, 101, 'https://th.bing.com/th/id/R.5e602579be841695cf06f8dcdba1b60d?rik=VeMoDknliJw5Xw&riu=http%3a%2f%2fwww.impawards.com%2f2010%2fposters%2finception_ver2_xlg.jpg&ehk=JHYUvXQQlAb%2fbVDfB5yxnVFWnKu6ImRgq9f0iPQIGrE%3d&risl=&pid=ImgRaw&r=0'),
    (1004, 101, 'https://image.tmdb.org/t/p/original/eM2Y0RN3mUwp40Nm9I22Slgzl4c.jpg'),
    (1005, 101, 'https://th.bing.com/th/id/OIP.vgeaus8Zvvh2ACkRmCVDFQAAAA?pid=ImgDet&w=440&h=660&rs=1'),

    -- The Dark Night
    (1006, 102, 'https://www.themoviedb.org/t/p/original/eP5NL7ZlGoW9tE9qnCdHpOLH1Ke.jpg'),
    (1007, 102, 'https://th.bing.com/th/id/OIP.fc_FKhmrZ6YTdPTVKAJKEwHaLG?pid=ImgDet&w=474&h=710&rs=1'),
    (1008, 102, 'https://th.bing.com/th/id/OIP.NumWC-Sw1BFgi8ax3f2JnAHaLH?pid=ImgDet&w=474&h=711&rs=1'),
    (1009, 102, 'https://cdn.shopify.com/s/files/1/1416/8662/products/dark_knight_2008_joker_style_teaser_original_film_art_2000x.jpg?v=1562541481'),
    (1010, 102, 'https://payload.cargocollective.com/1/10/320683/10018575/cc_1200.JPG'),

    -- The Shawshank Redemption
    (1011, 103, 'https://m.media-amazon.com/images/M/MV5BNDE3ODcxYzMtY2YzZC00NmNlLWJiNDMtZDViZWM2MzIxZDYwXkEyXkFqcGdeQXVyNjAwNDUxODI@._V1_.jpg'),
    (1012, 103, 'https://static-01.daraz.pk/p/8950eef7ff576d795965be4aef33f648.jpg'),
    (1013, 103, 'https://i.pinimg.com/474x/04/5d/54/045d5428c1d3588758c1ad5ed3e7c260.jpg'),
    (1014, 103, 'https://www.tallengestore.com/cdn/shop/products/Movie_Poster_Art_-_The_Shawshank_Redemption_-_Tallenge_Hollywood_Poster_Collection_9e0e143e-20a5-4e91-b757-2c38daa34d41.jpg?v=1578138055'),
    (1015, 103, 'https://media.posterlounge.com/img/products/630000/624786/624786_poster.jpg')
;


INSERT INTO CLIPS (CLIP_ID, MOVIE_ID, CLIP_URL)
VALUES
    (2001, 101, 'https://www.youtube.com/watch?v=YoHD9XEInc0&pp=ygURaW5jZXB0aW9uIHRyYWlsZXI%3D'),
    (2002, 101, 'https://www.youtube.com/watch?v=8hP9D6kZseM&pp=ygUKaW5jZXB0aW9uIA%3D%3D'),
    (2003, 101, 'https://www.youtube.com/watch?v=v8yrZSkKxTA'),
    (2004, 101, 'https://www.youtube.com/watch?v=i9zjvUywVG8&pp=ygUKaW5jZXB0aW9uIA%3D%3D'),


    (2005, 102, 'https://www.youtube.com/watch?v=EXeTwQWrcwY&pp=ygUQdGhlIGRhcmsga25pZ2h0IA%3D%3D'),
    (2006, 102, 'https://www.youtube.com/watch?v=jane6C4rIwc&pp=ygUQdGhlIGRhcmsga25pZ2h0IA%3D%3D'),
    (2007, 102, 'https://www.youtube.com/watch?v=vetKTtM7YyU&pp=ygUQdGhlIGRhcmsga25pZ2h0IA%3D%3D'),
    (2008, 102, 'https://www.youtube.com/watch?v=TQfATDZY5Y4&pp=ygUQdGhlIGRhcmsga25pZ2h0IA%3D%3D'),


    (2009, 103, 'https://www.youtube.com/watch?v=PLl99DlL6b4&pp=ygUUc2hhd3NoYW5rIHJlZGVtcHRpb24%3D'),
    (2010, 103, 'https://www.youtube.com/watch?v=njJ41irPjTc&pp=ygUUc2hhd3NoYW5rIHJlZGVtcHRpb24%3D'),
    (2011, 103, 'https://www.youtube.com/watch?v=ABpeLNCuE3w&pp=ygUUc2hhd3NoYW5rIHJlZGVtcHRpb24%3D'),
    (2012, 103, 'https://www.youtube.com/watch?v=Uw2evtnTm2c&pp=ygUUc2hhd3NoYW5rIHJlZGVtcHRpb24%3D')
;


INSERT INTO REVIEWS (REVIEW_ID, USER_ID, MOVIE_ID, RATING, COMMENT)
VALUES
    (3001, 1, 101, 4.5, 'Mind-bending plot!'),
    (3002, 2, 102, 5.0, 'Heath Ledger was phenomenal.'),
    (3003, 1, 103, 5.0, 'One of the best movies ever made!')
;


INSERT INTO LIKES_DISLIKES (LIKE_ID, USER_ID, MOVIE_ID, IS_LIKE)
VALUES
    (4001, 1, 101, TRUE),
    (4002, 2, 102, TRUE),
    (4003, 2, 103, FALSE)
;


INSERT INTO PEOPLE (PERSON_ID, NAME, OCCUPATION, IMAGE_URL)
VALUES
    (5001, 'Christopher Nolan', 'Director','https://th.bing.com/th/id/OIP.H-MOYGChQSzDXMdKt0Hb5AHaLI?w=134&h=202&c=7&r=0&o=5&pid=1.7'),
    (5002, 'Leonardo DiCaprio', 'Actor','https://th.bing.com/th/id/OIP.MqnOa0YvDmvI7JxvWYXwuAHaKa?w=186&h=262&c=7&r=0&o=5&pid=1.7'),
    (5003, 'Elliot Page', 'Actor','https://short-biography.com/wp-content/uploads/elliot-page/Elliot-Page.jpg'),
    (5004, 'Tom Hardy', 'Actor','https://th.bing.com/th/id/OIP.Js9PK2xXvMtFPPUs0NVydAHaKA?w=186&h=251&c=7&r=0&o=5&pid=1.7'),
    (5005, 'Joseph Gordan Levitt', 'Actor','https://th.bing.com/th/id/OIP.gkz9wbAHspnSyffxegZYJgHaJI?w=186&h=229&c=7&r=0&o=5&pid=1.7'),
    (5006, 'Ken Watanable', 'Actor','https://th.bing.com/th/id/OIP.pFZVuWTwfwxqTEHBXaV-NQHaJ4?w=186&h=248&c=7&r=0&o=5&pid=1.7'),
    (5007, 'Cillian Murphy', 'Actor','https://th.bing.com/th/id/OIP.jl4vm6B0yZxxClfeYueQNwHaLG?w=135&h=202&c=7&r=0&o=5&pid=1.7'),
    (5008, 'Tom Berenger', 'Actor','https://th.bing.com/th/id/OIP.YZK41SX5vlqRocJnDClCQwHaLH?w=186&h=279&c=7&r=0&o=5&pid=1.7'),
    (5009, 'Michael Caine', 'Actor','https://th.bing.com/th/id/OIP.rSilVaxdZr1FvE0MZAe9tgHaGS?w=196&h=180&c=7&r=0&o=5&pid=1.7'),

    (5010, 'Christian Bale', 'Actor','https://th.bing.com/th?id=OSK.00f6e46d42f319707fb3e04e9173c9aa&w=120&h=168&c=4&rs=1&qlt=80&o=6&pid=SANGAM'),
    (5011, 'Heath Ledger', 'Actor','https://th.bing.com/th?id=OSK.8689b6e5997ab17a22d0e4c2d3466a9b&w=120&h=168&c=4&rs=1&qlt=80&o=6&pid=SANGAM'),
    (5012, 'Aaron Eckhart', 'Actor','https://th.bing.com/th?id=OSK.b04a201697be52bf429f5005d00cef59&w=120&h=168&c=4&rs=1&qlt=80&o=6&pid=SANGAM'),
    (5013, 'Maggie Gyllenhall', 'Actor','https://th.bing.com/th?id=OSK.0d75216463e25588284ebc248398c993&w=120&h=168&c=4&rs=1&qlt=80&o=6&pid=SANGAM'),
    (5014, 'Morgan Freeman', 'Actor','https://th.bing.com/th?id=OSK.d306ff111d4ea3533fa2da11d20f3edc&w=120&h=168&c=4&rs=1&qlt=80&o=6&pid=SANGAM'),
    (5015, 'Gary Oldman', 'Actor','https://th.bing.com/th?id=OSK.31bd8208e3f40b672e4faf4e5f502ee5&w=120&h=168&c=4&rs=1&qlt=80&o=6&pid=SANGAM'),
    (5016, 'Monique Gabriela Curnen', 'Actor','https://th.bing.com/th?id=OSK.f62a4c8bf014f7d8a677a8b42bec61a2&w=120&h=168&c=4&rs=1&qlt=80&o=6&pid=SANGAM'),

    (5017, 'Frank Darabont', 'Director','https://th.bing.com/th/id/OIP.kEZo8poi8wClp8m1wFHXnAHaOG?w=115&h=199&c=7&r=0&o=5&pid=1.7'),
    (5018, 'Tim Robbins', 'Actor','https://th.bing.com/th?id=OSK.5a56a0f542ef107bef55327177882d71&w=120&h=168&c=4&rs=1&qlt=80&o=6&pid=SANGAM'),
    (5019, 'Bob Gunton', 'Actor','https://th.bing.com/th?id=OSK.e7c1c0d8e12d4ac0d52eb796bae347a8&w=120&h=168&c=4&rs=1&qlt=80&o=6&pid=SANGAM'),
    (5020, 'William Sadler', 'Actor','https://th.bing.com/th?id=OSK.4138c2d30fa4034280cc1b7e677d2e42&w=120&h=168&c=4&rs=1&qlt=80&o=6&pid=SANGAM'),
    (5021, 'Clancy Brown', 'Actor','https://th.bing.com/th?id=OSK.2a464c38d324cf7ebbdec9e5e1fb01e7&w=120&h=168&c=4&rs=1&qlt=80&o=6&pid=SANGAM'),
    (5022, 'Gil Bellows', 'Actor','https://th.bing.com/th?id=OSK.3329440b31691086b5cfe2b915f5cc14&w=120&h=168&c=4&rs=1&qlt=80&o=6&pid=SANGAM'),
    (5023, 'Mark Rolston', 'Actor','https://th.bing.com/th?id=OSK.RNsoc4_nyxT8ziYictVJA09N3S0UPZ0YGu5Ei193OKI&w=120&h=168&c=4&rs=1&qlt=80&o=6&pid=SANGAM'),
    (5024, 'Claire Slemmer', 'Actor','https://th.bing.com/th?id=OSK.89c833bbf9e42ac20b62b0d3da825391&w=120&h=168&c=4&rs=1&qlt=80&o=6&pid=SANGAM')
;


INSERT INTO MOVIE_PEOPLE(MOVIE_ID, PERSON_ID)
VALUES
    (101,5001),
    (101,5002),
    (101,5003),
    (101,5004),
    (101,5005),
    (101,5006),
    (101,5007),
    (101,5008),
    (101,5009),

    (102,5010),
    (102,5011),
    (102,5012),
    (102,5013),
    (102,5014),
    (102,5015),
    (102,5016),
    (102,5001),
    (102,5007),

    (103,5017),
    (103,5018),
    (103,5019),
    (103,5020),
    (103,5021),
    (103,5022),
    (103,5023),
    (103,5024),
    (103,5014)
;

-- SEARCH THE MOVIE NAME WHERE MORGAN FREEMAN WORKED AS AN ACTOR
SELECT M.TITLE FROM MOVIE_PEOPLE MP 
INNER JOIN 
    MOVIES M ON MP.MOVIE_ID = M.MOVIE_ID 
INNER JOIN 
    PEOPLE P ON MP.PERSON_ID=P.PERSON_ID 
WHERE P.NAME = "MORGAN FREEMAN" 
AND P.OCCUPATION = "ACTOR";