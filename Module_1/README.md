# The Poem of Life
Generative art created on an ESP-32.
Link to blog post [here](https://samiam2000.github.io/MeMakey/general/2023/03/01/generative-art-the-poem-of-life.html).

Link to YouTube video [here](https://youtu.be/4seEMUTgprs).


![esps_in_the_dark](/Module_1/Pictures/esps_in_the_dark.jpeg)
ESPs in the dark

![i_am_struggling](/Module_1/Pictures/i_am_struggling.jpeg)
The one above that says "I am struggling" is mine.

## Creative Vision
I wanted to envision my ESP-32 as a living being that experienced emotions and random happenings in life. It would start up, experience things, rest, and then repeat again. The waking and sleeping of the machine also serves as a metaphor for life where we are born, get involved in a series of random, spontaneous happenings throughout our lives, and then we die.

The installation space would have other ESP-32s in the same space, so I thought that making my board imitate a living being would be a good way to interact with the other boards and invite viewers to regard these small specks that light up as individual lives flashing in front of them. Each board is merely a speck amongst the multitude, just as in the ending sequence of my program, there are stars to show that's where come from and what we'll eventually return to.

## Setup
Since our batteries were malfunctioning and we could not set up the ESP-32s independently without a battery, our professor very generously dedicated his time to building a board that could connect up to 15 ESP-32s to a power source. They are connected via USB-C connectors. It looks like this:

![empty_board](/Module_1/Pictures/empty_board.jpg)

## Technical Setup and Code
The Arduino code for the ESP-32 is in the file generative_art.ino

To replicate this project, first install the Arduino IDE.

To upload the code onto the ESP-32, you will have to install the TFT_eSPI library and add "https://dl.espressif.com/dl/package_esp32_index.json" to the board manager URLs under the Arduino IDE settings. You will also have to select the TTGO T1 board under Tools -> Boards -> ESP-32 -> TTGO T1. After the board has been installed, go to where you installed your Arduino libraries, (go Arduino -> libraries -> TFT_eSPI -> User_Setup_Select.h) and open User_Setup_Select.h in a text editor. Comment out the line that says "include <User_Setup.h>" and uncomment the line that says "//#include <User_Setups/Setup25_TTGO_T_Display.h>" and save. Your board should be all set up. For a more detailed walkthrough, see [here](https://youtu.be/adLUgmCJKnM).

The basic structure of the program is 
1. The Intro Sequence, where the program wakes up and comes into being from an infinitude of stars
2. The Main Sequence, where the program randomly flashes 20 different states of being, "I am ..."
3. The Ending Sequence, where the program falls back asleep and says farewell.

The random 20 States of Being are stored in a struct `msg_numbers` where each number corresponds to a state. See below:
![msg_numbers_struct](/Module_1/Pictures/msg_numbers_struct.png)

The randomly generated states of being come from an array that has the numbers 1-20 randomly shuffled using the random number generator. I chose to use an array instead of just randomly generated numbers form 1-20 so that there would be no repetition. See below:

![loops](/Module_1/Pictures/loops.png)

Some of the states also had subtext that came along with them such as `beep boop 00101011010` that would be returned whenever the screen displayed "I am coding." This I put into another function called do motion. I was originally going to include motions such as rotating the screen etc. that triggered when a certain number was called, but I did not end up implementing it. If one were to wish to do so, they could just alter the code in the do_motion function:

![do_motion](/Module_1/Pictures/do_motion.png)

## Further Notes to Consider
Orientation: the orientation of the board can be adjusted using the rotate function, but because of last minute changes in the plan (i.e. boards frying and batteries smoking), my board had to be displayed vertically. Use the function rotate(#) to rotate the board.
