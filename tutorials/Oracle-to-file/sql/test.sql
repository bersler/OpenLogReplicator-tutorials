CREATE TABLE USRTBL.ADAM1(
  ID         NUMBER NOT NULL,
  NAME       VARCHAR2(30),
  COUNT      NUMBER,
  START_TIME TIMESTAMP
);
ALTER TABLE USRTBL.ADAM1 ADD CONSTRAINT ADAM1PK PRIMARY KEY(ID);
ALTER TABLE USRTBL.ADAM1 ADD SUPPLEMENTAL LOG DATA (PRIMARY KEY) COLUMNS;
INSERT INTO USRTBL.ADAM1 VALUES (1, 'Adam Leszczyński', 10, TO_DATE('2019-08-01 12:34:56', 'YYYY-MM-DD HH24:MI:SS'));
COMMIT;
UPDATE USRTBL.ADAM1 SET COUNT = COUNT + 1;
COMMIT;

CREATE TABLE USRTBL.ADAM2(
  ID         NUMBER,
  NAME       VARCHAR2(30),
  COUNT      NUMBER,
  START_TIME TIMESTAMP
);
select OBJECT_ID, OWNER, OBJECT_NAME from ALL_OBJECTS WHERE OWNER = 'USRTBL';

UPDATE USRTBL.ADAM1 SET COUNT = COUNT + 1;
COMMIT;

BEGIN
DBMS_REDEFINITION.can_redef_table(
  uname      => 'USRTBL',
  tname      => 'ADAM1'
);
END;
/

UPDATE USRTBL.ADAM1 SET COUNT = COUNT + 1;
COMMIT;

BEGIN
DBMS_REDEFINITION.start_redef_table(
  uname      => 'USRTBL',
  orig_table => 'ADAM1',
  int_table  => 'ADAM2'
);
END;
/

UPDATE USRTBL.ADAM1 SET COUNT = COUNT + 1;
COMMIT;

BEGIN
DBMS_REDEFINITION.sync_interim_table(
  uname      => 'USRTBL',
  orig_table => 'ADAM1',
  int_table  => 'ADAM2'
);
END;
/

UPDATE USRTBL.ADAM1 SET COUNT = COUNT + 1;
COMMIT;

DECLARE
l_errors PLS_INTEGER; -- Tutaj deklarujemy brakującą zmienną
BEGIN
  DBMS_REDEFINITION.copy_table_dependents(
    uname            => 'USRTBL',
    orig_table       => 'ADAM1',
    int_table        => 'ADAM2',
    copy_indexes     => DBMS_REDEFINITION.CONS_ORIG_PARAMS,
    copy_triggers    => TRUE,
    copy_constraints => TRUE,
    copy_privileges  => TRUE,
    ignore_errors    => FALSE,
    num_errors       => l_errors,
    copy_statistics  => FALSE,
    copy_mvlog       => FALSE
  );
  DBMS_OUTPUT.PUT_LINE('Liczba błędów: ' || l_errors);
END;
/

UPDATE USRTBL.ADAM1 SET COUNT = COUNT + 1;
COMMIT;

BEGIN
DBMS_REDEFINITION.finish_redef_table(
  uname      => 'USRTBL',
  orig_table => 'ADAM1',
  int_table  => 'ADAM2'
);
END;
/

UPDATE USRTBL.ADAM1 SET COUNT = COUNT + 1;
COMMIT;

DELETE FROM USRTBL.ADAM1;
select OBJECT_ID, OWNER, OBJECT_NAME from ALL_OBJECTS WHERE OWNER = 'USRTBL';

DROP TABLE USRTBL.ADAM1;
DROP TABLE USRTBL.ADAM2;
