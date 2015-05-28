GTEST_ROOT=/home/qjxiao/buildenv/gtest-1.7.0
CXXFLAGS=-g -Wall -O0 -fprofile-arcs -ftest-coverage -I$(GTEST_ROOT)/include -I/usr/local/include

LINK_LIB_DIR=-L/usr/local/lib \
-L$(GTEST_ROOT)/lib/.libs

LINKFLAGS= -fprofile-arcs -lpthread -lgtest 

VPATH=./src

OBJECTS= main.o

test : $(OBJECTS)
	g++ $(CXXFLAGS)  $(LINK_LIB_DIR) -o  ./dist/test $(OBJECTS) $(LINKFLAGS)

clean :
	rm -f ./dist/test
	rm -f ./*.o