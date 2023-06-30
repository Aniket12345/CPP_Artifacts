#####
# Makefile for CPP practice
#
# Developer: Jestin PJ and Aniket Fondekar 
#
# Date: 30 June 2023 
# -----usage------------ start
# make                   (build with default cpp standard 17)
# make clean
# make cpp14 / make cpp17 / make cpp20 /make cpp23
# make run
# make help
# make clean cpp14 run   (clean, build with cpp14 and run)
# make build
# -----usage------------ end
######

# Add author name Here
AUTHOR_NAME = "Aniket Fondekar"
#############################################################

COMPILED_DATE = $$(date +"%Y-%m-%d")

TARGET = main

SRC = src
INC = inc
BIN = bin
CC = g++
CPP_STD = c++17

RED = \033[1;31m
GREEN = \033[1;32m
BLUE = \033[1;34m
YELLOW = \033[1;33m
NC = \033[1;0m

CFLAGS = -Wall -std=$(CPP_STD) -I$(INC)

SOURCE = $(wildcard $(SRC)/*.cpp)

OBJECT = $(patsubst %,$(BIN)/%,$(filter %.o,$(notdir $(SOURCE:.cpp=.o))))

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
	
build : clean $(BIN)/$(TARGET)

$(BIN)/$(TARGET) : $(OBJECT) 
	@echo "Linking..."
	$(CC) -o $@ $^
	@echo "Finished"

$(BIN)/%.o: $(SRC)/%.cpp
	@echo "Compiling... "
	$(call add_file_banner,$<)
	$(CC) $(CFLAGS) -c $< -o $@ 
#.PHONY : run clean help dost

run : $(BIN)/$(TARGET) 
	@echo "Running..."
	@./$(BIN)/$(TARGET)

clean:
	@rm -rf $(OBJECT) $(BIN)/$(TARGET)
	
help : 
	@echo "make (build with default cpp standard 17)"
	@echo "make clean"
	@echo "make cpp14 / cpp17 / cpp20 / cpp23"
	@echo "make run"
	@echo "make help"
	@echo "make clean cpp14 run   (clean, build with cpp14, and run)"
	
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