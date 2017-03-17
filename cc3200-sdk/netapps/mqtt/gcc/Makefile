#******************************************************************************
#
# Makefile - Rules for building the MQTT library.
#
#	v- 1.2.0
#
#*****************************************************************************

.PHONY: all clean

# The base SDK directory.
SDK_ROOT=../../..
NETAPPS_ROOT=$(SDK_ROOT)/netapps

# Sources root directory
SRC_ROOT=..

# Output directory
OUTDIR=lib

# Lib Name
LIBRARY=libmqtt.a
DEBUG_CLIENT_LIBRARY=$(OUTDIR)/client/Debug/${LIBRARY}
RELEASE_CLIENT_LIBRARY=$(OUTDIR)/client/Release/${LIBRARY}
DEBUG_CLIENT_SERVER_LIBRARY=$(OUTDIR)/client_server/Debug/${LIBRARY}
RELEASE_CLIENT_SERVER_LIBRARY=$(OUTDIR)/client_server/Release/${LIBRARY}

DEBUG_CLIENT_OBJPATH=obj/client/Debug
RELEASE_CLIENT_OBJPATH=obj/client/Release
DEBUG_CLIENT_SERVER_OBJPATH=obj/client_server/Debug
RELEASE_CLIENT_SERVER_OBJPATH=obj/client_server/Release

# Tools Setup
CROSS_COMPILE ?= arm-none-eabi-

CC=$(CROSS_COMPILE)gcc
AR=$(CROSS_COMPILE)ar

# Where to find header files
IPATH=-I${SDK_ROOT}
IPATH+=-I${SRC_ROOT}
IPATH+=-I${SRC_ROOT}/client
IPATH+=-I${SRC_ROOT}/common
IPATH+=-I${SRC_ROOT}/include
IPATH+=-I${SRC_ROOT}/platform
IPATH+=-I${SRC_ROOT}/server
IPATH+=-I${SRC_ROOT}/sl
IPATH+=-I${SDK_ROOT}/driverlib
IPATH+=-I${SDK_ROOT}/oslib
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
       -Wno-char-subscripts \
       -g                   \
       -Dgcc                \
       -D__SL__             \
       -DSL_PLATFORM_MULTI_THREADED\
       $(IPATH)

DEBUG_CFLAGS=-O0 -DDEBUG_NET_DEV
RELEASE_CFLAGS=-Os -DTARGET_IS_CC3200

# Sources
CLIENT_SOURCES=cc32xx_sl_net.c   \
               cc32xx_platform.c \
               mqtt_client.c     \
               mqtt_common.c     \
               sl_mqtt_client.c  \

FULL_SOURCES=$(CLIENT_SOURCES)   \
             client_mgmt.c       \
             server_core.c       \
             server_pkts.c       \
             server_plug.c       \
             server_util.c       \
             sl_mqtt_server.c    \

vpath %.c $(SRC_ROOT)/client:$(SRC_ROOT)/common:$(SRC_ROOT)/platform:$(SRC_ROOT)/server:$(SRC_ROOT)/sl

# Directory creator
dir_create=@mkdir -p $(@D)

# Objects
DEBUG_CLIENT_SERVER_OBJECTS= $(FULL_SOURCES:%.c=$(DEBUG_CLIENT_SERVER_OBJPATH)/%.o)
RELEASE_CLIENT_SERVER_OBJECTS= $(FULL_SOURCES:%.c=$(RELEASE_CLIENT_SERVER_OBJPATH)/%.o)

DEBUG_CLIENT_OBJECTS= $(CLIENT_SOURCES:%.c=$(DEBUG_CLIENT_OBJPATH)/%.o)
RELEASE_CLIENT_OBJECTS= $(CLIENT_SOURCES:%.c=$(RELEASE_CLIENT_OBJPATH)/%.o)

all: debug release

debug: client_server_dbg client_dbg
release: client_server_rel client_rel

client_server: client_server_dbg client_server_rel
client: client_dbg client_rel

# Rules for rebuild when dependencies changed
# GCC option -MD enables dependency rules generation
-include $(FULL_SOURCES:%.c=$(DEBUG_CLIENT_SERVER_OBJPATH)/%.d)
-include $(FULL_SOURCES:%.c=$(RELEASE_CLIENT_SERVER_OBJPATH)/%.d)
-include $(CLIENT_SOURCES:%.c=$(DEBUG_CLIENT_OBJPATH)/%.d)
-include $(CLIENT_SOURCES:%.c=$(RELEASE_CLIENT_OBJPATH)/%.d)

# *.o build rules
$(DEBUG_CLIENT_SERVER_OBJPATH)/%.o: %.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(DEBUG_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(RELEASE_CLIENT_SERVER_OBJPATH)/%.o: %.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(RELEASE_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(DEBUG_CLIENT_OBJPATH)/%.o: %.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(DEBUG_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(RELEASE_CLIENT_OBJPATH)/%.o: %.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(RELEASE_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

# *.a build rules
$(DEBUG_CLIENT_SERVER_LIBRARY): $(DEBUG_CLIENT_SERVER_OBJECTS)
	$(dir_create)
	@${AR} -cr $@ $(DEBUG_CLIENT_SERVER_OBJECTS)
	@echo "AR	$@";

$(RELEASE_CLIENT_SERVER_LIBRARY): $(RELEASE_CLIENT_SERVER_OBJECTS)
	$(dir_create)
	@${AR} -cr $@ $(RELEASE_CLIENT_SERVER_OBJECTS)
	@echo "AR	$@";

$(DEBUG_CLIENT_LIBRARY): $(DEBUG_CLIENT_OBJECTS)
	$(dir_create)
	@${AR} -cr $@ $(DEBUG_CLIENT_OBJECTS)
	@echo "AR	$@";

$(RELEASE_CLIENT_LIBRARY): $(RELEASE_CLIENT_OBJECTS)
	$(dir_create)
	@${AR} -cr $@ $(RELEASE_CLIENT_OBJECTS)
	@echo "AR	$@";

# Rules for build all types of libs
client_server_dbg: $(DEBUG_CLIENT_SERVER_LIBRARY)
client_server_rel: $(RELEASE_CLIENT_SERVER_LIBRARY)
client_dbg: $(DEBUG_CLIENT_LIBRARY)
client_rel: $(RELEASE_CLIENT_LIBRARY)

# clean rules
clean_client_server_dbg:
	@rm -rf $(DEBUG_CLIENT_SERVER_OBJPATH)/*.d
	@echo "rm -rf $(DEBUG_CLIENT_SERVER_OBJPATH)/*.d";
	@rm -rf $(DEBUG_CLIENT_SERVER_OBJPATH)/*.o
	@echo "rm -rf $(DEBUG_CLIENT_SERVER_OBJPATH)/*.o";
	@rm -rf $(DEBUG_CLIENT_SERVER_LIBRARY)
	@echo "rm -rf $(DEBUG_CLIENT_SERVER_LIBRARY)";

clean_client_server_rel:
	@rm -rf $(RELEASE_CLIENT_SERVER_OBJPATH)/*.d
	@echo "rm -rf $(RELEASE_CLIENT_SERVER_OBJPATH)/*.d";
	@rm -rf $(RELEASE_CLIENT_SERVER_OBJPATH)/*.o
	@echo "rm -rf $(RELEASE_CLIENT_SERVER_OBJPATH)/*.o";
	@rm -rf $(RELEASE_CLIENT_SERVER_LIBRARY)
	@echo "rm -rf $(RELEASE_CLIENT_SERVER_LIBRARY)";

clean_client_dbg:
	@rm -rf $(DEBUG_CLIENT_OBJPATH)/*.d
	@echo "rm -rf $(DEBUG_CLIENT_OBJPATH)/*.d";
	@rm -rf $(DEBUG_CLIENT_OBJPATH)/*.o
	@echo "rm -rf $(DEBUG_CLIENT_OBJPATH)/*.o";
	@rm -rf $(DEBUG_CLIENT_LIBRARY)
	@echo "rm -rf $(DEBUG_CLIENT_LIBRARY)";

clean_client_rel:
	@rm -rf $(RELEASE_CLIENT_OBJPATH)/*.d
	@echo "rm -rf $(RELEASE_CLIENT_OBJPATH)/*.d";
	@rm -rf $(RELEASE_CLIENT_OBJPATH)/*.o
	@echo "rm -rf $(RELEASE_CLIENT_OBJPATH)/*.o";
	@rm -rf $(RELEASE_CLIENT_LIBRARY)
	@echo "rm -rf $(RELEASE_CLIENT_LIBRARY)";

clean_debug: clean_client_server_dbg clean_client_dbg
clean_release: clean_client_server_rel clean_client_rel

clean: clean_debug clean_release
