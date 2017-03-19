#******************************************************************************
#
# common.make - Common rules for building all the examples.
#               Must be included by example's Makefile.
#
#	v- 1.3.0
#
# The MIT License
#
# Copyright (c) 2017 Siarhei Volkau
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
#*****************************************************************************

.PHONY: all clean

#check variables for build
ifeq (,$(SDK_ROOT))
	$(error SDK_ROOT must be defined!)
endif
ifeq (,$(SRC_ROOT))
	$(error SRC_ROOT must be defined!)
endif
ifeq (,$(SOURCES))
	$(error SOURCES must be defined!)
endif
ifeq (,$(EXE_NAME))
	$(error EXE_NAME must be defined!)
endif

USE_LIBS ?= driverlib

LDSCRIPT ?= $(SDK_ROOT)/example/common/gcc/cc3200r1m2.ld

# make common sources accessible
ifneq (,$(findstring _if.c,$(SOURCES))$(findstring startup_gcc.c,$(SOURCES)))
    vpath %.c $(SDK_ROOT)/example/common
    IPATH += -I$(SDK_ROOT)/example/common
endif

# Tools Setup
CROSS_COMPILE ?= arm-none-eabi-

CC=$(CROSS_COMPILE)gcc
LD=$(CROSS_COMPILE)ld
OBJCOPY=$(CROSS_COMPILE)objcopy

# C Compiler Flags
CFLAGS_COMMON=-mthumb       \
       -mcpu=cortex-m4      \
       -ffunction-sections  \
       -fdata-sections      \
       -MD                  \
       -std=c99             \
       -Wall                \
       -g                   \
       -Dgcc

RELEASE_CFLAGS=-Os -DTARGET_IS_CC3200
DEBUG_CFLAGS=-O0

include $(USE_LIBS:%=$(SDK_ROOT)/example/common/gcc/%.inc)

CFLAGS_COMMON += $(IPATH)

LIBC_TYPE ?= nano
LIBGCC=$(shell $(CC) $(CFLAGS_COMMON) "-print-file-name=libgcc.a")
LIBNOSYS=$(shell $(CC) $(CFLAGS_COMMON) "-print-file-name=libnosys.a")
LIBC_NANO=$(shell $(CC) $(CFLAGS_COMMON) "-print-file-name=libc_nano.a")
LIBC=$(shell $(CC) $(CFLAGS_COMMON) "-print-file-name=libc.a")
LIBM=$(shell $(CC) $(CFLAGS_COMMON) "-print-file-name=libm.a")

ifeq (nano,$(LIBC_TYPE))
    STDLIBS="$(LIBM)" "$(LIBC_NANO)" "$(LIBGCC)" "$(LIBNOSYS)"
else
    STDLIBS="$(LIBM)" "$(LIBC)" "$(LIBGCC)"
endif

APP_PREFIX ?=

DEBUG_BINARY=bin/$(APP_PREFIX)/Debug/$(EXE_NAME).bin
DEBUG_ELF=bin/$(APP_PREFIX)/Debug/$(EXE_NAME).elf
RELEASE_BINARY=bin/$(APP_PREFIX)/Release/$(EXE_NAME).bin
RELEASE_ELF=bin/$(APP_PREFIX)/Release/$(EXE_NAME).elf

DEBUG_OBJPATH=obj/$(APP_PREFIX)/Debug
RELEASE_OBJPATH=obj/$(APP_PREFIX)/Release

ENTRY_POINT ?= ResetISR

# Directory creator
dir_create=@mkdir -p $(@D)

# Objects
DEBUG_OBJECTS= $(SOURCES:%.c=$(DEBUG_OBJPATH)/%.o)
RELEASE_OBJECTS= $(SOURCES:%.c=$(RELEASE_OBJPATH)/%.o)

all: debug release

# Rules for rebuild when dependencies changed
# GCC option -MD enables dependency rules generation
-include $(SOURCES:%.c=$(DEBUG_OBJPATH)/%.d)
-include $(SOURCES:%.c=$(RELEASE_OBJPATH)/%.d)

vpath %.c $(SRC_ROOT)

# *.o build rules
$(DEBUG_OBJPATH)/%.o: %.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(DEBUG_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(RELEASE_OBJPATH)/%.o: %.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(RELEASE_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

# *.elf build rules
$(DEBUG_ELF): $(DEBUG_OBJECTS)
	$(dir_create)
	@${LD} -T$(LDSCRIPT) -Map $(@:%.elf=%.map) --entry $(ENTRY_POINT) --gc-sections -o $@ $(DEBUG_OBJECTS) $(DEBUG_LDLIBS) $(STDLIBS)
	@echo "LD	$@";

$(RELEASE_ELF): $(RELEASE_OBJECTS)
	$(dir_create)
	@${LD} -T$(LDSCRIPT) -Map $(@:%.elf=%.map) --entry $(ENTRY_POINT) --gc-sections -o $@ $(RELEASE_OBJECTS) $(RELEASE_LDLIBS) $(STDLIBS)
	@echo "LD	$@";

# *.bin build rules
$(DEBUG_BINARY): $(DEBUG_ELF) 
	@${OBJCOPY} -O binary $< $@
	@echo "OBJCOPY	$@";

$(RELEASE_BINARY): $(RELEASE_ELF)
	@${OBJCOPY} -O binary $< $@
	@echo "OBJCOPY	$@";

# Rules for build release & debug libs
debug: $(DEBUG_BINARY)

release: $(RELEASE_BINARY)

# clean rules
clean_debug:
	@rm -rf $(DEBUG_OBJPATH)/*.d
	@echo "rm -rf $(DEBUG_OBJPATH)/*.d";
	@rm -rf $(DEBUG_OBJPATH)/*.o
	@echo "rm -rf $(DEBUG_OBJPATH)/*.o";
	@rm -rf $(DEBUG_BINARY) $(DEBUG_ELF) $(DEBUG_ELF:%.elf=%.map)
	@echo "rm -rf $(DEBUG_BINARY) $(DEBUG_ELF) $(DEBUG_ELF:%.elf=%.map)";

clean_release:
	@rm -rf $(RELEASE_OBJPATH)/*.d
	@echo "rm -rf $(RELEASE_OBJPATH)/*.d";
	@rm -rf $(RELEASE_OBJPATH)/*.o
	@echo "rm -rf $(RELEASE_OBJPATH)/*.o";
	@rm -rf $(RELEASE_BINARY) $(RELEASE_ELF) $(RELEASE_ELF:%.elf=%.map)
	@echo "rm -rf $(RELEASE_BINARY) $(RELEASE_ELF) $(RELEASE_ELF:%.elf=%.map)";

clean: clean_debug clean_release

