MODULE mysqltest;
IMPORT SYSTEM, Console, MySQL;

VAR conn, tmp: MySQL.Mysql;
    res: MySQL.MysqlRes;
    row: MySQL.MysqlRow;
	l0, l1: LONGINT;

	server, user, password, database, socket: ARRAY 32 OF CHAR;
	errstr: ARRAY 12 OF CHAR;

BEGIN
   server   := "localhost";
   user     := "root";
   password := "";
   database := "mysql";


   NEW(conn);
   l0 := 5;
   conn := MySQL.Init(conn);
   l0 := SYSTEM.VAL(LONGINT, conn); 
   IF l0 = 0 THEN
      l0 := 1;
      Console.String("failed to connect to server"); Console.Ln;
   ELSE
     l0 := 2;
     Console.String("connected!"); Console.Ln;
   END;
   (*l0 := MySQL.Init(conn);*)
   IF MySQL.RealConnect(conn, server, user, password, database, 0, socket, 0) = 0 THEN
     MySQL.Error(conn, errstr);
     Console.String("stderr "); Console.String(errstr); Console.Ln
   ELSE
     Console.String("connected!");
   END;

END mysqltest.

