#******************************************************************************
#
# Makefile - Rules for building the Simplelink library.
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
SDK_ROOT=../..

# Sources root directory
SRC_ROOT=..

# Output directory
OUTDIR=lib

# Lib Name
LIBRARY=libsimplelink.a
DEBUG_NONOS_LIBRARY=$(OUTDIR)/nonos/Debug/${LIBRARY}
RELEASE_NONOS_LIBRARY=$(OUTDIR)/nonos/Release/${LIBRARY}
DEBUG_OS_LIBRARY=$(OUTDIR)/os/Debug/${LIBRARY}
RELEASE_OS_LIBRARY=$(OUTDIR)/os/Release/${LIBRARY}
DEBUG_OS_PM_LIBRARY=$(OUTDIR)/os_PM/Debug/${LIBRARY}
RELEASE_OS_PM_LIBRARY=$(OUTDIR)/os_PM/Release/${LIBRARY}

DEBUG_NONOS_OBJPATH=obj/nonos/Debug
RELEASE_NONOS_OBJPATH=obj/nonos/Release
DEBUG_OS_OBJPATH=obj/os/Debug
RELEASE_OS_OBJPATH=obj/os/Release
DEBUG_OS_PM_OBJPATH=obj/os_PM/Debug
RELEASE_OS_PM_OBJPATH=obj/os_PM/Release

# Tools Setup
CROSS_COMPILE ?= arm-none-eabi-

CC=$(CROSS_COMPILE)gcc
AR=$(CROSS_COMPILE)ar

# Where to find header files
IPATH=-I${SDK_ROOT}
IPATH+=-I${SRC_ROOT}
IPATH+=-I${SRC_ROOT}/include
IPATH+=-I${SDK_ROOT}/inc
IPATH+=-I${SDK_ROOT}/driverlib
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
       $(IPATH)

PM_ROOT=$(SDK_ROOT)/middleware
PM_IPATH=-I${PM_ROOT}/driver -I${PM_ROOT}/driver/hal -I${PM_ROOT}/framework/pm -I${PM_ROOT}/framework/timer -I${PM_ROOT}/soc

OSLIB_ROOT=$(SDK_ROOT)/oslib
OS_IPATH=-I$(OSLIB_ROOT)

DEBUG_CFLAGS=-O0 -DSL_FULL
RELEASE_CFLAGS=-Os -DTARGET_IS_CC3200 -DSL_FULL

DEBUG_NONOS_CFLAGS=$(DEBUG_CFLAGS)
RELEASE_NONOS_CFLAGS=$(RELEASE_CFLAGS)
DEBUG_OS_CFLAGS=$(OS_IPATH) $(DEBUG_CFLAGS) -DSL_PLATFORM_MULTI_THREADED -DUSE_FREERTOS
RELEASE_OS_CFLAGS=$(OS_IPATH) $(RELEASE_CFLAGS) -DSL_PLATFORM_MULTI_THREADED -DUSE_FREERTOS
DEBUG_OS_PM_CFLAGS=$(OS_IPATH) $(PM_IPATH) $(DEBUG_CFLAGS) -DSL_PLATFORM_MULTI_THREADED -DUSE_FREERTOS
RELEASE_OS_PM_CFLAGS=$(OS_IPATH) $(PM_IPATH) $(RELEASE_CFLAGS) -DSL_PLATFORM_MULTI_THREADED -DUSE_FREERTOS

# Sources
SOURCES= device.c driver.c flowcont.c netapp.c netcfg.c nonos.c fs.c socket.c spawn.c wlan.c

NOT_PM_SOURCES=cc_pal.c $(SOURCES)
PM_SOURCES=cc_pal_pm.c $(SOURCES)

vpath %.c $(SRC_ROOT):$(SRC_ROOT)/source

# Directory creator
dir_create=@mkdir -p $(@D)

# Objects
DEBUG_NONOS_OBJECTS= $(NOT_PM_SOURCES:%.c=$(DEBUG_NONOS_OBJPATH)/%.o)
RELEASE_NONOS_OBJECTS= $(NOT_PM_SOURCES:%.c=$(RELEASE_NONOS_OBJPATH)/%.o)

DEBUG_OS_OBJECTS= $(NOT_PM_SOURCES:%.c=$(DEBUG_OS_OBJPATH)/%.o)
RELEASE_OS_OBJECTS= $(NOT_PM_SOURCES:%.c=$(RELEASE_OS_OBJPATH)/%.o)

DEBUG_OS_PM_OBJECTS= $(PM_SOURCES:%.c=$(DEBUG_OS_PM_OBJPATH)/%.o)
RELEASE_OS_PM_OBJECTS= $(PM_SOURCES:%.c=$(RELEASE_OS_PM_OBJPATH)/%.o)

all: debug release

debug: nonos_dbg os_dbg os_pm_dbg
release: nonos_rel os_rel os_pm_rel

nonos: nonos_dbg nonos_rel
os: os_dbg os_rel
os_pm: os_pm_dbg os_pm_rel

# Rules for rebuild when dependencies changed
# GCC option -MD enables dependency rules generation
-include $(NOT_PM_SOURCES:%.c=$(DEBUG_NONOS_OBJPATH)/%.d)
-include $(NOT_PM_SOURCES:%.c=$(RELEASE_NONOS_OBJPATH)/%.d)
-include $(NOT_PM_SOURCES:%.c=$(DEBUG_OS_OBJPATH)/%.d)
-include $(NOT_PM_SOURCES:%.c=$(RELEASE_OS_OBJPATH)/%.d)
-include $(PM_SOURCES:%.c=$(DEBUG_OS_PM_OBJPATH)/%.d)
-include $(PM_SOURCES:%.c=$(RELEASE_OS_PM_OBJPATH)/%.d)

print-%: ; @echo $*=$($*)

# *.o build rules
$(DEBUG_NONOS_OBJPATH)/%.o: %.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(DEBUG_NONOS_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(RELEASE_NONOS_OBJPATH)/%.o: %.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(RELEASE_NONOS_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(DEBUG_OS_OBJPATH)/%.o: %.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(DEBUG_OS_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(RELEASE_OS_OBJPATH)/%.o: %.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(RELEASE_OS_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(DEBUG_OS_PM_OBJPATH)/%.o: %.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(DEBUG_OS_PM_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(RELEASE_OS_PM_OBJPATH)/%.o: %.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(RELEASE_OS_PM_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

# *.a build rules
$(DEBUG_NONOS_LIBRARY): $(DEBUG_NONOS_OBJECTS)
	$(dir_create)
	@${AR} -cr $@ $(DEBUG_NONOS_OBJECTS)
	@echo "AR	$@";

$(RELEASE_NONOS_LIBRARY): $(RELEASE_NONOS_OBJECTS)
	$(dir_create)
	@${AR} -cr $@ $(RELEASE_NONOS_OBJECTS)
	@echo "AR	$@";

$(DEBUG_OS_LIBRARY): $(DEBUG_OS_OBJECTS)
	$(dir_create)
	@${AR} -cr $@ $(DEBUG_OS_OBJECTS)
	@echo "AR	$@";

$(RELEASE_OS_LIBRARY): $(RELEASE_OS_OBJECTS)
	$(dir_create)
	@${AR} -cr $@ $(RELEASE_OS_OBJECTS)
	@echo "AR	$@";

$(DEBUG_OS_PM_LIBRARY): $(DEBUG_OS_PM_OBJECTS)
	$(dir_create)
	@${AR} -cr $@ $(DEBUG_OS_PM_OBJECTS)
	@echo "AR	$@";

$(RELEASE_OS_PM_LIBRARY): $(RELEASE_OS_PM_OBJECTS)
	$(dir_create)
	@${AR} -cr $@ $(RELEASE_OS_PM_OBJECTS)
	@echo "AR	$@";

# Rules for build all types of libs
nonos_dbg: $(DEBUG_NONOS_LIBRARY)
nonos_rel: $(RELEASE_NONOS_LIBRARY)
os_dbg: $(DEBUG_OS_LIBRARY)
os_rel: $(RELEASE_OS_LIBRARY)
os_pm_dbg: $(DEBUG_OS_PM_LIBRARY)
os_pm_rel: $(RELEASE_OS_PM_LIBRARY)

# clean rules
clean_nonos_dbg:
	@rm -rf $(DEBUG_NONOS_OBJPATH)/*.d
	@echo "rm -rf $(DEBUG_NONOS_OBJPATH)/*.d";
	@rm -rf $(DEBUG_NONOS_OBJPATH)/*.o
	@echo "rm -rf $(DEBUG_NONOS_OBJPATH)/*.o";
	@rm -rf $(DEBUG_NONOS_LIBRARY)
	@echo "rm -rf $(DEBUG_NONOS_LIBRARY)";

clean_nonos_rel:
	@rm -rf $(RELEASE_NONOS_OBJPATH)/*.d
	@echo "rm -rf $(RELEASE_NONOS_OBJPATH)/*.d";
	@rm -rf $(RELEASE_NONOS_OBJPATH)/*.o
	@echo "rm -rf $(RELEASE_NONOS_OBJPATH)/*.o";
	@rm -rf $(RELEASE_NONOS_LIBRARY)
	@echo "rm -rf $(RELEASE_NONOS_LIBRARY)";

clean_os_dbg:
	@rm -rf $(DEBUG_OS_OBJPATH)/*.d
	@echo "rm -rf $(DEBUG_OS_OBJPATH)/*.d";
	@rm -rf $(DEBUG_OS_OBJPATH)/*.o
	@echo "rm -rf $(DEBUG_OS_OBJPATH)/*.o";
	@rm -rf $(DEBUG_OS_LIBRARY)
	@echo "rm -rf $(DEBUG_OS_LIBRARY)";

clean_os_rel:
	@rm -rf $(RELEASE_OS_OBJPATH)/*.d
	@echo "rm -rf $(RELEASE_OS_OBJPATH)/*.d";
	@rm -rf $(RELEASE_OS_OBJPATH)/*.o
	@echo "rm -rf $(RELEASE_OS_OBJPATH)/*.o";
	@rm -rf $(RELEASE_OS_LIBRARY)
	@echo "rm -rf $(RELEASE_OS_LIBRARY)";

clean_os_pm_dbg:
	@rm -rf $(DEBUG_OS_PM_OBJPATH)/*.d
	@echo "rm -rf $(DEBUG_OS_PM_OBJPATH)/*.d";
	@rm -rf $(DEBUG_OS_PM_OBJPATH)/*.o
	@echo "rm -rf $(DEBUG_OS_PM_OBJPATH)/*.o";
	@rm -rf $(DEBUG_OS_PM_LIBRARY)
	@echo "rm -rf $(DEBUG_OS_PM_LIBRARY)";

clean_os_pm_rel:
	@rm -rf $(RELEASE_OS_PM_OBJPATH)/*.d
	@echo "rm -rf $(RELEASE_OS_PM_OBJPATH)/*.d";
	@rm -rf $(RELEASE_OS_PM_OBJPATH)/*.o
	@echo "rm -rf $(RELEASE_OS_PM_OBJPATH)/*.o";
	@rm -rf $(RELEASE_OS_PM_LIBRARY)
	@echo "rm -rf $(RELEASE_OS_PM_LIBRARY)";

clean_debug: clean_nonos_dbg clean_os_dbg clean_os_pm_dbg
clean_release: clean_nonos_rel clean_os_rel clean_os_pm_rel

clean: clean_debug clean_release
