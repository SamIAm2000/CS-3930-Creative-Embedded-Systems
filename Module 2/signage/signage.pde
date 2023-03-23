import processing.serial.*;
Serial myPort;

int x,y,b,s;  //raw input from serial. b for button, s for save picture to computer and clear screen
int px,py,pb,ps;
String portName;
String val;
int upperThreshold = 2500; //adjust depending on joystick
int lowerThreshold = 1500; //adjust depending on joystick
int[] currPosArr = {width/2, height/2, 0};
int speedFactor = 600; //should be between 0 - lowerThreshold, the higher the faster
//around 200-600 for optimal effects for this specific joystick
//PGraphics pg;
PImage img;
PShader blur;
PFont f;

void setup(){
  size (500, 500); //canvas size
  background(255); //doesn't really have an effect, will be overwritten by image
  myPort = new Serial(this, Serial.list()[2], 9600); //choose port
  myPort.bufferUntil('\n'); 
  f = createFont("Arial",16,true); //choose font here
  img = loadImage("drawing.png"); 
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
    500 and 200 are joystick specific values, the full range of this joystick is 0-4095 */
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
  
  //System.out.println("px=" +px+", py="+py+", pb="+pb);
  //fill(50);
  
  translate(0,0);
  textFont(f,100); //font variable and font size
  fill(0); 
  textAlign(CENTER, CENTER);//centers text to coordinate
  text("text",currPosArr[0],currPosArr[1]);//string, coordinates to display
  
  if (pb == 1){
    filter(INVERT);
    filter(BLUR);
    save("drawing.png");
    img = loadImage("drawing.png");
    image(img, 0, 0);
    
  }
  
  //blurs and saves the image
  if (ps == 1){
    filter(BLUR);
    save("drawing.png");
    img = loadImage("drawing.png");
    image(img, 0, 0);
  }
  
}

void serialEvent(Serial myPort) {
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
