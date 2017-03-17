#******************************************************************************
#
# middleware.inc - Rules for building some example with middleware library.
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

PM_PATH ?= $(SDK_ROOT)/middleware

IPATH += -I$(PM_PATH)/include
IPATH += -I$(PM_PATH)/driver
IPATH += -I$(PM_PATH)/driver/hal
IPATH += -I$(PM_PATH)/framework/pm
IPATH += -I$(PM_PATH)/framework/timer
IPATH += -I$(PM_PATH)/soc

DEBUG_LDLIBS+='$(PM_PATH)/gcc/lib/Debug/middleware.a'
RELEASE_LDLIBS+='$(PM_PATH)/gcc/lib/Release/middleware.a'
