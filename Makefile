CC = gcc
CFLAGS = -Wall -Werror -Wextra -lreadline

SRC_DIR = src
OBJ_DIR = obj

SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))

PREFIX ?= /usr
BIN = $(PREFIX)/bin

TARGET = nutsh

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(TARGET)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm $(OBJ_DIR)/*.o 

install: all
	install -d $(DEST) $(BIN)
	install -m 755 $(TARGET) $(DEST) $(BIN)

uninstall:
	rm -r $(DEST)$(BIN)/$(TARGET)

run:
	./$(TARGET)

.PHONY: all run install uninstall clean 
