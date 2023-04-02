import processing.serial.*;
Serial myPort;

//raw input from serial. b for button, s for save picture to computer and clear screen
//b is the joystick's button, s is the other button
int x,y,b,s;  
int px,py,pb,ps;
String portName;
String val;
int[] currPosArr = {width/2, height/2, 0};
PImage img;
PShader blur;
PFont f;

//THE FOLLOWING ARE THINGS YOU SHOULD CHANGE ACCORDING TO YOUR PREFERENCES:

//JOYSTICK STUFF:
/*
  the raw values of the joystick I'm using: the x is around 1905 and y is around 1831
  when the joystick is in the neutral position
  The joystick I'm using has values ranging from 0-4905
*/
int upperThreshold = 2500; //adjust depending on joystick x
int lowerThreshold = 1500; //adjust depending on joystick y

//this should be between 0 - lowerThreshold, the higher the faster
//around 200-600 for optimal effects for this specific joystick I'm using
int speedFactor = 600; 

//IMAGE STUFF:
int noiselev = 50; //how much noise would you like, so basically how many randomized pixels
float blurfactor = 1; //how much blur would you like
String stringtoprint = "火"; // what text you would like to print
int fontsize = 200; //fontsize
int fontfill = 0; //grayscale, 0 for black, 255 for white

// THERE'S MORE THINGS TO CHANGE UNDER SETUP:
void setup(){
  //size (500, 500); //canvas size
  fullScreen();
  background(255); //doesn't really have an effect, will be overwritten by image
  
  //choose port, the port where the ESP32 is connected. 
  //The baud rate should be set to the same as the one in the arduino .ino file
  myPort = new Serial(this, Serial.list()[2], 115200); 
  myPort.bufferUntil('\n'); 
  f = createFont("Arial",fontsize,true); //choose font here, font name, fontsize, yes/no for antialiasing
  img = loadImage("drawing.png"); //what the image in the sketch folder is named
}


void draw(){ 
  image(img, 0, 0);
  //0-4095 is the joystick range
  //we need to map that to up down left or right
  px = 0;
  py = 0;
  pb = 0;
  ps = 0;
  
  /*load new values for positions px, py, pb, ps from serial
    adjust for signal bounce
    500 and 200 are joystick specific values, the full range of this joystick is 0-4095 
  */
  if (x>upperThreshold){px = (x-500)/speedFactor;} 
  else if (x<lowerThreshold){px = (x-2000)/speedFactor;}
  if (y>upperThreshold){py = (y-500)/speedFactor;}
  else if (y<lowerThreshold){py = (y-2000)/speedFactor;};
  pb = b;
  ps = s;
  
  //updates current absolute position of the text
  currPosArr[0]+=px;
  currPosArr[1]+=py;
  
  //make sure the object doesn't go out of bounds too much
  if (currPosArr[0] < 0){
    currPosArr[0] = 0;
  }else if (currPosArr[0] > width){
    currPosArr[0] = width;
  }
  if (currPosArr[1] < 0){
    currPosArr[1] = 0;
  }else if (currPosArr[1] > height){
    currPosArr[1] = height;
  }
  
  //Draws font here
  translate(0,0);
  textFont(f); //font variable and font size
  fill(fontfill); 
  textAlign(CENTER, CENTER);//centers text to coordinate
  text(stringtoprint,currPosArr[0],currPosArr[1]);//string, coordinates to display
  
  //inverts, blurs, adds noise, and then saves image
  if (pb == 1){
    pb = 0;
    filter(INVERT);
    filter(BLUR, blurfactor);
    addNoise(img, noiselev);
    saveFrame("drawing.png");
    img = loadImage("drawing.png");
    image(img, 0, 0);
    
    /*this delay is very important, otherwise it will repeat too many times since 
      draw() runs 60 times/sec and serial and draw run at different speeds */
    delay(50); 
  }
  
  //blurs, adds noise, and saves the image
  if (ps == 1){
    ps = 0;
    filter(BLUR, blurfactor);
    addNoise(img, noiselev);
    saveFrame("drawing.png");
    img = loadImage("drawing.png");
    image(img, 0, 0);
    delay(50);
  }
}


void addNoise(PImage img, int n){
  img.loadPixels();
  while (n > 0) {
    //img.loadPixels():
    //int pos = int(random(width*height));
    //img.pixels[pos]= color(0);
    //img.updatPixels();
    
    int pixelx = int(random(width));
    int pixely = int(random(height));
    point(pixelx,pixely);
    n--;
  }
  img.updatePixels();
}

void serialEvent(Serial myPort) {
  /* try and catch because serial has issues when you first run the sketch,
    you might be entering the serial stream at a bad time so the information 
    sent isn't a complete packet */
  try{
    val = myPort.readStringUntil('\n');
    if (val != null){
      val = trim(val);
      int[] vals = int(splitTokens(val, ","));
      x = vals[0];
      y = vals[1];
      b = vals[2];
      s = vals[3];
      System.out.println("x=" +x+", y="+y+", b="+b + ", s="+s);
    }
  }
  catch(RuntimeException e) {
    e.printStackTrace();
  }
}
