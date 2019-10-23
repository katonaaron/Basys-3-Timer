# Timer
Timer and stopwatch circuit.

## Configuration
* The `Timer.tcl` file was created in Vivado 2018.8. It might not work on any other versions.
* The project was created for Basys3. To use on any other Xilinx FPGA, you must change the project settings and create a new constraints file.

## Installation
In Vivado select `Tools -> Run Tcl Script...` and select `Timer.tcl`

## Usage
1. The FPGA is must be connected to a 5V power supply: either through the micro-USB port or through the external power supply pins.
1. The bitstream must be loaded to the FPGA.
1. The circuit must be initialized by turning on and off the RESET switch.
1. **Counting up**: Press the START/STOP button.
1. **Counting down**: Select the time with the M and S buttons, then press the START/STOP button
1. **Setting the length of the alarm, which is signaled when the countdown reaches 0:** Enter the chosen binary value by turning on or off any of the four ALARM\_LENGTH switches.
1. **Pause/Resume Counting:** Press the START/STOP button to pause, then press again to resume the counting to the same direction.
1. **Reset the timer:** Press M and S at the same time.
 #
