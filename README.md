# Timer
Timer and stopwatch circuit.

## Description
The timer has 3 buttons: M (for minutes), S (for seconds) and START/STOP. It has four seven-segment displays that are configured to show two digits for minutes and two digits for seconds. Thus, the maximal value can be 99 minutes and 59 seconds.

The timer has two operating modes: it can count up or down. When the device is initialized using the RESET switch, zeros will be shown on the displays. If the START/STOP button is pressed, the timer will count up until 99 minutes and 59 seconds and then it will go to the initial state. 

If in any state the M button is pressed, the value of the minutes will be incremented, if in any state the S button is pressed, the value of the seconds will be incremented. If either M or S is pressed the new value will be constantly shown on the displays. In this state if the START/STOP button is pressed, the timer will count down. When the value is decremented to zero, an alarm signal will be activated for a period that is equal with the ALARM_LENGTH 4-bit input signal, which is connected to four switches.

If the timer is counting and the START/STOP button is pressed, the timer will stop counting and will preserve its value of minutes and seconds indefinitely. If the START/STOP button is pressed again, the timer continues to count to the same direction.

If M and S are pressed at the same time the counter resets itself to the initial state.


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

## Acknowledgements
* [vivado-git](https://github.com/barbedo/vivado-git)
