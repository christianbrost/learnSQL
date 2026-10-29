DROP TABLE IF EXISTS pruefung, student, prof, fak;

CREATE TABLE fak (
  fnr   VARCHAR(5) PRIMARY KEY,
  fname VARCHAR(50) NOT NULL,
  dekan INT
);

CREATE TABLE prof (
  pnr     INT PRIMARY KEY,
  pname   VARCHAR(50) NOT NULL,
  fnr     VARCHAR(5) REFERENCES fak(fnr),
  fachgeb VARCHAR(20)
);

CREATE TABLE student (
  matnr INT PRIMARY KEY,
  sname VARCHAR(50) NOT NULL,
  fnr   VARCHAR(5) REFERENCES fak(fnr),
  w_ort VARCHAR(50)
);

CREATE TABLE pruefung (
  pnr   INT REFERENCES prof(pnr),
  matnr INT REFERENCES student(matnr),
  fach  VARCHAR(20),
  datum DATE,
  note  INT CHECK (note BETWEEN 1 AND 5),
  PRIMARY KEY (pnr, matnr, fach)
);


INSERT INTO fak VALUES ('MI', 'Mathematik/Informatik', 2223);

INSERT INTO prof VALUES
  (1234, 'RAHM', 'MI', 'DBS'),
  (2223, 'MEYER', 'MI', 'AN'),
  (6780, 'BREWKA', 'MI', 'KI');

INSERT INTO student VALUES
  (654711, 'ABEL', 'MI', 'Leipzig'),
  (196481, 'MAIER', 'MI', 'Delitzsch'),
  (225332, 'MÜLLER', 'MI', 'Leipzig');

INSERT INTO pruefung VALUES
  (6780, 654711, 'FA',  '2026-09-19', 2),
  (1234, 196481, 'DBS', '2026-10-15', 1),
  (1234, 654711, 'DBS', '2026-04-17', 2),
  (6780, 196481, 'KI',  '2026-03-25', 3);

  SELECT * FROM student
WHERE fnr = 'MI' AND w_ort = 'Leipzig';

SELECT s.*
FROM student s JOIN pruefung p ON s.matnr = p.matnr
WHERE s.fnr = 'MI' AND p.fach = 'DBS' AND p.note <= 2;

