#******************************************************************************
#
# provisioning.inc - Rules for building some example with Provisioning library.
#                    Included automatically by common.make
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

SL_EXTLIB_PATH ?= $(SDK_ROOT)/simplelink_extlib
PROVISIONING_LIB_PATH ?= $(SL_EXTLIB_PATH)/provisioninglib

IPATH += -I$(SL_EXTLIB_PATH)/include
IPATH += -I$(PROVISIONING_LIB_PATH)

DEBUG_LDLIBS+='$(PROVISIONING_LIB_PATH)/gcc/lib/Debug/provisioninglib.a'
RELEASE_LDLIBS+='$(PROVISIONING_LIB_PATH)/gcc/lib/Release/provisioninglib.a'
