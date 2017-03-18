#******************************************************************************
#
# common.cmake - Common cmake settings for SDK based project.
#                See example/*/gcc/CMakeLists.txt for proper use.
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

#
# use specific compiler flags
#
set(CPU_FLAGS "-mthumb -mcpu=cortex-m4")
set(CMAKE_C_FLAGS "${CPU_FLAGS} -ffunction-sections -fdata-sections -g -Wall -Dgcc")
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS} -O0" CACHE STRING "Debug compiler flags" FORCE)
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS} -Os -DTARGET_IS_CC3200" CACHE STRING "Release compiler flags" FORCE)
set(CMAKE_C_FLAGS_RELWITHDEBINFO "${CMAKE_C_FLAGS} -Os -DTARGET_IS_CC3200")
set(CMAKE_C_FLAGS_MINSIZEREL "${CMAKE_C_FLAGS} -Os -DTARGET_IS_CC3200")

#
# Find CC32XX SDK
#
if (NOT DEFINED CC3200_SDK_ROOT)
  message(ERROR "SDK location is not defined (CC3200_SDK_ROOT)")
else ()
# absolutize SDK root path
  get_filename_component(CC3200_SDK_ROOT "${CC3200_SDK_ROOT}" ABSOLUTE)
endif ()

message(STATUS "CC32XX SDK path: ${CC3200_SDK_ROOT}")
message(STATUS "Toolchain path: ${TOOLCHAIN_PATH}")
include_directories(${CC3200_SDK_ROOT}/inc)

if(CMAKE_BUILD_TYPE MATCHES Debug)
	set(CC3200_LIB_TYPE "Debug")
else ()
	set(CC3200_LIB_TYPE "Release")
endif ()

#
# append dependent libs
#
if (CC3200_USE_LIBS MATCHES "middleware")
	set(CC3200_USE_LIBS "${CC3200_USE_LIBS} driverlib")
endif()

if (CC3200_USE_LIBS MATCHES "smtp_client")
	set(CC3200_USE_LIBS "${CC3200_USE_LIBS} simplelink")
endif()

if (CC3200_USE_LIBS MATCHES "http_client")
	set(CC3200_USE_LIBS "${CC3200_USE_LIBS} simplelink")
endif()

if (CC3200_USE_LIBS MATCHES "mqtt_client")
	set(CC3200_USE_LIBS "${CC3200_USE_LIBS} simplelink")
endif()

if (CC3200_USE_LIBS MATCHES "mqtt_server")
	set(CC3200_USE_LIBS "${CC3200_USE_LIBS} simplelink")
endif()

if (CC3200_USE_LIBS MATCHES "ota")
	set(CC3200_USE_LIBS "${CC3200_USE_LIBS} flc")
endif()

if (CC3200_USE_LIBS MATCHES "flc")
	set(CC3200_USE_LIBS "${CC3200_USE_LIBS} simplelink")
elseif (CC3200_USE_LIBS MATCHES "flc_fastboot")
	set(CC3200_USE_LIBS "${CC3200_USE_LIBS} simplelink")
endif()

#
# include requested libs
#
if (CC3200_USE_LIBS MATCHES "driverlib")
	message(STATUS "Using driverlib library.")
	set(LINK_LIBS "'${CC3200_SDK_ROOT}/driverlib/gcc/lib/${CC3200_LIB_TYPE}/libdriver.a' ${LINK_LIBS}")
	include_directories(${CC3200_SDK_ROOT}/driverlib)
endif()

if (CC3200_USE_LIBS MATCHES "middleware")
	message(STATUS "Using middleware library.")
	include_directories(
		${CC3200_SDK_ROOT}/middleware/driver/
		${CC3200_SDK_ROOT}/middleware/driver/hal/
		${CC3200_SDK_ROOT}/middleware/framework/pm/
		${CC3200_SDK_ROOT}/middleware/framework/timer/
		${CC3200_SDK_ROOT}/middleware/soc/
	)
	set(LINK_LIBS "'${CC3200_SDK_ROOT}/middleware/gcc/lib/${CC3200_LIB_TYPE}/middleware.a' ${LINK_LIBS}")
endif()

if (CC3200_USE_LIBS MATCHES "oslib")
	message(STATUS "Using oslib (FreeRTOS based) library.")
	include_directories(${CC3200_SDK_ROOT}/oslib)
	add_definitions(-DUSE_FREERTOS)
	set(LINK_LIBS "'${CC3200_SDK_ROOT}/oslib/gcc/free_rtos/${CC3200_LIB_TYPE}/free_rtos.a' ${LINK_LIBS}")
endif()

if (CC3200_USE_LIBS MATCHES "simplelink")
	message(STATUS "Using simplelink library.")
	include_directories(
		${CC3200_SDK_ROOT}/simplelink
		${CC3200_SDK_ROOT}/simplelink/include
		${CC3200_SDK_ROOT}/simplelink_extlib/provisioninglib
	)
	add_definitions(-D__SL__)
	if (CC3200_USE_LIBS MATCHES "oslib")
		add_definitions(-DSL_PLATFORM_MULTI_THREADED)
		if (CC3200_USE_LIBS MATCHES "middleware")
			set(LINK_LIBS "'${CC3200_SDK_ROOT}/simplelink/gcc/lib/os_PM/${CC3200_LIB_TYPE}/libsimplelink.a' ${LINK_LIBS}")
		else ()
			set(LINK_LIBS "'${CC3200_SDK_ROOT}/simplelink/gcc/lib/os/${CC3200_LIB_TYPE}/libsimplelink.a' ${LINK_LIBS}")
		endif ()
	else()
		set(LINK_LIBS "'${CC3200_SDK_ROOT}/simplelink/gcc/lib/nonos/${CC3200_LIB_TYPE}/libsimplelink.a' ${LINK_LIBS}")
	endif()
endif()

if (CC3200_USE_LIBS MATCHES "json")
	message(STATUS "Using JSON library.")
	set(LINK_LIBS "'${CC3200_SDK_ROOT}/netapps/json/gcc/lib/${CC3200_LIB_TYPE}/libjson.a' ${LINK_LIBS}")
	include_directories(${CC3200_SDK_ROOT}/netapps/json)
endif()

if (CC3200_USE_LIBS MATCHES "smtp_client")
	message(STATUS "Using SMTP client library.")
	set(LINK_LIBS "'${CC3200_SDK_ROOT}/netapps/smtp/client/gcc/lib/${CC3200_LIB_TYPE}/libemail.a' ${LINK_LIBS}")
	include_directories(${CC3200_SDK_ROOT}/netapps/smtp/client)
endif()

if (CC3200_USE_LIBS MATCHES "http_client")
	message(STATUS "Using HTTP client library.")
	include_directories(${CC3200_SDK_ROOT}/netapps)
	if (CC3200_USE_LIBS MATCHES "oslib")
		set(LINK_LIBS "'${CC3200_SDK_ROOT}/netapps/http/client/gcc/lib/full/${CC3200_LIB_TYPE}/libwebclient.a' ${LINK_LIBS}")
	else()
		add_definitions(-DHTTPCli_LIBTYPE_MIN)
		set(LINK_LIBS "'${CC3200_SDK_ROOT}/netapps/http/client/gcc/lib/min/${CC3200_LIB_TYPE}/libwebclient.a' ${LINK_LIBS}")
	endif()
endif()

if (CC3200_USE_LIBS MATCHES "mqtt_server")
	message(STATUS "Using MQTT client-server library.")
	set(LINK_LIBS "'${CC3200_SDK_ROOT}/netapps/mqtt/gcc/lib/client_server/${CC3200_LIB_TYPE}/libmqtt.a' ${LINK_LIBS}")
	include_directories(${CC3200_SDK_ROOT}/netapps/mqtt/include)
	include_directories(${CC3200_SDK_ROOT}/netapps/mqtt/common)
	include_directories(${CC3200_SDK_ROOT}/netapps/mqtt/platform)
elseif (CC3200_USE_LIBS MATCHES "mqtt_client")
	message(STATUS "Using MQTT client library.")
	set(LINK_LIBS "'${CC3200_SDK_ROOT}/netapps/mqtt/gcc/lib/client/${CC3200_LIB_TYPE}/libmqtt.a' ${LINK_LIBS}")
	include_directories(${CC3200_SDK_ROOT}/netapps/mqtt/include)
	include_directories(${CC3200_SDK_ROOT}/netapps/mqtt/common)
	include_directories(${CC3200_SDK_ROOT}/netapps/mqtt/platform)
endif()

if (CC3200_USE_LIBS MATCHES "flc_fastboot")
	message(STATUS "Using FLC (fastboot) library.")
	set(LINK_LIBS "'${CC3200_SDK_ROOT}/simplelink_extlib/flc/gcc/lib/fastboot/${CC3200_LIB_TYPE}/flc.a' ${LINK_LIBS}")
	include_directories(${CC3200_SDK_ROOT}/simplelink_extlib/flc)
	include_directories(${CC3200_SDK_ROOT}/simplelink_extlib/include)
elseif (CC3200_USE_LIBS MATCHES "flc")
	message(STATUS "Using FLC library.")
	set(LINK_LIBS "'${CC3200_SDK_ROOT}/simplelink_extlib/flc/gcc/lib/${CC3200_LIB_TYPE}/flc.a' ${LINK_LIBS}")
	include_directories(${CC3200_SDK_ROOT}/simplelink_extlib/flc)
	include_directories(${CC3200_SDK_ROOT}/simplelink_extlib/include)
endif()

if (CC3200_USE_LIBS MATCHES "ota")
	message(STATUS "Using OTA library.")
	set(LINK_LIBS "'${CC3200_SDK_ROOT}/simplelink_extlib/ota/gcc/lib/${CC3200_LIB_TYPE}/ota.a' ${LINK_LIBS}")
	# line above should be included by flc library
	# include_directories(${CC3200_SDK_ROOT}/simplelink_extlib/include)
endif()

set(CC3200_SDK_ROOT "${CC3200_SDK_ROOT}" CACHE STRING "SDK location" FORCE)

#
# use newlib or newlib-nano
# default is newlib-nano (declared in compiler.cmake)
#
if (NEWLIB STREQUAL full)
	set(STDLIBS "'${LIBM_PATH}' '${LIBC_PATH}' '${LIBGCC_PATH}'")
else()
	set(NEWLIB nano)
endif ()

set(NEWLIB "${NEWLIB}" CACHE STRING "Newlib variant: nano or full (default)." FORCE)

#
# use specific linker script
# default is the script for 256K devices
#
if (NOT DEFINED LINKER_SCRIPT)
	if (CC3200_SRAM_SIZE STREQUAL 128K)
		set(LINKER_SCRIPT "${CC3200_SDK_ROOT}/example/common/gcc/cc3200r1m1.ld")
	else ()
		set(CC3200_SRAM_SIZE 256K)
		set(LINKER_SCRIPT "${CC3200_SDK_ROOT}/example/common/gcc/cc3200r1m2.ld")
	endif ()
endif ()

set(CC3200_SRAM_SIZE "${CC3200_SRAM_SIZE}" CACHE STRING "SRAM size on target: 128K or 256K (default)." FORCE)

#
# linker commandline
#
set(CMAKE_C_LINK_EXECUTABLE
        "${CMAKE_C_LINKER} -T${LINKER_SCRIPT} -Map <TARGET>.map --entry ResetISR --gc-sections -o <TARGET> <OBJECTS> <LINK_LIBRARIES> ${LINK_LIBS} ${STDLIBS}")

