DROP DATABASE IF EXISTS MOVIES_DATABASE;
CREATE DATABASE MOVIES_DATABASE CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI;
USE MOVIES_DATABASE;

DROP TABLE IF EXISTS USERS;
CREATE TABLE USERS (
    USER_ID INT AUTO_INCREMENT PRIMARY KEY,
    USERNAME VARCHAR(255) NOT NULL,
    EMAIL VARCHAR(255) NOT NULL UNIQUE,
    PASSWORD VARCHAR(255) NOT NULL
) AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS MOVIES;
CREATE TABLE MOVIES (
    MOVIE_ID INT AUTO_INCREMENT PRIMARY KEY,
    TITLE VARCHAR(255) NOT NULL,
    RELEASE_DATE VARCHAR(255),
    GENRE VARCHAR(255),
    POSTER_URL VARCHAR(255) NOT NULL,
    M_DESCRIPTION TEXT NOT NULL
) AUTO_INCREMENT = 101;

DROP TABLE IF EXISTS CLIPS;
CREATE TABLE CLIPS (
    CLIP_ID INT AUTO_INCREMENT PRIMARY KEY,
    MOVIE_ID INT,
    CLIP_URL VARCHAR(255) NOT NULL,
    FOREIGN KEY (MOVIE_ID) REFERENCES MOVIES(MOVIE_ID)
) AUTO_INCREMENT = 2001;

DROP TABLE IF EXISTS REVIEWS;
CREATE TABLE REVIEWS (
    REVIEW_ID INT AUTO_INCREMENT PRIMARY KEY,
    USER_ID INT,
    MOVIE_ID INT,
    COMMENT TEXT,
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
    FOREIGN KEY (MOVIE_ID) REFERENCES MOVIES(MOVIE_ID)
) AUTO_INCREMENT = 3001;

DROP TABLE IF EXISTS RATING;
CREATE TABLE RATING (
    USER_ID INT,
    MOVIE_ID INT,
    RATING DECIMAL(3, 1) DEFAULT 0.0,
    PRIMARY KEY (USER_ID, MOVIE_ID),
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
    FOREIGN KEY (MOVIE_ID) REFERENCES MOVIES(MOVIE_ID)
);

DROP TABLE IF EXISTS PEOPLE;
CREATE TABLE PEOPLE (
    PERSON_ID INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(255) NOT NULL,
    OCCUPATION VARCHAR(255),
    IMAGE_URL VARCHAR(255) NOT NULL
) AUTO_INCREMENT = 5001;

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


INSERT INTO MOVIES (MOVIE_ID, TITLE, RELEASE_DATE, GENRE, POSTER_URL,M_DESCRIPTION)
VALUES
    (101, 'Inception', '2010-07-16', 'Science Fiction', 'https://image.tmdb.org/t/p/original/xymM5aW6MDcH5AR9I3CamSegJd6.jpg','In a world where technology allows entry into dreams, Dom Cobb, a skilled thief haunted by his past, leads a team tasked with implanting an idea in a targets subconscious. As they navigate surreal dreamscapes, Cobb confronts his demons while facing relentless obstacles, including his deceased wifes haunting presence. In a mind-bending finale, Cobb must confront his past to secure redemption.'),
    (102, 'The Dark Knight', '2008-07-18', 'Action', 'https://www.themoviedb.org/t/p/original/eP5NL7ZlGoW9tE9qnCdHpOLH1Ke.jpg','"The Dark Knight" is a gripping superhero film directed by Christopher Nolan. It follows the iconic DC Comics character Batman, played by Christian Bale, as he faces off against his most formidable adversary yet, the Joker, portrayed masterfully by Heath Ledger. Set in Gotham City, the film explores themes of chaos, morality, and the thin line between heroism and vigilantism. With its intense action sequences, complex characters, and profound storytelling, "The Dark Knight" is widely regarded as one of the greatest superhero films of all time.'),
    (103, 'The Shawshank Redemption', '1994-09-22', 'Drama', 'https://static-01.daraz.pk/p/8950eef7ff576d795965be4aef33f648.jpg','"The Shawshank Redemption" is a powerful drama directed by Frank Darabont, based on a novella by Stephen King. The film tells the story of Andy Dufresne, played by Tim Robbins, a banker who is wrongly convicted of murder and sentenced to life in Shawshank State Penitentiary. Inside the prison, he befriends fellow inmate Ellis "Red" Redding, played by Morgan Freeman, and works to maintain his hope and dignity amidst the harsh realities of prison life. Through perseverance, friendship, and resilience, Andy navigates the injustices of the system, ultimately finding redemption in unexpected ways. "The Shawshank Redemption" is celebrated for its poignant themes, memorable characters, and powerful message of hope and resilience.'),
    (104, 'Pulp Fiction', '1994-10-14', 'Crime', 'https://www.themoviedb.org/t/p/original/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg','"Pulp Fiction" is a groundbreaking crime film directed by Quentin Tarantino, known for its non-linear narrative and eclectic ensemble cast. The film weaves together multiple interconnected stories involving hitmen, mob bosses, boxers, and petty criminals in Los Angeles. With its witty dialogue, stylized violence, and pop culture references, "Pulp Fiction" explores themes of redemption, loyalty, and the unpredictability of fate. The films unconventional structure and iconic scenes, such as the dance sequence featuring Uma Thurman and John Travolta, have made it a cult classic and a landmark in independent cinema.'),
    (105, 'Forrest Gump', '1994-07-06', 'Drama', 'https://image.tmdb.org/t/p/original/saHP97rTPS5eLmrLQEcANmKrsFl.jpg','"Forrest Gump" is a heartwarming drama directed by Robert Zemeckis, starring Tom Hanks in the titular role. The film follows the life of Forrest Gump, a kind-hearted and intellectually challenged man from Alabama, as he unintentionally becomes involved in major historical events spanning several decades, including the Vietnam War, the Civil Rights Movement, and the Watergate scandal. Despite his limitations, Forrests optimism, honesty, and unwavering love for his childhood friend Jenny, played by Robin Wright, propel him through lifes challenges and triumphs. "Forrest Gump" is celebrated for its touching storytelling, memorable characters, and poignant reflection on the complexities of the human experience.'),
    (106, 'The Matrix', '1999-03-31', 'Science Fiction', 'https://image.tmdb.org/t/p/original/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg','"The Matrix" is a groundbreaking science fiction film directed by the Wachowskis. Set in a dystopian future where humanity is unknowingly trapped in a simulated reality called the Matrix, the story follows computer hacker Neo, played by Keanu Reeves, as he discovers the truth about the world around him and joins a rebellion against the machines that control humanity. With its innovative visual effects, mind-bending plot twists, and philosophical themes exploring the nature of reality and free will, "The Matrix" has become a cultural phenomenon and a landmark in the sci-fi genre.'),
    (107, 'Fight Club', '1999-10-15', 'Drama', 'https://www.themoviedb.org/t/p/original/bptfVGEQuv6vDTIMVCHjJ9Dz8PX.jpg','"Fight Club" is a provocative film directed by David Fincher, based on the novel by Chuck Palahniuk. It follows an unnamed protagonist, played by Edward Norton, who is disillusioned with his mundane life and suffering from insomnia. He forms an underground fight club with the charismatic and anarchistic Tyler Durden, portrayed by Brad Pitt. As the club evolves into an increasingly violent and nihilistic movement, the protagonist becomes entangled in a complex web of identity crisis, rebellion, and societal critique. "Fight Club" is renowned for its dark humor, stylish direction, and thought-provoking commentary on consumerism, masculinity, and the search for meaning in a materialistic world.'),
    (108, 'Gladiator', '2000-05-01', 'Action', 'https://image.tmdb.org/t/p/original/bHNRRnCluPs1Rz66426ymN610ws.jpg','"Gladiator" is an epic historical drama directed by Ridley Scott, set in ancient Rome. The film follows Maximus Decimus Meridius, a respected general played by Russell Crowe, who is betrayed by the corrupt Emperor Commodus, portrayed by Joaquin Phoenix, and forced into slavery. Determined to avenge the murder of his family and restore honor to Rome, Maximus rises through the ranks as a gladiator in the brutal arenas of the Colosseum. With its stunning visuals, intense action sequences, and themes of honor, vengeance, and redemption, "Gladiator" is revered as a modern classic and won multiple Academy Awards, including Best Picture and Best Actor for Russell Crowe.'),
    (109, 'The Lord of the Rings: The Fellowship of the Ring', '2001-12-19', 'Fantasy', 'https://www.themoviedb.org/t/p/original/56zTpe2xvaA4alU51sRWPoKPYZy.jpg','"The Lord of the Rings: The Fellowship of the Ring" is the first installment in the epic fantasy film trilogy directed by Peter Jackson, based on the novels by J.R.R. Tolkien. The story follows Frodo Baggins, played by Elijah Wood, as he embarks on a perilous journey to destroy the One Ring, a powerful artifact that threatens to plunge Middle-earth into darkness. Joined by a diverse fellowship including the wizard Gandalf, the warrior Aragorn, and the elf Legolas, Frodo faces numerous challenges and battles against the dark forces of Sauron. Filled with breathtaking landscapes, thrilling action sequences, and memorable characters, "The Fellowship of the Ring" sets the stage for an epic adventure of friendship, courage, and sacrifice.'),
    (110, 'The Lion King', '1994-06-15', 'Animation', 'https://image.tmdb.org/t/p/original/8ydwwfck0F3DHx57jZdFUEqEk4q.jpg','"The Lion King" is a beloved animated film produced by Disney, featuring a timeless story set in the African savanna. It follows the journey of Simba, a young lion prince, who must overcome adversity and reclaim his rightful place as king after the tragic death of his father, Mufasa. Alongside his friends Timon and Pumbaa, Simba learns valuable life lessons about responsibility, friendship, and courage as he battles against his villainous uncle, Scar. With its memorable characters, stunning animation, and iconic musical score, "The Lion King" has captivated audiences of all ages since its release, becoming one of Disneys most cherished and enduring classics.'),
    (111, 'Inglourious Basterds', '2009-08-21', 'War', 'https://www.themoviedb.org/t/p/original/7sf9CgJz30aXDvrg7DYYUQ2U91T.jpg','"Inglourious Basterds" is a thrilling alternate history war film directed by Quentin Tarantino. Set in Nazi-occupied France during World War II, the story follows a group of Jewish-American soldiers led by Lt. Aldo Raine, played by Brad Pitt, who are on a mission to scalp and kill Nazis. Simultaneously, the film follows the story of Shosanna Dreyfus, a Jewish woman seeking revenge against the Nazis who killed her family. As their paths converge, tension rises toward a climactic showdown at a movie premiere attended by top Nazi officials, including Adolf Hitler. Blending Tarantinos signature dialogue, tension-filled scenes, and moments of dark humor, "Inglourious Basterds" is a unique and gripping take on the war genre, offering a cathartic and highly stylized revenge fantasy.'),
    (112, 'The Godfather', '1972-03-15', 'Crime', 'https://www.themoviedb.org/t/p/original/3bhkrj58Vtu7enYsRolD1fZdja1.jpg','"The Godfather" is an epic crime drama directed by Francis Ford Coppola, based on the novel by Mario Puzo. The film follows the powerful Corleone mafia family, led by patriarch Vito Corleone, played by Marlon Brando, and later by his son Michael, played by Al Pacino. Set in post-World War II America, the story revolves around themes of power, family loyalty, and betrayal. As Michael is drawn deeper into the familys criminal underworld, he undergoes a transformation from a reluctant outsider to a ruthless leader. "The Godfather" is celebrated for its rich storytelling, complex characters, and iconic performances, and is often hailed as one of the greatest films in cinematic history.'),
    (113, 'The Godfather: Part II', '1974-12-20', 'Crime', 'https://image.tmdb.org/t/p/original/5ZSfJ9aleg2rGhVWp0Dcqv38Nr5.jpg','"The Godfather: Part II" is a gripping crime drama directed by Francis Ford Coppola and is a sequel to the iconic film "The Godfather." Set in the 1950s and 1960s, the film continues the saga of the Corleone crime family, focusing on the parallel storylines of Michael Corleone, played by Al Pacino, as he solidifies his power as the new Don, and his father Vito Corleone, portrayed by Robert De Niro, as he rises to power in early 20th-century New York. Exploring themes of power, family, and betrayal, "The Godfather: Part II" is hailed for its masterful storytelling, complex characters, and stunning cinematography. It is widely regarded as one of the greatest sequels in cinematic history and won multiple Academy Awards, including Best Picture.'),
    (114, 'The Dark Knight Rises', '2012-07-20', 'Action', 'https://image.tmdb.org/t/p/original/hr0L2aueqlP2BYUblTTjmtn0hw4.jpg','"The Dark Knight Rises" is the epic conclusion to Christopher Nolans Batman trilogy. Set eight years after the events of "The Dark Knight," the film sees Bruce Wayne, played by Christian Bale, coming out of retirement to face the menacing terrorist leader Bane, portrayed by Tom Hardy, who threatens to destroy Gotham City. As Batman confronts his physical and emotional limitations, he is aided by allies like Catwoman, played by Anne Hathaway, and Commissioner Gordon, portrayed by Gary Oldman. The film explores themes of sacrifice, redemption, and the enduring legacy of Batman. With its thrilling action sequences, complex characters, and thought-provoking narrative, "The Dark Knight Rises" delivers a satisfying conclusion to the trilogy.'),
    (115, 'Interstellar', '2014-11-05', 'Science Fiction', 'https://image.tmdb.org/t/p/original/4pWbfjzUkusGXAZQoduARaI0qu2.jpg','"Interstellar" is an epic science fiction film directed by Christopher Nolan. Set in a dystopian future where Earth is suffering from a global food crisis, the story follows a group of astronauts, led by Matthew McConaugheys character, as they embark on a daring mission through a newly discovered wormhole in search of a habitable planet for humanitys survival. As they traverse through space and time, the film explores themes of love, sacrifice, and the resilience of the human spirit. With stunning visuals, mind-bending concepts rooted in real science, and emotional depth, "Interstellar" is hailed as a thought-provoking and visually stunning masterpiece.'),
    (116, 'The Prestige', '2006-10-20', 'Drama', 'https://image.tmdb.org/t/p/original/punmWKefqHUGo2f3dO3lpfRbOB2.jpg','"The Prestige" is a captivating mystery thriller directed by Christopher Nolan. Set in the world of 19th-century stage magic, the film follows the intense rivalry between two illusionists, Robert Angier (played by Hugh Jackman) and Alfred Borden (played by Christian Bale). As they strive to outdo each other with their elaborate tricks and illusions, their competition escalates into a dangerous game of one-upmanship, fueled by obsession and betrayal. With its intricate plot twists, moral ambiguity, and themes of sacrifice and deception, "The Prestige" keeps viewers on the edge of their seats until its stunning conclusion.'),
    (117, 'The Silence of the Lambs', '1991-02-14', 'Thriller', 'https://image.tmdb.org/t/p/original/frwEq21s71aDvwSdQDipvZGeA9M.jpg', '"The Silence of the Lambs" is a gripping psychological thriller directed by Jonathan Demme, based on the novel by Thomas Harris. The film follows FBI trainee Clarice Starling, played by Jodie Foster, as she seeks the help of incarcerated cannibalistic serial killer Hannibal Lecter, portrayed by Anthony Hopkins, to catch another serial killer known as Buffalo Bill. As Clarice delves deeper into the twisted mind of Lecter, she must confront her own fears and vulnerabilities while racing against time to save Buffalo Bills latest victim. "The Silence of the Lambs" is celebrated for its taut suspense, chilling performances, and compelling exploration of the complexities of evil.'),
    (118, 'The Departed', '2006-10-05', 'Crime', 'https://image.tmdb.org/t/p/original/8niBn8AZtAqQcsGvUudfdtIy4vj.jpg', '"The Departed" is a gripping crime thriller directed by Martin Scorsese, inspired by the Hong Kong film "Infernal Affairs." Set in Boston, the film follows an undercover cop, Billy Costigan, played by Leonardo DiCaprio, who infiltrates the Irish mob, and a mole within the police force, Colin Sullivan, portrayed by Matt Damon, who rises through the ranks of the mob. As both men become increasingly entangled in their double lives, they race to uncover each others identities before their covers are blown. With its intense performances, intricate plot twists, and themes of loyalty and betrayal, "The Departed" is hailed as one of Scorseses finest films and won multiple Academy Awards, including Best Picture and Best Director.'),
    (119, 'The Green Mile', '1999-12-10', 'Fantasy', 'https://www.themoviedb.org/t/p/original/sOHqdY1RnSn6kcfAHKu28jvTebE.jpg', '"The Green Mile" is a poignant supernatural drama directed by Frank Darabont, based on the novel by Stephen King. Set on death row at a Louisiana prison in the 1930s, the film follows corrections officer Paul Edgecomb, played by Tom Hanks, as he discovers that one of the inmates, John Coffey, portrayed by Michael Clarke Duncan, possesses miraculous healing powers. As Paul forms a bond with John and witnesses the injustices of the justice system, he grapples with questions of faith, morality, and redemption. "The Green Mile" is celebrated for its powerful performances, emotional storytelling, and exploration of themes such as compassion and the human capacity for good and evil.'),
    (120, 'The Lord of the Rings: The Return of the King', '2003-12-17', 'Fantasy', 'https://www.themoviedb.org/t/p/original/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg', '"The Lord of the Rings: The Return of the King" is the epic conclusion to Peter Jacksons fantasy film trilogy based on the novels by J.R.R. Tolkien. The film follows the culmination of the quest to destroy the One Ring, as Frodo Baggins and his loyal companions make their final stand against the dark lord Sauron and his forces. With the fate of Middle-earth hanging in the balance, the armies of men, elves, and dwarves unite for one last battle at the Black Gate of Mordor. Filled with breathtaking action sequences, emotional depth, and stunning visuals, "The Return of the King" won eleven Academy Awards, including Best Picture, making it one of the most acclaimed and successful films in cinematic history.'),
    (121, 'The Lord of the Rings: The Two Towers', '2002-12-18', 'Fantasy', 'https://www.themoviedb.org/t/p/original/5VTN0pR8gcqV3EPUHHfMGnJYN9L.jpg', '"The Lord of the Rings: The Two Towers" is the second installment in Peter Jacksons epic fantasy film trilogy based on the novels by J.R.R. Tolkien. The film continues the journey of the Fellowship of the Ring as they face new challenges and perils in their quest to destroy the One Ring and defeat the dark lord Sauron. Separated by fate, the members of the Fellowship encounter allies and adversaries while navigating the treacherous landscapes of Middle-earth. Meanwhile, Frodo and Sam edge closer to the heart of Mordor, guided by the mysterious Gollum. With its sweeping vistas, epic battles, and complex characters, "The Two Towers" sets the stage for the climactic final chapter of the trilogy.'),
    (122, 'The Godfather: Part III', '1990-12-24', 'Crime', 'https://image.tmdb.org/t/p/original/gh2ShN6ku8VOT8wNyEOgZQwhNtE.jpg', '"The Godfather: Part III" is the final installment in Francis Ford Coppolas epic crime saga. Set decades after the events of "The Godfather: Part II," the film follows an aging Michael Corleone, played by Al Pacino, as he seeks to legitimize his familys criminal empire and atone for his past sins. However, Michaels efforts are complicated by betrayal, revenge, and the ghosts of his past. As he navigates the treacherous waters of politics and organized crime, Michael grapples with questions of morality, loyalty, and the price of power. "The Godfather: Part III" is praised for its powerful performances, intricate storytelling, and exploration of themes such as the corrupting influence of power and the elusive nature of redemption.'),
    (123, 'Goodfellas', '1990-09-12', 'Crime', 'https://image.tmdb.org/t/p/original/Aavp1fVJChzJbOzmVHhkSwpMvbB.jpg', '"Goodfellas" is a riveting crime drama directed by Martin Scorsese, based on the true story of mobster-turned-informant Henry Hill. The film follows Henry, played by Ray Liotta, as he rises through the ranks of the mafia alongside his friends Jimmy Conway, portrayed by Robert De Niro, and Tommy DeVito, played by Joe Pesci. As they become increasingly involved in organized crime, Henry grapples with the consequences of his actions and the allure of the criminal lifestyle. With its stylish direction, sharp dialogue, and intense performances, "Goodfellas" is hailed as one of the greatest gangster films ever made.'),
    (124, 'Se7en', '1995-09-22', 'Crime', 'https://image.tmdb.org/t/p/original/xXwyNNJjfx9Wua0Z1Y9o76yVooC.jpg', '"Se7en" is a chilling crime thriller directed by David Fincher. The film follows detectives William Somerset, played by Morgan Freeman, and David Mills, portrayed by Brad Pitt, as they investigate a series of gruesome murders inspired by the seven deadly sins. As the detectives delve deeper into the mind of the sadistic killer, they find themselves ensnared in a psychological game of cat and mouse with deadly consequences. With its dark atmosphere, twist ending, and exploration of the nature of evil, "Se7en" is hailed as a modern classic of the thriller genre.'),
    (125, 'East Is East', '1999-09-05', 'Comedy', 'https://image.tmdb.org/t/p/original/tDchJ4mB23vGgwdQCmq9FCQ4W23.jpg', '"East Is East" is a British comedy-drama directed by Damien ODonnell, based on the play by Ayub Khan-Din. Set in 1970s Salford, England, the film follows George Khan, a Pakistani immigrant played by Om Puri, as he struggles to reconcile his traditional values with the desires of his British-born children. As cultural tensions rise within the Khan family, George attempts to assert his authority while facing resistance from his strong-willed wife, Ella, portrayed by Linda Bassett, and his rebellious sons. With its blend of humor, heart, and social commentary, "East Is East" explores themes of identity, immigration, and the complexities of family dynamics.'),
    (126, 'The Sixth Sense', '1999-08-06', 'Thriller', 'https://image.tmdb.org/t/p/original/rzwXPA8wBbzObyNjwY6mcesGPsw.jpg', '"The Sixth Sense" is a supernatural thriller directed by M. Night Shyamalan. The film follows child psychologist Dr. Malcolm Crowe, played by Bruce Willis, as he attempts to help a young boy named Cole Sear, portrayed by Haley Joel Osment, who claims to see ghosts. As Dr. Crowe delves deeper into Coles mysterious abilities, he uncovers shocking truths about his own past and the nature of existence. With its iconic twist ending and haunting atmosphere, "The Sixth Sense" became a cultural phenomenon and solidified Shyamalans reputation as a master of suspense.'),
    (127, 'The Usual Suspects', '1995-07-19', 'Crime', 'https://image.tmdb.org/t/p/original/bUPmtQzrRhzqYySeiMpv7GurAfm.jpg', '"The Usual Suspects" is a gripping crime thriller directed by Bryan Singer. The film follows a group of criminals who are brought together for a mysterious heist orchestrated by the enigmatic Keyser Söze. As the story unfolds through the interrogation of the lone survivor, Verbal Kint, played by Kevin Spacey, the audience is drawn into a complex web of deception, betrayal, and double-crosses. With its nonlinear narrative, intricate plot twists, and standout performances, "The Usual Suspects" keeps viewers guessing until its unforgettable climax.'),
    (128, 'Leon: The Professional', '1994-09-14', 'Thriller', 'https://image.tmdb.org/t/p/original/yI6X2cCM5YPJtxMhUd3dPGqDAhw.jpg', '"Leon: The Professional" is a stylish thriller directed by Luc Besson. The film follows Leon, a professional hitman played by Jean Reno, who forms an unlikely bond with Mathilda, a young girl portrayed by Natalie Portman, after her family is killed by a corrupt DEA agent. As Mathilda seeks revenge against the killers, she apprentices herself to Leon to learn the art of assassination. With its dynamic action sequences, complex characters, and themes of redemption and mentorship, "Léon: The Professional" is hailed as a modern classic of the action thriller genre.'),
    (129, 'American History X', '1998-10-30', 'Drama', 'https://image.tmdb.org/t/p/original/euypWkaYFOLW3e5rLIcTAjWnhhT.jpg', '"American History X" is a powerful drama directed by Tony Kaye. The film follows Derek Vinyard, played by Edward Norton, a former neo-Nazi skinhead who undergoes a transformation while serving time in prison for murder. Upon his release, Derek seeks to prevent his younger brother, Danny, portrayed by Edward Furlong, from following in his footsteps and falling into the same cycle of hate and violence. Through flashbacks and present-day events, "American History X" explores themes of racism, prejudice, and the consequences of extremism, offering a poignant and thought-provoking commentary on the state of American society.'),
    (130, 'Saving Private Ryan', '1998-07-24', 'War', 'https://image.tmdb.org/t/p/original/zJdsvHIkcDG18DpoKoF0HITG8Hq.jpg', '"Saving Private Ryan" is a gripping war drama directed by Steven Spielberg. Set during the invasion of Normandy in World War II, the film follows Captain John Miller, played by Tom Hanks, as he leads a squad of soldiers on a dangerous mission to locate and bring home Private James Ryan, portrayed by Matt Damon, whose three brothers have been killed in action. As they journey through the ravages of war, the squad confronts the harsh realities of combat and questions the morality of their mission. With its visceral depiction of battle, emotional depth, and powerful performances, "Saving Private Ryan" is hailed as one of the greatest war films ever made.'),
    (131, 'Avatar', '2009-12-18', 'Adventure', 'https://image.tmdb.org/t/p/original/3C5brXxnBxfkeKWwA1Fh4xvy4wr.jpg', '"Avatar" is a groundbreaking science fiction adventure directed by James Cameron. Set on the alien planet of Pandora, the film follows Jake Sully, a paralyzed former Marine played by Sam Worthington, as he becomes part of a mission to exploit the planets resources. Using an avatar, a genetically engineered hybrid of human and native DNA, Jake explores Pandora and becomes involved in the conflict between the indigenous Navi people and the human corporation exploiting their land. With its stunning visuals, immersive world-building, and environmental themes, "Avatar" broke box office records and revolutionized the use of 3D technology in filmmaking.'),
    (132, 'The Avengers', '2012-04-05', 'Action', 'https://image.tmdb.org/t/p/original/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg','"The Avengers" is an action-packed superhero film directed by Joss Whedon, based on the Marvel Comics superhero team of the same name. The film brings together iconic Marvel characters such as Iron Man, Captain America, Thor, Hulk, Black Widow, and Hawkeye as they join forces to battle the villainous Loki and his alien army. With its thrilling action sequences, dynamic ensemble cast, and witty dialogue, "The Avengers" became a cultural phenomenon and kickstarted the Marvel Cinematic Universe, setting the stage for numerous interconnected superhero films.'),
    (133, 'Jurassic Park', '1993-06-11', 'Science Fiction', 'https://image.tmdb.org/t/p/original/2c0ajTi8nvrsYl5Oi1lVi6F0kd2.jpg','"Jurassic Park" is a groundbreaking science fiction adventure directed by Steven Spielberg, based on the novel by Michael Crichton. The film follows a group of scientists and visitors who are invited to tour a remote island inhabited by genetically engineered dinosaurs. When the parks security systems fail, the dinosaurs break free, leading to a fight for survival. With its revolutionary visual effects, thrilling action sequences, and suspenseful storytelling, "Jurassic Park" captivated audiences worldwide and became a milestone in blockbuster filmmaking, inspiring sequels, theme park attractions, and a franchise that continues to endure.'),
    (134, 'Titanic', '1997-12-19', 'Romance', 'https://image.tmdb.org/t/p/original/As0zX43h3w6kD2NS4uVHu9HKdEh.jpg','"Titanic" is a sweeping romantic drama directed by James Cameron, set against the backdrop of the ill-fated maiden voyage of the RMS Titanic. The film follows the love story between Jack Dawson, a penniless artist played by Leonardo DiCaprio, and Rose DeWitt Bukater, a young socialite portrayed by Kate Winslet, as they meet and fall in love aboard the luxurious ocean liner. As the ship collides with an iceberg and begins to sink, Jack and Rose must fight for their lives amidst the chaos and tragedy unfolding around them. With its epic scale, breathtaking visuals, and timeless love story, "Titanic" became one of the highest-grossing and most beloved films of all time, winning multiple Academy Awards, including Best Picture.'),
    (135, 'The Social Network', '2010-10-01', 'Biography', 'https://image.tmdb.org/t/p/original/ktt1aeYosypMBoVzgtJROVYYLNE.jpg','"The Social Network" is a biographical drama directed by David Fincher, depicting the rise of Facebook and the legal battles that ensued among its founders. The film focuses on Mark Zuckerberg, portrayed by Jesse Eisenberg, as he creates the social networking website while attending Harvard University. As Facebook becomes a global phenomenon, Mark faces lawsuits from his former friends and business partners, leading to a contentious legal battle. With its sharp dialogue, compelling performances, and exploration of themes such as ambition, betrayal, and the nature of success, "The Social Network" offers a fascinating glimpse into the origins of one of the most influential companies of the modern era.'),
    (136, 'Jaws', '1975-06-20', 'Thriller', 'https://image.tmdb.org/t/p/original/eWl3pAlYoM6yM9KTNmTL5hHMew1.jpg','"Jaws" is a classic thriller directed by Steven Spielberg, based on the novel by Peter Benchley. The film follows Police Chief Martin Brody, played by Roy Scheider, as he teams up with marine biologist Matt Hooper, portrayed by Richard Dreyfuss, and shark hunter Quint, played by Robert Shaw, to hunt down a great white shark terrorizing the seaside town of Amity Island. With its iconic score, suspenseful pacing, and groundbreaking special effects, "Jaws" set the standard for the summer blockbuster and became a cultural phenomenon, solidifying Spielbergs reputation as a master filmmaker.'),
    (137, 'E.T. the Extra-Terrestrial', '1982-06-11', 'Animation', 'https://image.tmdb.org/t/p/original/xLmPOUiArpmuvqBrUTYGGmQVYpI.jpg','"E.T. the Extra-Terrestrial" is a heartwarming science fiction film directed by Steven Spielberg. The film follows a young boy named Elliott, played by Henry Thomas, who befriends a stranded alien creature and helps him evade capture by government agents. As Elliott and his siblings form a bond with the gentle extraterrestrial, they embark on a journey to help E.T. return to his home planet. With its themes of friendship, family, and empathy, "E.T. the Extra-Terrestrial" captured the hearts of audiences worldwide and became one of the most beloved films of all time, earning critical acclaim and box office success.'),
    (138, 'Back to the Future', '1985-07-03', 'Science Fiction', 'https://image.tmdb.org/t/p/original/gcCbAMXptil3zInWAsZZ4ecH0Z9.jpg','"Back to the Future" is a timeless science fiction adventure directed by Robert Zemeckis. The film follows teenager Marty McFly, played by Michael J. Fox, who is accidentally sent back in time to 1955 in a modified DeLorean car by his eccentric scientist friend Doc Brown, portrayed by Christopher Lloyd. Marty must navigate the challenges of the past while ensuring his parents fall in love and securing his own existence in the future. With its inventive premise, memorable characters, and exhilarating blend of humor and heart, "Back to the Future" has become a beloved classic'),
    (139, 'Mad Max: Fury Road', '2016-05-15', 'Action', 'https://image.tmdb.org/t/p/original/hA2ple9q4qnwxp3hKVNhroipsir.jpg','"Mad Max: Fury Road" is a high-octane action film set in a post-apocalyptic wasteland where the protagonist, Max Rockatansky, teams up with a fierce warrior named Imperator Furiosa to escape the tyrannical rule of a despot named Immortan Joe. Together, they embark on a relentless, adrenaline-fueled journey across the desert, pursued by Joes ruthless army of War Boys. Amidst explosive car chases, epic battles, and breathtaking stunts, Max and Furiosa strive to find freedom and redemption in a world gone mad.'),
    (140, 'The Shape of Water', '2017-12-01', 'Drama', 'https://image.tmdb.org/t/p/original/nHKksz2SHsBc7X0jVSlbVye3lDB.jpg','"The Shape of Water" is a visually stunning fantasy drama directed by Guillermo del Toro. Set against the backdrop of Cold War-era America, it follows the story of a mute cleaning woman named Elisa who works in a high-security government laboratory. Elisa forms a deep connection with a mysterious amphibious creature being held captive in the lab, and as their bond grows, she becomes determined to rescue him from captivity. With elements of romance, suspense, and magical realism, the film explores themes of love, acceptance, and the beauty of finding connection in unexpected places.'),
    (141, 'La La Land', '2016-12-09', 'Romance', 'https://image.tmdb.org/t/p/original/jXCW8lNM1IaPqbMW9x15rJ9TPNG.jpg','"La La Land" is a captivating romantic musical that follows the whirlwind love story of Mia, an aspiring actress, and Sebastian, a jazz musician, as they chase their dreams in the vibrant backdrop of Los Angeles. Amidst the glitz and glamour of Hollywood, they navigate the challenges of ambition, sacrifice, and the pursuit of artistic fulfillment, all set to a breathtaking soundtrack. Their passionate romance intertwines with the struggles and triumphs of their careers, creating a heartfelt and enchanting tale of love and ambition in the City of Stars.'),
    (142, 'Black Panther', '2018-02-16', 'Adventure', 'https://media.themoviedb.org/t/p/w500/uxzzxijgPIY7slzFvMotPv8wjKA.jpg','In "Black Panther," TChalla returns to the secretive and technologically advanced African nation of Wakanda to assume the throne after his fathers death. As the new king and the legendary Black Panther, TChalla faces internal and external challenges to protect his people and their vibranium-rich land from threats. With stunning visuals, intricate world-building, and a compelling narrative, "Black Panther" explores themes of identity, power, and responsibility, while showcasing dynamic action sequences and a rich cultural tapestry.'),
    (143, 'Get Out', '2017-11-24', 'Horror', 'https://image.tmdb.org/t/p/original/4WkwNg0wZvFJooVVgyIYkzVNUeA.jpg','"Get Out" is a gripping psychological thriller that follows Chris, a young African-American man, as he visits his white girlfriends affluent family estate. However, as the weekend progresses, Chris uncovers a series of disturbing secrets about the true intentions of the seemingly friendly inhabitants. As tensions rise and the truth becomes increasingly sinister, Chris must fight to escape the terrifying grasp of a twisted and malevolent force before its too late. With its chilling atmosphere and thought-provoking commentary on race and society, "Get Out" delivers a riveting and unforgettable cinematic experience.'),
    (144, 'The Revenant', '2015-10-25', 'Crime', 'https://image.tmdb.org/t/p/original/mlexvVL41DlVlLoKzw5757kAA9F.jpg','"The Revenant" is a gripping survival tale set in the 1820s American frontier. After being mauled by a bear and left for dead by his hunting team, frontiersman Hugh Glass embarks on a relentless journey for vengeance against those who betrayed him. Amidst the harsh wilderness and facing unimaginable hardships, Glass struggles to stay alive and confront his inner demons in this epic tale of resilience, revenge, and redemption.'),
    (145, 'The Wolf of Wall Street', '2013-12-25', 'Biography', 'https://image.tmdb.org/t/p/original/utfEHZ9jG1emGdvJ4GgfMcHoznp.jpg','"The Wolf of Wall Street" is a riveting film directed by Martin Scorsese, depicting the true story of Jordan Belforts meteoric rise and eventual downfall in the high-stakes world of finance. Belfort, portrayed by Leonardo DiCaprio, starts as a young, ambitious stockbroker who quickly learns the ropes of Wall Street and adopts a hedonistic lifestyle filled with excess, corruption, and deceit. As his wealth and power grow, so do his reckless behaviors, leading to a tumultuous journey of greed, betrayal, and ultimately, redemption. With its dynamic storytelling and stellar performances, "The Wolf of Wall Street" offers a mesmerizing glimpse into the allure and perils of unbridled ambition.'),
    (146, 'Gravity', '2013-10-04', 'Thriller', 'https://image.tmdb.org/t/p/original/xrTN0UwnkNtowUA4e9ypciubuMO.jpg','"Gravity" is a gripping sci-fi thriller that follows two astronauts, Dr. Ryan Stone and veteran astronaut Matt Kowalski, who become stranded in space after their shuttle is destroyed by debris. With dwindling oxygen and limited resources, they must navigate the perilous void of space, facing both physical and emotional challenges as they fight for survival and attempt to find a way back to Earth against all odds.'),
    (147, 'The Martian', '2015-02-15', 'Sci-Fi', 'https://image.tmdb.org/t/p/original/qAlJOHvN0lUuRCfvatUu6avUbR3.jpg','"The Martian" is a gripping science fiction film directed by Ridley Scott, adapted from Andy Weirs bestselling novel. Stranded on Mars after a fierce storm forces his crew to evacuate, astronaut Mark Watney (Matt Damon) must rely on his ingenuity and resilience to survive on the barren planet while NASA works tirelessly to rescue him. Battling against the harsh environment and dwindling supplies, Watney must use his scientific knowledge to cultivate food, repair equipment, and communicate with Earth, all while facing the relentless challenges of isolation and uncertainty. With breathtaking visuals and a compelling story of human determination, "The Martian" is a thrilling tale of survival against all odds.'),
    (148, 'Moonlight', '2016-10-21', 'Drama', 'https://image.tmdb.org/t/p/original/4911T5FbJ9eD2Faz5Z8cT3SUhU3.jpg','"Moonlight" is a poignant coming-of-age film that follows the life of a young African-American man named Chiron as he navigates his identity and sexuality in a rough Miami neighborhood. Divided into three chapters, the film explores Chirons struggle with self-acceptance, his complex relationship with his drug-addicted mother, and his connection with a compassionate mentor figure. Through stunning cinematography and intimate storytelling, "Moonlight" shines a light on themes of love, identity, and the search for belonging in a world that often feels isolating.'),
    (149, 'Birdman', '2014-10-17', 'Comedy', 'https://image.tmdb.org/t/p/original/zbUgf2cidcJu9eysAhMzJt5SKdU.jpg','"Birdman" is a darkly comedic and introspective film that follows Riggan Thomson, a washed-up actor famous for portraying a superhero, as he attempts to revive his career by directing and starring in a Broadway play. Struggling with his ego, family issues, and the pressures of the theater world, Riggan grapples with his own sanity while trying to prove himself as a serious artist. Shot in a unique, continuous take style, "Birdman" explores themes of identity, celebrity culture, and the pursuit of artistic validation.'),
    (150, 'Django Unchained', '2012-12-25', 'Western', 'https://image.tmdb.org/t/p/original/x5dUIdwYJSKgGedZjNUEJBLhwMM.jpg','"Django Unchained" is a gripping spaghetti western film directed by Quentin Tarantino. Set in the pre-Civil War United States, it follows Django, a freed slave turned bounty hunter, who teams up with a German bounty hunter named Dr. King Schultz. Together, they embark on a mission to rescue Djangos wife from a brutal plantation owner, Calvin Candie. Filled with intense action, poignant moments, and Tarantinos signature style, the film explores themes of justice, revenge, and the human spirits resilience in the face of oppression.')
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


INSERT INTO REVIEWS (REVIEW_ID, USER_ID, MOVIE_ID, COMMENT)
VALUES
    (3001, 1, 101, 'Mind-bending plot!'),
    (3002, 2, 102, 'Heath Ledger was phenomenal.'),
    (3003, 1, 101, 'One of the best movies ever made!')
;

INSERT INTO RATING (USER_ID, MOVIE_ID, RATING)
VALUES
    (1, 101, 5.0),
    (2, 102, 4.0),
    (2, 103, 3.0),
    (1, 104, 2.0),
    (1, 105, 1.0),
    (2, 106, 5.0),
    (1, 107, 4.5)
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

-- ALL MOVIES WHERE MOVIE_ID = 101
SELECT * FROM MOVIES WHERE MOVIE_ID = 101;

-- ALL CLIPS WHERE MOVIE_ID = 101
SELECT * FROM CLIPS WHERE MOVIE_ID = 101;

-- SEARCH THE ACORTS FOR A PARTUCULAR MOVIE
SELECT P.* FROM MOVIE_PEOPLE MP 
INNER JOIN
    PEOPLE P ON MP.PERSON_ID = P.PERSON_ID
WHERE 
    MP.MOVIE_ID = 101;

-- AVERAGE RATING FOR A SELECTED MOVIE
SELECT AVG(RATING) FROM RATING WHERE MOVIE_ID = 101;

-- ALL THE REVIEWS FOR A MOVIE AND WHO POSTED THE REVIEW
SELECT R.REVIEW_ID,R.COMMENT,U.USERNAME FROM REVIEWS R
INNER JOIN
    USERS U ON R.USER_ID = U.USER_ID
WHERE 
    R.MOVIE_ID = 101;

-- LIST OF RELATED MOVIES
SELECT MOVIE_ID FROM MOVIES WHERE GENRE = (SELECT GENRE FROM MOVIES WHERE MOVIE_ID = 101);

-- LOGIN AUTHORIZATION
SELECT * FROM USERS WHERE EMAIL = 'alice@email.com' AND PASSWORD = 'password123';

SELECT * FROM USERS WHERE EMAIL = '';

-- GET THE RATING OF A MOVIE GIVEN BY A SPECIFIC USER
SELECT RATING FROM RATING WHERE USER_ID = 1 AND MOVIE_ID = 101;