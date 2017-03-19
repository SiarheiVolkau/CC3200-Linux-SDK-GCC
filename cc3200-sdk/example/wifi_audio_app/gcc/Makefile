#******************************************************************************
#
# Makefile - Rules for building the Wifi Audio App example
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

.PHONY: all clean

all: unicast multicast
clean: clean_unicast clean_multicast

debug: unicast_debug multicast_debug
release: unicast_release multicast_release
unicast: unicast_debug unicast_release
multicast: multicast_debug multicast_release

clean_debug: clean_unicast_debug clean_multicast_debug
clean_release: clean_unicast_release clean_multicast_release
clean_unicast: clean_unicast_debug clean_unicast_release
clean_multicast: clean_multicast_debug clean_multicast_release

unicast_debug:
	$(MAKE) -f Makefile_unicast debug
unicast_release:
	$(MAKE) -f Makefile_unicast release
multicast_debug:
	$(MAKE) -f Makefile_multicast debug
multicast_release:
	$(MAKE) -f Makefile_multicast release

clean_unicast_debug:
	$(MAKE) -f Makefile_unicast clean_debug
clean_unicast_release:
	$(MAKE) -f Makefile_unicast clean_release
clean_multicast_debug:
	$(MAKE) -f Makefile_multicast clean_debug
clean_multicast_release:
	$(MAKE) -f Makefile_multicast clean_release
