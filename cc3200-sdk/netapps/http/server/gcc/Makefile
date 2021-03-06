#******************************************************************************
#
# Makefile - Rules for building the Http Server library.
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
LIBRARY=libwebserver.a
DEBUG_LIBRARY=$(OUTDIR)/Debug/${LIBRARY}
RELEASE_LIBRARY=$(OUTDIR)/Release/${LIBRARY}

DEBUG_OBJPATH=obj/Debug
RELEASE_OBJPATH=obj/Release

# Tools Setup
CROSS_COMPILE ?= arm-none-eabi-

CC=$(CROSS_COMPILE)gcc
AR=$(CROSS_COMPILE)ar

# Where to find header files
IPATH=-I${SDK_ROOT}
IPATH+=-I${SRC_ROOT}
IPATH+=-I${NETAPPS_ROOT}
IPATH+=-I${SDK_ROOT}/inc
IPATH+=-I${SDK_ROOT}/driverlib
IPATH+=-I${SDK_ROOT}/oslib
IPATH+=-I${SDK_ROOT}/simplelink/include
IPATH+=-I${SDK_ROOT}/simplelink_extlib/provisioninglib
IPATH+=-I${SDK_ROOT}/example/common

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
       -DSL_PLATFORM_MULTI_THREADED \
       -DUSE_FREERTOS \
       $(IPATH)

DEBUG_CFLAGS=-O0
RELEASE_CFLAGS=-Os -DTARGET_IS_CC3200

# Sources
SOURCES = base64.c \
          HttpAuth.c \
          HttpCore.c \
          HttpDebug.c \
          HttpDynamic.c \
          HttpSocket.c \
          HttpStatic.c \
          HttpString.c \
          sha1.c \
          strlib.c \
          WebSockHandler.c \

vpath %.c $(SRC_ROOT)

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

# *.o build rules
$(DEBUG_OBJPATH)/%.o: %.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(DEBUG_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(RELEASE_OBJPATH)/%.o: %.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(RELEASE_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

# *.a build rules
$(DEBUG_LIBRARY): $(DEBUG_OBJECTS)
	$(dir_create)
	@${AR} -cr $@ $(DEBUG_OBJECTS)
	@echo "AR	$@";

$(RELEASE_LIBRARY): $(RELEASE_OBJECTS)
	$(dir_create)
	@${AR} -cr $@ $(RELEASE_OBJECTS)
	@echo "AR	$@";

# Rules for build all types of libs
debug: $(DEBUG_LIBRARY)
release: $(RELEASE_LIBRARY)

# clean rules
clean_debug:
	@rm -rf $(DEBUG_OBJPATH)/*.d
	@echo "rm -rf $(DEBUG_OBJPATH)/*.d";
	@rm -rf $(DEBUG_OBJPATH)/*.o
	@echo "rm -rf $(DEBUG_OBJPATH)/*.o";
	@rm -rf $(DEBUG_LIBRARY)
	@echo "rm -rf $(DEBUG_LIBRARY)";

clean_release:
	@rm -rf $(RELEASE_OBJPATH)/*.d
	@echo "rm -rf $(RELEASE_OBJPATH)/*.d";
	@rm -rf $(RELEASE_OBJPATH)/*.o
	@echo "rm -rf $(RELEASE_OBJPATH)/*.o";
	@rm -rf $(RELEASE_LIBRARY)
	@echo "rm -rf $(RELEASE_LIBRARY)";

clean: clean_debug clean_release
