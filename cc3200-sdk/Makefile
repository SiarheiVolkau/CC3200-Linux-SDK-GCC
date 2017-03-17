#******************************************************************************
#
# Makefile - Top level makefile for build SDK and examples.
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

SDK_LIBS = driverlib           \
           oslib               \
           middleware          \
           simplelink          \
           simplelink_extlib/flc \
           simplelink_extlib/ota \
           simplelink_extlib/provisioninglib \
           netapps/http/client \
           netapps/http/server \
           netapps/json        \
           netapps/mqtt        \
           netapps/smtp/client \
           netapps/tftp/client \
           netapps/xmpp/client \

#SDK_EXAMPLES = adc                \
#               aes                \
#               antenna_selection  \
#               blinky             \
#               camera_application \
#               connection_policy  \
#               crc                \
#               des                \
#               file_download      \
#               freertos_demo      \
#               get_time           \
#               idle_profile       \


.PHONY: all clean

all: libs
#examples

clean: clean_libs
#clean_examples

libs: $(SDK_LIBS:%=lib/%)

lib/%: %/gcc/Makefile
	@$(MAKE) -C "$(dir $<)" all

clean_libs: $(SDK_LIBS:%=clean_lib/%)

clean_lib/%: %/gcc/Makefile
	@$(MAKE) -C "$(dir $<)" clean

examples: #TODO
