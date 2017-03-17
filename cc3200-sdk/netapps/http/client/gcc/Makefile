#******************************************************************************
#
# Makefile - Rules for building the Http Client library.
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

# The base SDK directory.
SDK_ROOT=../../../..
NETAPPS_ROOT=$(SDK_ROOT)/netapps

# Sources root directory
SRC_ROOT=..

# Output directory
OUTDIR=lib

# Lib Name
LIBRARY=libwebclient.a
DEBUG_FULL_LIBRARY=$(OUTDIR)/full/Debug/${LIBRARY}
RELEASE_FULL_LIBRARY=$(OUTDIR)/full/Release/${LIBRARY}
DEBUG_MIN_LIBRARY=$(OUTDIR)/min/Debug/${LIBRARY}
RELEASE_MIN_LIBRARY=$(OUTDIR)/min/Release/${LIBRARY}

DEBUG_FULL_OBJPATH=obj/full/Debug
RELEASE_FULL_OBJPATH=obj/full/Release
DEBUG_MIN_OBJPATH=obj/min/Debug
RELEASE_MIN_OBJPATH=obj/min/Release

# Tools Setup
CROSS_COMPILE ?= arm-none-eabi-

CC=$(CROSS_COMPILE)gcc
AR=$(CROSS_COMPILE)ar

# Where to find header files
IPATH=-I${SDK_ROOT}
IPATH+=-I${SRC_ROOT}
IPATH+=-I${NETAPPS_ROOT}
IPATH+=-I${SDK_ROOT}/inc
IPATH+=-I${SDK_ROOT}/simplelink/include
IPATH+=-I${SDK_ROOT}/simplelink_extlib/provisioninglib

# C Compiler Flags
CFLAGS_COMMON=-mthumb       \
       -mcpu=cortex-m4      \
       -ffunction-sections  \
       -fdata-sections      \
       -MD                  \
       -std=c99             \
       -Wall                \
       -g                   \
       -Dgcc                \
       -D__SL__             \
       $(IPATH)

DEBUG_CFLAGS=-O0
RELEASE_CFLAGS=-Os -DTARGET_IS_CC3200

MIN_CFLAGS=-DHTTPCli_LIBTYPE_MIN
FULL_CFLAGS=-DSL_PLATFORM_MULTI_THREADED -D__OSI__ -I${SDK_ROOT}/oslib

DEBUG_FULL_CFLAGS=$(DEBUG_CFLAGS) $(FULL_CFLAGS)
RELEASE_FULL_CFLAGS=$(RELEASE_CFLAGS) $(FULL_CFLAGS)
DEBUG_MIN_CFLAGS=$(DEBUG_CFLAGS) $(MIN_CFLAGS)
RELEASE_MIN_CFLAGS=$(RELEASE_CFLAGS) $(MIN_CFLAGS)

# Sources
MIN_SOURCES=httpcli.c httpstr.c lookup.c ssock.c
FULL_SOURCES=$(MIN_SOURCES)
#		urlfile.c

vpath %.c $(SRC_ROOT)

# Directory creator
dir_create=@mkdir -p $(@D)

# Objects
DEBUG_FULL_OBJECTS= $(FULL_SOURCES:%.c=$(DEBUG_FULL_OBJPATH)/%.o)
RELEASE_FULL_OBJECTS= $(FULL_SOURCES:%.c=$(RELEASE_FULL_OBJPATH)/%.o)

DEBUG_MIN_OBJECTS= $(MIN_SOURCES:%.c=$(DEBUG_MIN_OBJPATH)/%.o)
RELEASE_MIN_OBJECTS= $(MIN_SOURCES:%.c=$(RELEASE_MIN_OBJPATH)/%.o)

all: debug release

debug: full_dbg min_dbg
release: full_rel min_rel

full: full_dbg full_rel
min: min_dbg min_rel

# Rules for rebuild when dependencies changed
# GCC option -MD enables dependency rules generation
-include $(FULL_SOURCES:%.c=$(DEBUG_FULL_OBJPATH)/%.d)
-include $(FULL_SOURCES:%.c=$(RELEASE_FULL_OBJPATH)/%.d)
-include $(MIN_SOURCES:%.c=$(DEBUG_MIN_OBJPATH)/%.d)
-include $(MIN_SOURCES:%.c=$(RELEASE_MIN_OBJPATH)/%.d)

# *.o build rules
$(DEBUG_FULL_OBJPATH)/%.o: %.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(DEBUG_FULL_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(RELEASE_FULL_OBJPATH)/%.o: %.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(RELEASE_FULL_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(DEBUG_MIN_OBJPATH)/%.o: %.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(DEBUG_MIN_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(RELEASE_MIN_OBJPATH)/%.o: %.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(RELEASE_MIN_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

# *.a build rules
$(DEBUG_FULL_LIBRARY): $(DEBUG_FULL_OBJECTS)
	$(dir_create)
	@${AR} -cr $@ $(DEBUG_FULL_OBJECTS)
	@echo "AR	$@";

$(RELEASE_FULL_LIBRARY): $(RELEASE_FULL_OBJECTS)
	$(dir_create)
	@${AR} -cr $@ $(RELEASE_FULL_OBJECTS)
	@echo "AR	$@";

$(DEBUG_MIN_LIBRARY): $(DEBUG_MIN_OBJECTS)
	$(dir_create)
	@${AR} -cr $@ $(DEBUG_MIN_OBJECTS)
	@echo "AR	$@";

$(RELEASE_MIN_LIBRARY): $(RELEASE_MIN_OBJECTS)
	$(dir_create)
	@${AR} -cr $@ $(RELEASE_MIN_OBJECTS)
	@echo "AR	$@";

# Rules for build all types of libs
full_dbg: $(DEBUG_FULL_LIBRARY)
full_rel: $(RELEASE_FULL_LIBRARY)
min_dbg: $(DEBUG_MIN_LIBRARY)
min_rel: $(RELEASE_MIN_LIBRARY)

# clean rules
clean_full_dbg:
	@rm -rf $(DEBUG_FULL_OBJPATH)/*.d
	@echo "rm -rf $(DEBUG_FULL_OBJPATH)/*.d";
	@rm -rf $(DEBUG_FULL_OBJPATH)/*.o
	@echo "rm -rf $(DEBUG_FULL_OBJPATH)/*.o";
	@rm -rf $(DEBUG_FULL_LIBRARY)
	@echo "rm -rf $(DEBUG_FULL_LIBRARY)";

clean_full_rel:
	@rm -rf $(RELEASE_FULL_OBJPATH)/*.d
	@echo "rm -rf $(RELEASE_FULL_OBJPATH)/*.d";
	@rm -rf $(RELEASE_FULL_OBJPATH)/*.o
	@echo "rm -rf $(RELEASE_FULL_OBJPATH)/*.o";
	@rm -rf $(RELEASE_FULL_LIBRARY)
	@echo "rm -rf $(RELEASE_FULL_LIBRARY)";

clean_min_dbg:
	@rm -rf $(DEBUG_MIN_OBJPATH)/*.d
	@echo "rm -rf $(DEBUG_MIN_OBJPATH)/*.d";
	@rm -rf $(DEBUG_MIN_OBJPATH)/*.o
	@echo "rm -rf $(DEBUG_MIN_OBJPATH)/*.o";
	@rm -rf $(DEBUG_MIN_LIBRARY)
	@echo "rm -rf $(DEBUG_MIN_LIBRARY)";

clean_min_rel:
	@rm -rf $(RELEASE_MIN_OBJPATH)/*.d
	@echo "rm -rf $(RELEASE_MIN_OBJPATH)/*.d";
	@rm -rf $(RELEASE_MIN_OBJPATH)/*.o
	@echo "rm -rf $(RELEASE_MIN_OBJPATH)/*.o";
	@rm -rf $(RELEASE_MIN_LIBRARY)
	@echo "rm -rf $(RELEASE_MIN_LIBRARY)";

clean_debug: clean_full_dbg clean_min_dbg
clean_release: clean_full_rel clean_min_rel

clean: clean_debug clean_release
