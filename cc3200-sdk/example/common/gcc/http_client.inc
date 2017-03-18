#******************************************************************************
#
# httpclient.inc - Rules for building some example with http client library.
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

NETAPPS_PATH ?= $(SDK_ROOT)/netapps
HTTP_CLIENT_PATH = $(NETAPPS_PATH)/http/client

IPATH += -I$(NETAPPS_PATH)

ifeq (,$(findstring oslib,$(USE_LIBS)))
    DEBUG_LDLIBS+='$(HTTP_CLIENT_PATH)/gcc/lib/min/Debug/libwebclient.a'
    RELEASE_LDLIBS+='$(HTTP_CLIENT_PATH)/gcc/lib/min/Release/libwebclient.a'
    DEBUG_CFLAGS+=-DHTTPCli_LIBTYPE_MIN
    RELEASE_CFLAGS+=-DHTTPCli_LIBTYPE_MIN
else
    DEBUG_LDLIBS+='$(HTTP_CLIENT_PATH)/gcc/lib/full/Debug/libwebclient.a'
    RELEASE_LDLIBS+='$(HTTP_CLIENT_PATH)/gcc/lib/full/Release/libwebclient.a'
endif
