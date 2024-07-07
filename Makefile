################################
# WealthCode Makefile on linux #
################################

CC           = gcc
MAINROOT     = .
TARGET       =app

OBJROOT      = ./OBJ
MAINOBJ_PATH = $(OBJROOT)/mainObj

# 主目录添加新模块时此处添加源文件目录
MAINDIRS     = main/src common/src calc/src

MAINSRCS = $(foreach DIR, $(MAINDIRS), $(wildcard $(MAINROOT)/$(DIR)/*.c))
MAINOBJS = $(patsubst $(MAINROOT)%, $(MAINOBJ_PATH)%, $(MAINSRCS:.c=.o))

LDFLAGS  = -lpthread  -lcjson -L./Lib -lm -lssl

# 预编译选项
PREDEF   += -D_LIUX_TEST_

# 主目录添加新模块时此处添加头文件目录
INCLUDE  = -I./common/inc  -I./calc/inc 
INCLUDE  := $(sort $(INCLUDE))

CFLAGS     = -std=gnu11 -g
CFLAGS     += $(PREDEF) $(CUSTOM_FLAGS) $(INCLUDE)

.PHONY : all clean build

all: $(OBJROOT)/$(TARGET)
	mv $(OBJROOT)/$(TARGET) ./$(TARGET)
	@echo WealthCode Build Complete. See ./$(TARGET)

#link
$(OBJROOT)/$(TARGET): $(MAINOBJS) 
	$(CC) -o $@ $^ $(LDFLAGS) -Wl,-Map=$(OBJROOT)/WC.map

# Compile main(.c -> .o)
$(MAINOBJ_PATH)/%.o: $(MAINROOT)/%.c
	@if [ ! -e `dirname $@` ]; then mkdir -p `dirname $@`; fi
	$(CC) $(CFLAGS) $(INCLUDE) -o $@ -c $<

clean:
	$(RM) -r $(OBJROOT)
	$(RM) -r $(TARGET)

build: clean all



