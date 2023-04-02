void setup(){
  fullScreen(); //canvas size
  background(255); //doesn't really have an effect, will be overwritten by image
}


void draw(){
}

void mousePressed(){
  saveFrame("drawing.png");
}
