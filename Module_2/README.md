# Signage
Interactive art created on an ESP-32. Link to blog post [here](https://samiam2000.github.io/MeMakey/general/2023/04/02/device-for-mark-making.html). Link to Youtube video demo [here](https://youtu.be/4LrRDydORug).

![concrete_front_view](/Module_2/Pictures/concrete_front_view.JPG)
Concrete enclosure

![concrete_other_side_view](/Module_2/Pictures/concrete_other_side_view.JPG)
Side view of concrete enclosure

## Code
My complete code for the ESP-32 and Processing can be found respcetively in the folders [arduinojoystick](https://github.com/SamIAm2000/CS-3930-Creative-Embedded-Systems/tree/main/Module_2/arduinojoystick) and [signage](https://github.com/SamIAm2000/CS-3930-Creative-Embedded-Systems/tree/main/Module_2/signage).

The Arduino code is the standard set-up code to wire up a joystick and button and send signals through serial communication. The .pde Processing code takes in the raw x,y values of the joystick and converts it to up, down, left, right. Pressing the button will trigger a function that saves the entire canvas while adding blur and random noise. Pressing the joystick's switch will also blur, add noise, and save the canvas but it will also invert the whole canvas' colors.

In the Arduino code, the x, y, z, pins for the joystick are defined up top at the beginning of the code, as is the button pin. These can be changed according to your specific set up. You can change the Baud rate, but remember that the same Baud rate should be used in both the .ino code as well as the Processing sketch otherwise there will be problems with the serial communication.

The Processing code mainly works by loading an image called "drawing.png" that's saved in the same folder as the Processing sketch every time the draw() function runs. When the user sets their mark and saves the image, the new image overwrites the previous "drawing.png" so there is no going back on mark-making; no room for reversals or erasing "mistakes."

Although replacing the canvas is discouraged, sometimes it is necessary to start from a blank slate. The folder [empty_canvas](https://github.com/SamIAm2000/CS-3930-Creative-Embedded-Systems/tree/main/Module_2/empty_canvas) contains a .pde file that will generate a blank white canvas named "drawing.png" in the same folder. You can copy this blank "drawing.png" to replace the one in the signage folder so that when you run the mark-making code, you will get a blank canvas. Make sure that the dimensions of the canvases are of the same size in both of the processing sketches. 

In the main Processing sketch, the one in the "signage" folder, you can change the font, text, font size etc., in the defined variables at the top of the page. You can also change "noiselev" to increase or decrease the noise (i.e. the number of randomly generated pixels everytime you make a mark) and change "blurfactor" to change how blurry you want the image to be. Remember that the blurs add up so a little goes a long way.

![concrete_set_up](/Module_2/Pictures/concrete_set_up.png)
Set up

![concrete_side_view](/Module_2/Pictures/concrete_side_view.JPG)
Another side view of concrete enclosure

## Setup
I chose to enclose the hardware (the ESP-32, the joystick, the button, and a breadboard) in a concrete enclosure. I cast the concrete one plane at a time out of molds made from cardboard boxes. The metal bars are for viewing, so that viewers can see a trace of the hardware that appears ensnared in the concrete. There is also a gap between the metal bars to push the hardware through. The concrete enclosure is purely for aesthetic reasons and is not necessary to run the code.

To set up the device, you only need to wire the button and joystick up to the ESP-32 using the breadboard and flash the Arduino code to the ESP-32. The code will allow the ESP-32 to send the numerical values of the joystick and button through serial communication to your computer. After connecting the ESP-32 to your computer with a USB-C cable, running the Processing code will be able to access the serial input and translate that to moving and setting marks on the canvas.

## Creative Vision
This project is about context and interpretation. When we look at a text or image, our interpretation of it depends upon many factors including the object itself, the historical context, the author, and finally, ourselves and where we stand. Whether any of these factors make a difference in our interpretation is an open question. Through my device for mark-making, I wish to invite the audience to make marks on a canvas and contemplate the position of their marks amongst the many created by those before them, just as the existence of everything we see is inseparable from its context and environment.

Through the joystick and button, users will move a short text phrase or character around on the canvas where they can press a button to set it down. Once the button is pressed, the mark is made on the canvas. The users can choose to make another mark, however, any marks that have been made cannot be deleted; it becomes part of the canvas for the next mark. Aside from setting down a mark, the machine also blurs and adds noise to the canvas whenever a mark is made, which means eventually, marks made earlier will be subject to many layers of blurring and become less visible and less distinct to signify the passage of time that blurs memory. 

Mark-making is an ongoing process. You can change the marks that you make, yet you can't change the marks others have made before you. History has happened and is immutable, yet the way we look at history can still change. 

![drawing1](/Module_2/Pictures/drawing1.png)
-"Burn" 4/2/2023
Full-screen drawing made by the Device

In this piece, I used two Chinese characters, "火" which means fire and "木" which means wood. In Chinese, when you combine multiples of the fire characters, you get a new word, e.g., "炎" with two of the fire characters means hot and "焱" with three means flames. A similar thing can happen with the wood character. By layering these characters upon each other and altering the font size and placement, I wanted to play with the shapes of the characters themselves and juxtapose their meanings. 

![drawing3](/Module_2/Pictures/drawing3.png)

500*500 pixels drawing

