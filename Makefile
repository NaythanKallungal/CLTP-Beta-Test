# Compiler and flags
CC = gcc
CFLAGS = -W
DEBUG_FLAGS = -g -DDEBUG

#dirs
OUTPUT_DIR = outputs
BIN_DIR = bin

# Source and object files
SRC = reorder.c
READABLE_OBJ = $(BIN_DIR)/reorder.o
OBJ = $(BIN_DIR)/main.o $(BIN_DIR)/parser.o
EXEC = $(BIN_DIR)/orderlogs
REFERENCE_EXEC = ref_order

#default target doesnt do anything
.PHONY: bronto
bronto:
	echo "oops read the makefile!"

# generates the executable and the bin dir. PLEASE PLEASE PLEASE DO NOT DELETE BIN
trex: $(BIN_DIR) $(READABLE_OBJ)
	$(CC) $(OBJ) $(READABLE_OBJ) -o $(EXEC)
	@bash .aicheck

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# Pattern rule for compiling .c files into .o files
$(BIN_DIR)/%.o: %.c | $(BIN_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Debug target (compiles with debug flags)
trike: CFLAGS += $(DEBUG_FLAGS)
trike: trex

# Checks all outputs for all test cases
raptor: trex
	@for testfile in testcases/*; do \
		echo "Running $$testfile..."; \
		./$(EXEC) -f $$testfile; \
	done

# compare target compares output with trie_ref
stego: trex
	@mkdir -p $(OUTPUT_DIR)
	@for testfile in testcases/*; do \
		base_name=$$(basename $$testfile); \
		./$(EXEC) -f $$testfile > $(OUTPUT_DIR)/$$base_name.out; \
		./$(REFERENCE_EXEC) -f $$testfile > $(OUTPUT_DIR)/$$base_name.ref; \
		out_tmp=$$(mktemp); \
		ref_tmp=$$(mktemp); \
		tr -d '\n' < $(OUTPUT_DIR)/$$base_name.out > $$out_tmp; \
		tr -d '\n' < $(OUTPUT_DIR)/$$base_name.ref > $$ref_tmp; \
		if diff $$out_tmp $$ref_tmp > /dev/null; then \
			echo "✅ PASSED $$testfile"; \
		else \
			echo "❌ FAILED $$testfile"; \
			echo "Diff (ignoring newlines):"; \
			diff $$out_tmp $$ref_tmp; \
		fi; \
		rm -f $$out_tmp $$ref_tmp; \
	done


# Clean target to remove compiled files DO NOT REMOVE THE SUPPLIED .o FILES
spinosaurus:
	rm -f $(EXEC) $(READABLE_OBJ)

.PHONY: ptera
ptera: $(BIN_DIR)
	$(CC) $(CFLAGS) -Wall -Wextra -Wpedantic -Werror -O3 -c main.c -o $(BIN_DIR)/main.o
	$(CC) $(CFLAGS) -Wall -Wextra -Wpedantic -Werror -O3 -c parser.c -o $(BIN_DIR)/parser.o
