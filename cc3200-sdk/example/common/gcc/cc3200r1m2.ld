/*****************************************************************************
*
* cc3200r1m2.ld
*
* GCC Linker script for cc3200 chips with 256k SRAM.
*
*	v- 1.3.0
*
* The MIT License
*
* Copyright (c) 2017 Siarhei Volkau
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*
******************************************************************************/

/* Used by bootloader, can be used after load finished i.e. for heap */
BOOTLOADER_SIZE = 16K;

MEMORY
{
	SRAM (rwx) : ORIGIN = 0x20000000, LENGTH = 256K
}

SECTIONS
{
	.bootloader :
	{
		_heap2 = .;
		. = . + BOOTLOADER_SIZE;
		. = ALIGN(8);
		_eheap2 = .;
	} > SRAM

	.text :
	{
		_text = .;
		KEEP(*(.intvecs))
		*(.text*)
		*(.rodata*)
		*(.ARM.extab* .gnu.linkonce.armextab.*)
		. = ALIGN(8);
		_etext = .;
	} > SRAM

	.ARM : {
		__exidx_start = .;
		*(.ARM.exidx*)
		__exidx_end = .;
	} > SRAM

	__init_data = .;

	.data : AT(__init_data)
	{
		_data = .;
		*(.data*)
		. = ALIGN (8);
		_edata = .;
	} > SRAM

	.bss :
	{
		_bss = .;
		*(.bss*)
		*(COMMON)
		_ebss = .;
	} > SRAM

	.heap :
	{
		_heap = .;
		. = . +LENGTH(SRAM) - SIZEOF(.bss)
							- SIZEOF(.data)
							- SIZEOF(.ARM)
							- SIZEOF(.text)
							- SIZEOF(.bootloader)
							- 1024;
		. = ALIGN(1024);
		_eheap = .;
	} > SRAM
}

