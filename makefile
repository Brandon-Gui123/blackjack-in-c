INCLUDE_DIR=include
SRC_DIR=src
OUT_DIR=out

PROGRAM_NAME=blackjack

GCC_OPTIONS=-std=c11 -Wall -Wextra -pedantic -g -O0

# all the names of the source files as is, without the directories in between or the extensions
BASE_NAMES := $(basename $(notdir $(wildcard $(SRC_DIR)/*.c)))

# paths of objects (e.g. 'out/basename.o')
OBJS := $(addsuffix .o, $(addprefix $(OUT_DIR)/, $(BASE_NAMES)))

# how to make an object file, if given a .c file
# $@ gets turned into the name of this rule when make runs this
# $< gets turned into what the first dependency of this rule is (which is src/%.c)
$(OUT_DIR)/%.o: $(SRC_DIR)/%.c
	mkdir -p out
	gcc $(GCC_OPTIONS) -I $(INCLUDE_DIR) -c $< -o $@

# how to make our program, given all the objects
$(OUT_DIR)/$(PROGRAM_NAME).out: $(OBJS)
	gcc $(OBJS) -o $@

.PHONY: program
program: $(OUT_DIR)/$(PROGRAM_NAME).out

.PHONY: clean
clean:
	rm -f out/*
