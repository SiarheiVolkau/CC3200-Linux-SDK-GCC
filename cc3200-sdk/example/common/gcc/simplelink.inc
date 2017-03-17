#******************************************************************************
#
# simplelink.inc - Rules for building some example with simplelink library.
#                  Included automatically by common.make
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

SL_PATH ?= $(SDK_ROOT)/simplelink

IPATH += -I$(SL_PATH) -I$(SL_PATH)/include
IPATH += -I$(SDK_ROOT)/simplelink_extlib/provisioninglib

ifeq (,$(findstring oslib,$(USE_LIBS)))
    DEBUG_LDLIBS+='$(SL_PATH)/gcc/lib/nonos/Debug/libsimplelink.a'
    RELEASE_LDLIBS+='$(SL_PATH)/gcc/lib/nonos/Release/libsimplelink.a'
else
    DEBUG_CFLAGS+=-DSL_PLATFORM_MULTI_THREADED
    RELEASE_CFLAGS+=-DSL_PLATFORM_MULTI_THREADED
    ifeq (,$(findstring middleware,$(USE_LIBS)))
        DEBUG_LDLIBS+='$(SL_PATH)/gcc/lib/os/Debug/libsimplelink.a'
        RELEASE_LDLIBS+='$(SL_PATH)/gcc/lib/os/Release/libsimplelink.a'
    else
        DEBUG_LDLIBS+='$(SL_PATH)/gcc/lib/os_PM/Debug/libsimplelink.a'
        RELEASE_LDLIBS+='$(SL_PATH)/gcc/lib/os_PM/Release/libsimplelink.a'
    endif
endif

DEBUG_CFLAGS+=-D__SL__
RELEASE_CFLAGS+=-D__SL__
