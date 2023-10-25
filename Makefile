# **************************************************
# * TARGET NAME                                    *
# **************************************************
NAME = libasm.a

# **************************************************
# * SOURCE                                         *
# **************************************************
SRC_PATH = ./src
SRC = my_asm.s
SRCS = $(addprefix $(SRC_PATH)/, $(SRC))
OBJS = $(SRCS:.s=.o)

# **************************************************
# * TEST                                           *
# **************************************************
TEST_NAME = run_test
TEST_SRC_PATH = ./test
TEST_SRC = main.c
TEST_SRCS = $(addprefix $(TEST_SRC_PATH)/, $(TEST_SRC))
TEST_OBJS = $(TEST_SRCS:.c=.o)

# **************************************************
# * VARIABLE                                       *
# **************************************************
CC = gcc
CFLAGS = -Wall -Wextra -Werror
LDFLAGS = -lasm -L./
AS = nasm
ASFLAGS = -f macho64
AR = ar
ARFLAGS = -rcs

# **************************************************
# * RULE                                           *
# **************************************************
all: $(NAME)

%.o: %.c
	$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@

%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

$(NAME): $(OBJS)
	$(AR) $(ARFLAGS) $(NAME) $(OBJS)

clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(NAME)

re:
	@make fclean
	@make all

test:
	@make $(NAME)
	@make $(TEST_NAME)

$(TEST_NAME): $(TEST_OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(TEST_OBJS) -o $(TEST_NAME)

tclean:
	rm -f $(TEST_OBJS) $(TEST_NAME)

# **************************************************
# * PHONY                                          *
# **************************************************
.PHONY: all clean fclean re test tclean
