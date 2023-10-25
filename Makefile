# **************************************************
# * TARGET NAME                                    *
# **************************************************
NAME = libasm.a

# **************************************************
# * SOURCE                                         *
# **************************************************
SRC_PATH = ./src/
SRC = main.s
SRCS = $(addprefix $(SRC_PATH), $(SRC))
OBJS = $(SRCS:.s=.o)

# **************************************************
# * VARIABLE                                       *
# **************************************************
AS = nasm
ASFLAGS = -f elf64
AR = ar
ARFLAGS = -rc # s

# **************************************************
# * RULE                                           *
# **************************************************
all: $(NAME)

%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

$(NAME): $(OBJS)
	$(AR) $(ARFLAGS) $(NAME) $(OBJS)

clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(NAME)

re:
	make fclean
	make all

# **************************************************
# * PHONY                                          *
# **************************************************
.PHONY: all clean fclean re