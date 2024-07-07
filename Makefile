CC  = clang
CXX = clang++

INCLUDES = 

CFLAGS   = -std=c++11 -g -Wall $(INCLUDES)
CXXFLAGS = -std=c++11 -g -Wall -fobjc-arc $(INCLUDES)

LDFLAGS = -framework Cocoa
LDLIBS  = 

.PHONY: default
default: clipboard_tracker

clipboard_tracker: main.o AppDelegate.o ClipboardManager.o
	$(CXX) $(LDFLAGS) -o clipboard_tracker main.o AppDelegate.o ClipboardManager.o $(LDLIBS)

main.o: main.mm AppDelegate.h ClipboardManager.h
	$(CXX) $(CXXFLAGS) -c main.mm -o main.o

AppDelegate.o: AppDelegate.mm AppDelegate.h
	$(CXX) $(CXXFLAGS) -c AppDelegate.mm -o AppDelegate.o

ClipboardManager.o: ClipboardManager.mm ClipboardManager.h
	$(CXX) $(CXXFLAGS) -c ClipboardManager.mm -o ClipboardManager.o

.PHONY: clean
clean:
	rm -f *.o *~ a.out core clipboard_tracker

.PHONY: clean_objs
clean_objs:
	rm -f *.o *~

.PHONY: run
run: clipboard_tracker
	./clipboard_tracker

.PHONY: all
all: clean default

.PHONY: all_clean
all_clean: clean default clean_objs run