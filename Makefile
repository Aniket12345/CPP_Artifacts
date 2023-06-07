#############################################################
# C++ Makefile
# Jestin PJ

# -----usage------------ start
# make                   (build with default cpp standard 17)
# make clean
# make cpp14 / make cpp17 / make cpp20 /make cpp23
# make run
# make help
# make clean cpp14 run   (clean, build with cpp14 and run)
# make build
# -----usage------------ end

# Add author name Here
AUTHOR_NAME = "Jestin PJ"
#############################################################

COMPILED_DATE = $$(date +"%Y-%m-%d")
CXX = g++
CXXFLAGS = -pedantic -g
TARGET := Output
CPP_STD = c++17

# Get all .cpp files from the current directory
SRCS := $(wildcard *.cpp)
# Substitute .cpp file names to .o file names
OBJS := $(patsubst %.cpp,%.o,$(SRCS))

# Default target
all: cpp17

#############################################################
# add standards here 
cpp11: CPP_STD = c++11
cpp14: CPP_STD = c++14
cpp17: CPP_STD = c++17
cpp20: CPP_STD = c++20
cpp23: CPP_STD = c++23
cpp11 cpp14 cpp17 cpp20 cpp23: build
#############################################################

build: CXXFLAGS += "-std=$(CPP_STD)"
build: clean $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^

%.o: %.cpp
	$(call add_file_banner,$<)
	$(CXX) $(CXXFLAGS) -c $<

clean:
	rm -rf $(TARGET) *.o *.exe *.stackdump

run: $(TARGET)
	clear
	./$(TARGET)

help:
	@echo "make (build with default cpp standard 17)"
	@echo "make clean"
	@echo "make cpp14 / cpp17 / cpp20 / cpp23"
	@echo "make run"
	@echo "make help"
	@echo "make clean cpp14 run   (clean, build with cpp14, and run)"

.PHONY: all clean run help

##########################################################################################################################
# File Header Info
define add_file_banner
	@if grep -q " * File         : " $1; \
	then \
		sed -i 's/\( \* Date         : \).*/\1'"$(COMPILED_DATE)"'/' $1; \
		sed -i 's/\( \* C++ Standard : \).*/\1$(CPP_STD)/' $1; \
	else \
		echo "/******************************************************************" > banner.tmp; \
		echo " * File         : $1" >> banner.tmp; \
		echo " * Description  :" >> banner.tmp; \
		echo " * Author       : $(AUTHOR_NAME)" >> banner.tmp; \
		echo " * Date         : $(COMPILED_DATE)" >> banner.tmp; \
		echo " * C++ Standard : $(CPP_STD)" >> banner.tmp; \
		echo " ******************************************************************/" >> banner.tmp; \
		cat $1 >> banner.tmp; \
		mv banner.tmp $1; \
	fi
endef
