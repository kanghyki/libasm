# **************************************************
# * TARGET NAME                                    *
# **************************************************
NAME = libasm.a

# **************************************************
# * SOURCE                                         *
# **************************************************
SRC_PATH = ./src
SRC = ft_read.s\
			ft_strcmp.s\
			ft_strcpy.s\
			ft_strdup.s\
			ft_strlen.s\
			ft_write.s
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
ASFLAGS =
OS = $(shell uname -s)
ifeq ($(OS),Linux) # Linux
	ASFLAGS := -f elf64
endif
ifeq ($(OS),Darwin) # Mac
	ASFLAGS := -f macho64
endif

AR = ar
ARFLAGS = -rcs

ARCH = $(shell uname -m)
ifeq ($(ARCH),arm64) # arm64
	CC := arch -x86_64 gcc
	AR := arch -x86_64 ar
endif

# **************************************************
# * RULE                                           *
# **************************************************
all: $(NAME)

%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

$(NAME): $(OBJS)
	$(AR) $(ARFLAGS) $(NAME) $(OBJS)

clean:
	rm -f $(OBJS)
	rm -f $(TEST_OBJS)

fclean: clean
	rm -f $(NAME)
	rm -f $(TEST_NAME)

re:
	@make fclean
	@make all

test:
	@make $(NAME)
	@make $(TEST_NAME)

$(TEST_NAME): $(TEST_OBJS) $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(TEST_OBJS) -o $(TEST_NAME)

# **************************************************
# * PHONY                                          *
# **************************************************
.PHONY: all clean fclean re test
