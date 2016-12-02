MODULE MySQL;

  IMPORT SYSTEM, Console, Strings;

  TYPE 
    Int64* = LONGINT;
    Int32* = INTEGER;
    Int16* = SHORTINT;
	PChar* = POINTER [1] TO ARRAY OF CHAR; (* generic pointer *)
    MysqlRowStr* = LONGINT; (*POINTER TO ARRAY OF CHAR;*)
    MysqlRow* = LONGINT; (*POINTER TO MysqlRowStr;*)

     (* st_mysql_rows from mysql/mysql.h *)
    MysqlRows* = RECORD
       Next*: POINTER [1] TO MysqlRows;
	   Data*: MysqlRow;
	   Length*: Int64
	END;

     (* st_mysql_field from mysql/mysql.h *)
    MysqlField* = RECORD
      Name*, OrgName*, Table*, OrgTable*, Db*, Catalog*, Def* : POINTER[1] TO ARRAY OF CHAR;
	  Length*, MaxLength*: Int64;
	  NameLenght*, OrgNameLength*, TableLength*, OrgTableLength*, DbLength*, CatalogLength*, DefLength*, Flags*, Decimals*, Charsetnr*: Int32;
      type* : Int32;
	  extention*: POINTER [1] TO ARRAY OF CHAR;
	END;
    
    MysqlFieldOffset* = Int32;

        (* charset_info_st in mysql/m_ctype.h *) 
    CharsetInfo* = RECORD
       Number*, PrimaryNumber*, BinaryNumber*, State*: Int32;
	   CsName*, Name*, Comment*, Tailoring* : POINTER [1] TO ARRAY OF CHAR;
	   Ctype*, ToLower*, ToUpper*, SortOrder*: POINTER [1] TO ARRAY OF CHAR;
	   uca*: LONGINT; (*POINTER [1] TO MyUcaInfo;*)
	   TabToUni*: POINTER [1] TO ARRAY 2 OF CHAR;
	   TabFromUni: LONGINT; (*POINTER [1] TO MyUniIdx;*)
	   CaseInfo*: LONGINT; (* MY_UNICASE_INFO *caseinfo *)
	   StateMap*, IdentMap*: POINTER [1] TO ARRAY OF CHAR;
	   StrxfrmMultiply*: Int32;
	   CaseupMultiply*, CasednMultiply*: SYSTEM.BYTE;
	   Mbminlen*, Mbmaxlen*: Int32;
	   MinSortChar*, MaxSortChar*: LONGINT;
	   PadChar*: SYSTEM.BYTE;
	   EscapeWithBackslashIsDangerous*: CHAR;
	   LevelsForOrder*: SYSTEM.BYTE;
	   Cset*, Coll*: LONGINT;
	END;

      (* st_mem_root from mysql/my_alloc.h *)
    MemRoot* = RECORD
       Free*, Used*, PreAlloc*: LONGINT;
	   MinMalloc*, BlockSize*: LONGINT;
	   BlockNum*: Int32;
	   FirstBlockUsage*: Int32;
	   ErrorHandler*: LONGINT;
	END;

    Socket* = Int32;

      (* st_net in mysql/mysql_com.h *)
    NetDesc* = RECORD
       Vio*: LONGINT;
	   Buff*, BuffEnd*, WritePos*, ReadPos*: LONGINT;
	   Fd*: Socket; (* my_socket *)
       RemainInBuf*, Length*, BufLength*, WhereB*: Int64;
	   MaxPacket*, MaxPacketSize*: Int64;
	   PktNr*, CompressPktNr*: Int32;
	   WriteTimeout*, ReadTimeout*, RetryCount*: Int32;
	   Fcntl* : Int32;
	   ReturnStatus*: LONGINT;
	   ReadingOrWriting*: SYSTEM.BYTE;
	   SaverChar*, NetSkipRestFactor*: CHAR;
	   ThreadSpecificMalloc*, Compress*, unused3: CHAR;
	   Thd*: LONGINT;
	   LastErrno*: Int32;
	   Error*: SYSTEM.BYTE;
	   unused4, unused5: CHAR;
	   LastErrori*: ARRAY 512 OF CHAR;
	   Sqlstate*: ARRAY 6 OF CHAR;
	   Extension*: LONGINT;
	END;

       (* st_mysql_options from mysql/mysql.h *)
    MysqlOptions* = RECORD
       ConnectTimeout*, ReadTimeout*, WriteTimeout: Int32;
	   Port*, Protocol*: Int32;
	   ClientFlag*: Int64;
	   Host*, User*, Password*, UnixSocket*, Db*: POINTER [1] TO ARRAY OF CHAR;
	   InitCommands*: LONGINT;
	   MfCnfFile*, MyCnfGroup*, CharsetDir*, CharsetName*: POINTER [1] TO ARRAY OF CHAR;
	   SslKey*, SslCert*, SslCa*, SslCapath*, SslCipher*, SharedMemoryBaseName*: POINTER [1] TO ARRAY OF CHAR;
	   MaxAllowedPacket*: Int64;
	   UseSsl*, Compress*, NamedPipe*, UseThreadSpecificMemory*, unused2, unused3, unused4: CHAR;
	   MethodsToUse*: Int32; (* enum mysql_option *)
	   ClientIp*: POINTER [1] TO ARRAY OF CHAR;
	   SecureAuth*, ReportDataTruncation*: CHAR;
	   funcpointer1, funcpointer2: LONGINT;
	   funcpointer3: LONGINT;
	   funcpointer4: LONGINT;
	   LocalInfileUserdata*: LONGINT;
	   Extension*: LONGINT
	END;

    Mysql* = POINTER [1] TO MysqlDesc;

          (* st_mysql from mysql/mysql.h *)
    MysqlDesc* = RECORD
	   Net*: NetDesc;
       ConnectorFd* : LONGINT; (*POINTER [1] TO SYSTEM.BYTE;*)
       Host*, User*, Passwd*, UnixSocket*, ServerVersion*, HostInfo*: POINTER[1] TO ARRAY OF CHAR;
	   Info*, Db* : POINTER [1] TO ARRAY OF CHAR;
	   Charset*: POINTER [1] TO CharsetInfo;
       Fields* : POINTER [1] TO MysqlField;
	   FieldAlloc*: MemRoot;
	   AffectedRows*, InserdId*, ExtraInfo*: LONGINT;
	   ThreadId*, PacketLength*: LONGINT;
	   Port*: Int32;
	   ClientFlag*, ServerCapabilities*: LONGINT;
	   ProtocolVersion*, FieldCount*, ServerStatus*, ServerLanguage*, WarningCount*: Int32;
	   Options*: MysqlOptions;
	   Status*: Int32; (* enum mysql_status status*)
	   FreeMe*, Reconnect*: CHAR;
	   Scramble*: ARRAY 21 OF CHAR;
	   unused1: CHAR;
	   unused2, unused3, unused4, unused5: LONGINT;
	   Stmts*: LONGINT; (* LIST *stmts *)
	   Methods*: LONGINT;
	   Thd*: LONGINT;
	   UnbufferedFetchOwner*: CHAR;
	   InfoBuffer*: POINTER [1] TO ARRAY OF CHAR;
	   Extension*: LONGINT;
    END;

    (* st_mysql_data from mysql/mysql.h *) 
    MysqlData* = RECORD
       Data*: POINTER [1] TO MysqlRows;
	   EmbeddedInfo: LONGINT; (* POINTER TO EmbeddedQueryResult *)
	   Alloc*: MemRoot;
	   Rows*: LONGINT;
	   Fields*: Int32;
	   Extension*: LONGINT
	END;

	MysqlRes* = POINTER [1] TO MysqlResDesc;

    (* st_mysql_res from mysql/mysql.h *)
    MysqlResDesc* = RECORD
       RowCount: Int64;
	   Fields*: POINTER TO MysqlField;
	   Data*: POINTER [1] TO MysqlData;
	   DataCursor*: POINTER [1] TO MysqlRows;
       Lengths*: LONGINT;
	   Handle*: Mysql; (*POINTER [1] TO MysqlDesc;*)
	   Methods*: LONGINT; (* POINTER TO MysqlMethods *)
	   Row*, CurrentRow*: MysqlRow;
       FieldAlloc*: MemRoot;
	   FieldCount*, CurrentField*: Int32;
	   Eof*: SYSTEM.BYTE;
	   UnbufferedFetchCancelled*: SYSTEM.BYTE;
	   Extension*: LONGINT;
	END;

    PROCEDURE -includeMysql()
	"#include <mysql/mysql.h>";

    PROCEDURE -includeMysqlcom()
	"#include <mysql/mysql_com.h>";

    PROCEDURE -includeMyalloc()
	"#include <mysql/my_alloc.h>";



(* mysql_init declaration
   MYSQL *     STDCALL mysql_init(MYSQL *mysql);
 *)

    PROCEDURE -Init*(m: Mysql): Mysql
	"(MySQL_Mysql)mysql_init(m)";

(*	PROCEDURE -init(m: Ptr): Ptr(*Mysql*)
	"(long)mysql_init(m)";
*)
(*
	PROCEDURE Init*(m: Mysql): Mysql;
	   VAR l : Ptr;
	BEGIN
       l := init(SYSTEM.VAL(Ptr, m));
	   m := SYSTEM.VAL(Mysql, l);
	END Init;
*)
(* mysql_real_connect declaration
MYSQL *     STDCALL mysql_real_connect(MYSQL *mysql, const char *host,
                       const char *user,
                       const char *passwd,
                       const char *db,
                       unsigned int port,
                       const char *unix_socket,
                       unsigned long clientflag);
*)
    PROCEDURE -RealConnect*(m: Mysql; VAR host, user, passwd, db: ARRAY OF CHAR; port: Int32; VAR UnixSocket: ARRAY OF CHAR; ClientFlag: LONGINT): LONGINT
	"mysql_real_connect(m, host, user, passwd, db, port, UnixSocket, ClientFlag)";
     (* mysql_error declaration
     const char * STDCALL mysql_error(MYSQL *mysql);
     *)
     PROCEDURE -error(m: Mysql): PChar
        "mysql_error(m)";

     PROCEDURE Error*(m: Mysql; VAR s: ARRAY OF CHAR);
       VAR p : PChar;
     BEGIN
       Console.String("calling error()"); Console.Ln;
       p := error(m);
       Console.String("exited."); Console.Ln;
       Strings.Append(p^, s);        
       Console.String("error string: "); Console.String(s); Console.Ln
     END Error;

(* wrapper sizes test *)
  PROCEDURE -SizeofMysqlData(): INTEGER
    "sizeof(MYSQL_DATA)";

  PROCEDURE -SizeofMysqlResDesc(): INTEGER
    "sizeof(MYSQL_RES)";

  PROCEDURE -SizeofMysqlRows(): INTEGER
    "sizeof(MYSQL_ROWS)";

  PROCEDURE -SizeofMysqlField(): INTEGER
    "sizeof(MYSQL_FIELD)";

  PROCEDURE -SizeofCharsetInfo(): INTEGER
    "sizeof(charinfo)";

  PROCEDURE -SizeofMemRoot(): INTEGER
    "sizeof(MEM_ROOT)";

  PROCEDURE -SizeofNet(): INTEGER
    "sizeof(NET)";

  PROCEDURE -SizeofMysqlOptions(): INTEGER
    "sizeof(options)";

  PROCEDURE -SizeofMysqlDesc(): INTEGER
    "sizeof(MYSQL)";


BEGIN

   (* test sizes *)
   Console.String("Check if struct - record mapping is correct");Console.Ln;

   Console.String("MysqlData "); Console.Int(SIZE(MysqlData), 0); Console.Ln;
   Console.String("st_mysql_data "); Console.Int(SizeofMysqlData(), 0); Console.Ln;

   Console.String("MysqlResDesc "); Console.Int(SIZE(MysqlResDesc), 0); Console.Ln;
   Console.String("st_mysql_res "); Console.Int(SizeofMysqlResDesc(), 0); Console.Ln;

   Console.String("MysqlRows "); Console.Int(SIZE(MysqlRows), 0); Console.Ln;
   Console.String("st_mysql_rows "); Console.Int(SizeofMysqlRows(), 0); Console.Ln;

   Console.String("MysqlField "); Console.Int(SIZE(MysqlField), 0); Console.Ln;
   Console.String("st_mysql_field "); Console.Int(SizeofMysqlField(), 0); Console.Ln;
(*
   Console.String("CharsetInfo "); Console.Int(SIZE(CharsetInfo), 0); Console.Ln;
   Console.String("charset_info_st "); Console.Int(SizeofCharsetInfo(), 0); Console.Ln;
*)
   Console.String("MemRoot "); Console.Int(SIZE(MemRoot), 0); Console.Ln;
   Console.String("st_mem_root "); Console.Int(SizeofMemRoot(), 0); Console.Ln;

   Console.String("NetDesc "); Console.Int(SIZE(NetDesc), 0); Console.Ln;
   Console.String("st_net "); Console.Int(SizeofNet(), 0); Console.Ln;
(*
   Console.String("MysqlOptions "); Console.Int(SIZE(MysqlOptions), 0); Console.Ln;
   Console.String("st_mysql_options "); Console.Int(SizeofMysqlOptions(), 0); Console.Ln;
*)
   Console.String("MysqlDesc "); Console.Int(SIZE(MysqlDesc), 0); Console.Ln;
   Console.String("st_mysql "); Console.Int(SizeofMysqlDesc(), 0); Console.Ln;

END MySQL.
