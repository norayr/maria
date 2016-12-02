CFLAGS = -g -I/usr/include/mysql -lmysqlclient -Og
export CFLAGS

VOC = /opt/voc/bin/voc


all: clean test0


test0:
			$(VOC) -m MySQL.Mod
			./MySQL

test: clean
			$(VOC) -s MySQL.Mod mysqltest.Mod -m
clean:
			rm -rf MySQL.c
			rm -rf mysql
			rm -rf *.o
			rm -rf *.sym
			rm -rf *.c
			rm -rf *.h
