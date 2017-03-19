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
           third_party/fatfs

SDK_EXAMPLES = adc \
               aes \
               antenna_selection \
               blinky \
               camera_application \
               connection_policy \
               crc \
               des \
               email \
               ent_wlan \
               file_download \
               file_operations \
               freertos_demo \
               get_time \
               getting_started_with_wlan_ap \
               get_weather \
               hib \
               http_client_demo \
               httpserver \
               i2c_demo \
               idle_profile \
               idle_profile_nonos \
               interrupt \
               mdns \
               mode_config \
               mqtt_client \
               mqtt_server \
               nwp_filter \
               ota_update/nonos \
               ota_update/os \
               out_of_box \
               p2p \
               power_measurement \
               provisioning_ap \
               provisioning_smartconfig \
               provisioning_wps \
               pwm \
               scan_policy \
               sdhost \
               sdhost_fatfs \
               sensor_profile \
               serial_wifi \
               shamd5 \
               sleep \
               spi_demo \
               ssl \
               tcp_socket \
               tftp_client \
               timer \
               timer_cc \
               transceiver_mode \
               uart_demo \
               uart_dma \
               udma \
               udp_socket \
               watchdog \
               watchdog_system_demo \
               websock_camera \
               wifi_audio_app \
               xmpp_client

.PHONY: all clean

all: libs examples

clean: clean_libs clean_examples

libs: $(SDK_LIBS:%=lib/%)

lib/%:
	@$(MAKE) -C "$*/gcc" all

clean_libs: $(SDK_LIBS:%=clean_lib/%)

clean_lib/%:
	@$(MAKE) -C "$*/gcc" clean

examples: $(SDK_EXAMPLES:%=build_example/%)

build_example/%:
	@$(MAKE) -C "example/$*/gcc" all

clean_examples: $(SDK_EXAMPLES:%=clean_example/%)

clean_example/%:
	@$(MAKE) -C "example/$*/gcc" clean

