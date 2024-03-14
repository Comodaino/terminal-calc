LEX_SRC = calc.l
YACC_SRC = calc.y
C_SRC = lex.yy.c $(patsubst %.y, %.tab.c, $(YACC_SRC))
EXEC_NAME = calc

all: $(EXEC_NAME)

$(EXEC_NAME): $(C_SRC)
	cc -Wall -Wextra -pedantic -o $@ $^ -lm

%.tab.c: %.y
	bison -d -Wconflicts-sr $<

%.tab.h: %.tab.c

lex.yy.c: $(LEX_SRC)
	flex $<

clean:
	rm -rf *.c *.o *.h $(EXEC_NAME)

install: all 
	cp $(EXEC_NAME) /usr/local/bin/ 
	chmod 755 /usr/local/bin/$(EXEC_NAME)
	rm -rf *.c *.o *.h $(EXEC_NAME)

uninstall: clean
	rm -f /usr/local/bin/$(EXEC_NAME)
