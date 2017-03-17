#******************************************************************************
#
# compiler.cmake - Common rules for setup toolchain.
#                  See example/*/gcc/CMakeLists.txt for proper use.
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

set(CMAKE_SYSTEM_NAME Generic)

set(ARM_GCC_COMPILER "arm-none-eabi-gcc${CMAKE_EXECUTABLE_SUFFIX}")

# Find toolchain path

if (NOT DEFINED TOOLCHAIN_PATH)
  # Check if GCC is reachable.
  find_path(TOOLCHAIN_PATH bin/${ARM_GCC_COMPILER})

  if (NOT TOOLCHAIN_PATH)
    # Set default path.
    set(TOOLCHAIN_PATH "/usr/bin/gcc-arm-none-eabi")
    message(STATUS "GCC not found, default path will be used")
  endif ()
endif ()

# Specify target's environment
set(CMAKE_FIND_ROOT_PATH "${TOOLCHAIN_PATH}/arm-none-eabi/")

set(CMAKE_C_COMPILER   "${TOOLCHAIN_PATH}/bin/arm-none-eabi-gcc${CMAKE_EXECUTABLE_SUFFIX}")
set(CMAKE_CXX_COMPILER "${TOOLCHAIN_PATH}/bin/arm-none-eabi-g++${CMAKE_EXECUTABLE_SUFFIX}")
set(CMAKE_C_LINKER     "${TOOLCHAIN_PATH}/bin/arm-none-eabi-ld${CMAKE_EXECUTABLE_SUFFIX}")
set(CMAKE_CXX_LINKER   "${TOOLCHAIN_PATH}/bin/arm-none-eabi-ld${CMAKE_EXECUTABLE_SUFFIX}")
set(CMAKE_OBJCOPY
        "${TOOLCHAIN_PATH}/bin/arm-none-eabi-objcopy${CMAKE_EXECUTABLE_SUFFIX}"
        CACHE STRING "Objcopy" FORCE)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS)    # remove -rdynamic
set(CMAKE_EXE_LINK_DYNAMIC_C_FLAGS)       # remove -Wl,-Bdynamic

execute_process(COMMAND ${CMAKE_C_COMPILER} "-mthumb" "-mcpu=cortex-m4" "-print-file-name=libgcc.a" OUTPUT_VARIABLE LIBGCC_PATH)
string(STRIP "${LIBGCC_PATH}" LIBGCC_PATH)
execute_process(COMMAND ${CMAKE_C_COMPILER} "-mthumb" "-mcpu=cortex-m4" "-print-file-name=libnosys.a" OUTPUT_VARIABLE LIBNOSYS_PATH)
string(STRIP "${LIBNOSYS_PATH}" LIBNOSYS_PATH)
execute_process(COMMAND ${CMAKE_C_COMPILER} "-mthumb" "-mcpu=cortex-m4" "-print-file-name=libc_nano.a" OUTPUT_VARIABLE LIBC_NANO_PATH)
string(STRIP "${LIBC_NANO_PATH}" LIBC_NANO_PATH)
execute_process(COMMAND ${CMAKE_C_COMPILER} "-mthumb" "-mcpu=cortex-m4" "-print-file-name=libc.a" OUTPUT_VARIABLE LIBC_PATH)
string(STRIP "${LIBC_PATH}" LIBC_PATH)
execute_process(COMMAND ${CMAKE_C_COMPILER} "-mthumb" "-mcpu=cortex-m4" "-print-file-name=libm.a" OUTPUT_VARIABLE LIBM_PATH)
string(STRIP "${LIBM_PATH}" LIBM_PATH)

set(STDLIBS "'${LIBC_NANO_PATH}' '${LIBM_PATH}' '${LIBGCC_PATH}' '${LIBNOSYS_PATH}'")

set(CMAKE_C_LINK_EXECUTABLE "${CMAKE_C_LINKER} --gc-sections -o <TARGET> <OBJECTS> <LINK_LIBRARIES> ${STDLIBS}")
