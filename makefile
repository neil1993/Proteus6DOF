CXX = g++
CXXLIBS = 
LCXXFLAGS = 
CXX_OPTS = -O3 

EXE_SOLVER = ./bin/6dof.x
EXE_TESTS = ./bin/tests.x

SRCS_SOLVER = 
SRCS_TEST = 

OBJS_SOLVER = $(SRCS_SOLVER:.cpp=.o)
OBJS_TEST = $(SRCS_TEST:.cpp=.o)

GTESTDIR = ./TPLs/gtest/gtest-1.7.0/
GTEST_LIB = $(GTESTDIR)/lib
GTEST_INCLUDES = $(GTESTDIR)/include

EIGENDIR = ./TPLs/eigen/eigen-3.2.4
EIGEN_INCLUDES = $(EIGENDIR)/include

INCLUDES = -I$(GTEST_INCLUDES) -I$(EIGEN_INCLUDES)

$(EXE_SOLVER): 
	$(CXX) $(LINK_OPTS) -o $(EXE_SOLVER) $(LCXXFLAGS) $(OBJS_SOLVER) $(CXXLIBS) 

$(EXE_TESTS): $(GTEST_LIB)/libgtest.la
	$(CXX) $(LINK_OPTS) -o $(EXE_TESTS) $(LCXXFLAGS) -L$(GTEST_LIB) $(OBJS_TEST) $(CXXLIBS)

$(GTEST_LIB)/libgtest.la:
	@orig=$$PWD;\
	cd $$PWD/$(GTESTDIR);\
	./configure;\
	$(MAKE)

ROOT = $$PWD

all: $(EXE_SOLVER) $(EXE_TESTS) 

.cpp.o:
	$(CXX) -c $< $(CXX_OPTS) $(INCLUDES) -o $@

clean:
	rm $(OBJS_SOLVER); \
	rm $(OBJS_TEST); \
	rm $(EXE_SOLVER); \
	rm $(EXE_TESTS); 

Make.depend:
	$(CXX) -MM $(INCLUDES) $(SRCS_SOLVER) $(SRCS_TESTS) > Make.depend

include Make.depend

