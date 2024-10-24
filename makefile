BIN = Bin
SOURCE = Source
TEMP = Temp
TESTS = Tests

THREADCOMMUNICATORNAME = ThreadCommunicator
TESTSNAME = Tests

THREADCOMMUNICATORDLL = $(BIN)/lib$(THREADCOMMUNICATORNAME).dll
TESTSEXE = $(BIN)/$(TESTSNAME).exe

All: $(THREADCOMMUNICATORDLL) $(TESTSEXE)
	$(TESTSEXE)

$(THREADCOMMUNICATORDLL) : $(SOURCE)/$(THREADCOMMUNICATORNAME).c
	gcc -c -fPIC $(SOURCE)/$(THREADCOMMUNICATORNAME).c -o $(TEMP)/$(THREADCOMMUNICATORNAME).o
	gcc -shared $(TEMP)/$(THREADCOMMUNICATORNAME).o -lpthread -o $(THREADCOMMUNICATORDLL)

$(TESTSEXE) : $(TESTS)/$(TESTSNAME).c
	gcc -c $(TESTS)/$(TESTSNAME).c -o $(TEMP)/$(TESTSNAME).o
	gcc -I$(SOURCE) -L$(BIN) -lThreadCommunicator $(TEMP)/$(TESTSNAME).o -o $(TESTSEXE)

Clean:
	DEL /Q $(BIN)\*.dll $(BIN)\*.exe
	DEL /Q $(TEMP)\*.o