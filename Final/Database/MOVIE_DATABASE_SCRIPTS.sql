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
    GENRE VARCHAR(255),
    POSTER_URL VARCHAR(255) NOT NULL
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
    IS_LIKE BOOLEAN NOT NULL,
    COMMENT TEXT,
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


INSERT INTO MOVIES (MOVIE_ID, TITLE, RELEASE_DATE, GENRE, POSTER_URL)
VALUES
    (101, 'Inception', '2010-07-16', 'Science Fiction', 'https://image.tmdb.org/t/p/original/xymM5aW6MDcH5AR9I3CamSegJd6.jpg'),
    (102, 'The Dark Knight', '2008-07-18', 'Action', 'https://www.themoviedb.org/t/p/original/eP5NL7ZlGoW9tE9qnCdHpOLH1Ke.jpg'),
    (103, 'The Shawshank Redemption', '1994-09-22', 'Drama', 'https://static-01.daraz.pk/p/8950eef7ff576d795965be4aef33f648.jpg'),
    (104, 'Pulp Fiction', '1994-10-14', 'Crime', 'https://www.themoviedb.org/t/p/original/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg'),
    (105, 'Forrest Gump', '1994-07-06', 'Drama', 'https://image.tmdb.org/t/p/original/saHP97rTPS5eLmrLQEcANmKrsFl.jpg'),
    (106, 'The Matrix', '1999-03-31', 'Science Fiction', 'https://image.tmdb.org/t/p/original/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg'),
    (107, 'Fight Club', '1999-10-15', 'Drama', 'https://www.themoviedb.org/t/p/original/bptfVGEQuv6vDTIMVCHjJ9Dz8PX.jpg'),
    (108, 'Gladiator', '2000-05-01', 'Action', 'https://image.tmdb.org/t/p/original/bHNRRnCluPs1Rz66426ymN610ws.jpg'),
    (109, 'The Lord of the Rings: The Fellowship of the Ring', '2001-12-19', 'Fantasy', 'https://www.themoviedb.org/t/p/original/56zTpe2xvaA4alU51sRWPoKPYZy.jpg'),
    (110, 'The Lion King', '1994-06-15', 'Animation', 'https://image.tmdb.org/t/p/original/8ydwwfck0F3DHx57jZdFUEqEk4q.jpg'),
    (111, 'Inglourious Basterds', '2009-08-21', 'War', 'https://www.themoviedb.org/t/p/original/7sf9CgJz30aXDvrg7DYYUQ2U91T.jpg'),
    (112, 'The Godfather', '1972-03-15', 'Crime', 'https://www.themoviedb.org/t/p/original/3bhkrj58Vtu7enYsRolD1fZdja1.jpg'),
    (113, 'The Godfather: Part II', '1974-12-20', 'Crime', 'https://image.tmdb.org/t/p/original/5ZSfJ9aleg2rGhVWp0Dcqv38Nr5.jpg'),
    (114, 'The Dark Knight Rises', '2012-07-20', 'Action', 'https://image.tmdb.org/t/p/original/hr0L2aueqlP2BYUblTTjmtn0hw4.jpg'),
    (115, 'Interstellar', '2014-11-05', 'Science Fiction', 'https://image.tmdb.org/t/p/original/4pWbfjzUkusGXAZQoduARaI0qu2.jpg'),
    (116, 'The Prestige', '2006-10-20', 'Drama', 'https://image.tmdb.org/t/p/original/punmWKefqHUGo2f3dO3lpfRbOB2.jpg'),
    (117, 'The Silence of the Lambs', '1991-02-14', 'Thriller', 'https://image.tmdb.org/t/p/original/frwEq21s71aDvwSdQDipvZGeA9M.jpg'),
    (118, 'The Departed', '2006-10-05', 'Crime', 'https://image.tmdb.org/t/p/original/8niBn8AZtAqQcsGvUudfdtIy4vj.jpg'),
    (119, 'The Green Mile', '1999-12-10', 'Fantasy', 'https://www.themoviedb.org/t/p/original/sOHqdY1RnSn6kcfAHKu28jvTebE.jpg'),
    (120, 'The Lord of the Rings: The Return of the King', '2003-12-17', 'Fantasy', 'https://www.themoviedb.org/t/p/original/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg'),
    (121, 'The Lord of the Rings: The Two Towers', '2002-12-18', 'Fantasy', 'https://www.themoviedb.org/t/p/original/5VTN0pR8gcqV3EPUHHfMGnJYN9L.jpg'),
    (122, 'The Godfather: Part III', '1990-12-24', 'Crime', 'https://image.tmdb.org/t/p/original/gh2ShN6ku8VOT8wNyEOgZQwhNtE.jpg'),
    (123, 'Goodfellas', '1990-09-12', 'Crime', 'https://image.tmdb.org/t/p/original/Aavp1fVJChzJbOzmVHhkSwpMvbB.jpg'),
    (124, 'Se7en', '1995-09-22', 'Crime', 'https://image.tmdb.org/t/p/original/xXwyNNJjfx9Wua0Z1Y9o76yVooC.jpg'),
    (125, 'East Is East', '1999-09-05', 'Comedy', 'https://image.tmdb.org/t/p/original/tDchJ4mB23vGgwdQCmq9FCQ4W23.jpg'),
    (126, 'The Sixth Sense', '1999-08-06', 'Thriller', 'https://image.tmdb.org/t/p/original/rzwXPA8wBbzObyNjwY6mcesGPsw.jpg'),
    (127, 'The Usual Suspects', '1995-07-19', 'Crime', 'https://image.tmdb.org/t/p/original/bUPmtQzrRhzqYySeiMpv7GurAfm.jpg'),
    (128, 'Léon: The Professional', '1994-09-14', 'Thriller', 'https://image.tmdb.org/t/p/original/yI6X2cCM5YPJtxMhUd3dPGqDAhw.jpg'),
    (129, 'American History X', '1998-10-30', 'Drama', 'https://image.tmdb.org/t/p/original/euypWkaYFOLW3e5rLIcTAjWnhhT.jpg'),
    (130, 'Saving Private Ryan', '1998-07-24', 'War', 'https://image.tmdb.org/t/p/original/zJdsvHIkcDG18DpoKoF0HITG8Hq.jpg'),
    (131, 'Avatar', '2009-12-18', 'Adventure', 'https://image.tmdb.org/t/p/original/3C5brXxnBxfkeKWwA1Fh4xvy4wr.jpg'),
    (132, 'The Avengers', '2012-04-05', 'Action', 'https://image.tmdb.org/t/p/original/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg'),
    (133, 'Jurassic Park', '1993-06-11', 'sci-Fi', 'https://image.tmdb.org/t/p/original/2c0ajTi8nvrsYl5Oi1lVi6F0kd2.jpg'),
    (134, 'Titanic', '1997-12-19', 'Romance', 'https://image.tmdb.org/t/p/original/As0zX43h3w6kD2NS4uVHu9HKdEh.jpg'),
    (135, 'The Social Network', '2010-10-01', 'Biography', 'https://image.tmdb.org/t/p/original/ktt1aeYosypMBoVzgtJROVYYLNE.jpg'),
    (136, 'Jaws', '1975-06-20', 'Thriller', 'https://image.tmdb.org/t/p/original/eWl3pAlYoM6yM9KTNmTL5hHMew1.jpg'),
    (137, 'E.T. the Extra-Terrestrial', '1982-06-11', 'Animation', 'https://image.tmdb.org/t/p/original/xLmPOUiArpmuvqBrUTYGGmQVYpI.jpg'),
    (138, 'Back to the Future', '1985-07-03', 'Science Fiction', 'https://image.tmdb.org/t/p/original/gcCbAMXptil3zInWAsZZ4ecH0Z9.jpg'),
    (139, 'Mad Max: Fury Road', '2016-05-15', 'Action', 'https://image.tmdb.org/t/p/original/hA2ple9q4qnwxp3hKVNhroipsir.jpg'),
    (140, 'The Shape of Water', '2017-12-01', 'Drama', 'https://image.tmdb.org/t/p/original/nHKksz2SHsBc7X0jVSlbVye3lDB.jpg'),
    (141, 'La La Land', '2016-12-09', 'Romance', 'https://image.tmdb.org/t/p/original/jXCW8lNM1IaPqbMW9x15rJ9TPNG.jpg'),
    (142, 'Black Panther', '2018-02-16', 'Adventure', 'https://media.themoviedb.org/t/p/w500/uxzzxijgPIY7slzFvMotPv8wjKA.jpg'),
    (143, 'Get Out', '2017-11-24', 'Horror', 'https://image.tmdb.org/t/p/original/4WkwNg0wZvFJooVVgyIYkzVNUeA.jpg'),
    (144, 'The Revenant', '2015-10-25', 'Crime', 'https://image.tmdb.org/t/p/original/mlexvVL41DlVlLoKzw5757kAA9F.jpg'),
    (145, 'The Wolf of Wall Street', '2013-12-25', 'Biography', 'https://image.tmdb.org/t/p/original/utfEHZ9jG1emGdvJ4GgfMcHoznp.jpg'),
    (146, 'Gravity', '2013-10-04', 'Thriller', 'https://image.tmdb.org/t/p/original/xrTN0UwnkNtowUA4e9ypciubuMO.jpg'),
    (147, 'The Martian', '2015-02-15', 'Sci-Fi', 'https://image.tmdb.org/t/p/original/qAlJOHvN0lUuRCfvatUu6avUbR3.jpg'),
    (148, 'Moonlight', '2016-10-21', 'Drama', 'https://image.tmdb.org/t/p/original/4911T5FbJ9eD2Faz5Z8cT3SUhU3.jpg'),
    (149, 'Birdman', '2014-10-17', 'Comedy', 'https://image.tmdb.org/t/p/original/zbUgf2cidcJu9eysAhMzJt5SKdU.jpg'),
    (150, 'Django Unchained', '2012-12-25', 'Western', 'https://image.tmdb.org/t/p/original/x5dUIdwYJSKgGedZjNUEJBLhwMM.jpg')
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


INSERT INTO REVIEWS (REVIEW_ID, USER_ID, MOVIE_ID, RATING, IS_LIKE, COMMENT)
VALUES
    (3001, 1, 101, 4.5, TRUE, 'Mind-bending plot!'),
    (3002, 2, 102, 5.0, FALSE,'Heath Ledger was phenomenal.'),
    (3003, 1, 103, 5.0, TRUE,'One of the best movies ever made!')
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