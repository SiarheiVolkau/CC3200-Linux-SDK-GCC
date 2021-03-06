#******************************************************************************
#
# oslib.inc - Rules for building some example with oslib (FreeRTOS).
#             Included automatically by common.make
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

OSLIB_PATH ?= $(SDK_ROOT)/oslib

IPATH += -I$(SDK_ROOT)/oslib
IPATH += -I$(SDK_ROOT)/third_party/FreeRTOS/source
IPATH += -I$(SDK_ROOT)/third_party/FreeRTOS/source/include
IPATH += -I$(SDK_ROOT)/third_party/FreeRTOS/source/portable/GCC/ARM_CM4

DEBUG_LDLIBS+='$(OSLIB_PATH)/gcc/free_rtos/Debug/free_rtos.a'
RELEASE_LDLIBS+='$(OSLIB_PATH)/gcc/free_rtos/Release/free_rtos.a'

DEBUG_CFLAGS+=-DUSE_FREERTOS
RELEASE_CFLAGS+=-DUSE_FREERTOS
