=====================================================================================================
                         GDB Support for CC3200 Device
=====================================================================================================

- Debugging with GDB available by using OpenOCD in background.

- OpenOCD version 0.9 and above have cc3200 target, for older use file cc3200.cfg in this folder.
  Place this file to OpenOCD's targets directory, or modify gdbinit script appopriately.

- CC3200 Launchpad has integrated FTDI emulator and provided gdbinit file uses this interface.
  Read the gdbinit file and OpenOCD manual for custom emulator usage.

- To run example application, goto this folder in command prompt and run following command
  'arm-none-eabi-gdb -x gdbinit <app.elf>'
