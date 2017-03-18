#*****************************************************************************
#
# Cmake build script for Provisioning AP example
#
# type following commands in console for build project
#   mkdir build && cd build
#   cmake -DCMAKE_BUILD_TYPE=<Debug|Release> ..
#   cmake --build .
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

cmake_minimum_required(VERSION 2.6)

set(CC3200_SDK_ROOT "../../..")
set(CC3200_EXAMPLE_COMMON_PATH "${CC3200_SDK_ROOT}/example/common")

set(CMAKE_TOOLCHAIN_FILE ${CC3200_EXAMPLE_COMMON_PATH}/gcc/compiler.cmake)

# name of the final binary files
set(TARGET_NAME "provisioning_ap")

project(${TARGET_NAME} C)

# define required variable for
# common part of build script
set(CC3200_USE_LIBS "driverlib simplelink provisioning")
set(NEWLIB "nano")

# use this for cc3200r1m1 devices
# set(CC3200_SRAM_SIZE "128K")


include(${CC3200_EXAMPLE_COMMON_PATH}/gcc/common.cmake)

set(CC3200_PROJECT_ROOT "..")

add_executable(${TARGET_NAME}
	${CC3200_PROJECT_ROOT}/main.c
	${CC3200_PROJECT_ROOT}/pinmux.c

	${CC3200_EXAMPLE_COMMON_PATH}/uart_if.c
	${CC3200_EXAMPLE_COMMON_PATH}/gpio_if.c
	${CC3200_EXAMPLE_COMMON_PATH}/timer_if.c
	${CC3200_EXAMPLE_COMMON_PATH}/startup_gcc.c
)

include_directories(${CC3200_EXAMPLE_COMMON_PATH})

set_target_properties(${TARGET_NAME} PROPERTIES PREFIX "" SUFFIX ".elf")

add_custom_command(OUTPUT ${TARGET_NAME}.tmp
                   COMMAND ${CMAKE_OBJCOPY} -O binary ${TARGET_NAME}.elf ${TARGET_NAME}.tmp
                   COMMAND ${CMAKE_COMMAND} -E copy ${TARGET_NAME}.tmp ${TARGET_NAME}.bin
                   COMMAND ${CMAKE_COMMAND} -E remove ${TARGET_NAME}.tmp
                   DEPENDS ${TARGET_NAME}
                   COMMENT "Making binary file ${TARGET_NAME}.bin")
add_custom_target(${TARGET_NAME}.bin ALL DEPENDS ${TARGET_NAME}.tmp)
get_directory_property(PROP_CLEAN_FILES ADDITIONAL_MAKE_CLEAN_FILES)
set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES "${PROP_CLEAN_FILES}${TARGET_NAME}.bin;${TARGET_NAME}.tmp;")
