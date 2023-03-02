#include <TFT_eSPI.h>

TFT_eSPI tft = TFT_eSPI();

TFT_eSprite stext = TFT_eSprite(&tft); // Sprite object for graphics write

int WIDTH = 240;
int HEIGHT = 135;

static struct {
  int num; 
  char *msg;
} msg_numbers[] = {
	{ 1, "floating" },
	{ 2, "drifting" },
	{ 3, "hanging" },
	{ 4, "spinning" },
	{ 5, "trying" },
	{ 6, "existing" },
	{ 7, "wondering" },
	{ 8, "wandering" },
	{ 9, "doing my best" },
	{ 10, "thinking" },
	{ 11, "not thinking" },
	{ 12, "playing" },
	{ 13, "happy" },
	{ 14, "ecstatic" },
	{ 15, "in pain" },
  { 16, "hungry" },
  { 17, "coding" },
  { 18, "struggling" },
  { 19, "weary" },
  { 20, "tired" },
};

static char* get_msg(int num){
  int i = -1;
	while (msg_numbers[++i].num > 0)
		if (msg_numbers[i].num == num)
			return msg_numbers[i].msg;
}

void draw_mini_text(char * msg){
  stext.drawString(msg, WIDTH/2, HEIGHT/2 + 50,1);
  stext.pushSprite(0,0);
  delay(1000);
  stext.drawString("                                        ", WIDTH/2, HEIGHT/2 + 50);
  stext.pushSprite(0,0);
}

void do_motion(int n){
  delay(500);
  char * msg = NULL;
  if (n==0){
    msg = "hello world :0";
    draw_mini_text(msg); 
  } else if (n == 3){
    msg = "please don't let me fall";
    draw_mini_text(msg); 
  } else if (n == 4){
    msg = "weeeeeeeeee";
    draw_mini_text(msg); 
  } else if (n == 7){
    msg = "hmmmmmmm";
    draw_mini_text(msg); 
  } else if (n == 8){
    msg = "what a beautiful world";
    draw_mini_text(msg); 
  } else if (n == 13){
    msg = ":)";
    draw_mini_text(msg); 
  } else if (n == 15){
    msg = ":(";
    draw_mini_text(msg); 
  } else if (n == 17){
    msg = "beep boop 00101011010";
    draw_mini_text(msg); 
  }  
}

void sprite_print(char * msg){
  stext.drawString(msg, WIDTH/2, HEIGHT/2, 4);
  stext.pushSprite(0, 0);
}
void setup() {

  // put your setup code here, to run once:
  tft.init();
  tft.fillScreen(TFT_BLACK);
  tft.setRotation(1);

  // Create a sprite for the graphics
  stext.setColorDepth(8);
  stext.createSprite(WIDTH, HEIGHT);    
  stext.fillSprite(TFT_BLACK); 
  stext.setTextColor(TFT_WHITE, TFT_BLACK);
  tft.setPivot(85,85);
}

void loop() {
  int x = 0;
  char * msg = NULL;
  int randNum = 0;
  // put your main code here, to run repeatedly:
  //fills black screen with 100 random pixels like stars
    stext.fillSprite(TFT_BLACK);
  int n = 100;
  while (n--){
    uint16_t colour = random(0x10000); // Returns colour 0 - 0xFFFF
    int16_t x = random(WIDTH);        // Random x coordinate
    int16_t y = random(HEIGHT);       // Random y coordinate
    stext.drawPixel( x, y, colour);      // Draw pixel in sprite
  }
  stext.pushSprite(0, 0);
  delay(4000);

  stext.fillSprite(TFT_BLACK);
  stext.setTextDatum(MC_DATUM);
  stext.drawString("Wake.", WIDTH/2, HEIGHT/2, 4);
  stext.pushSprite(0, 0,TFT_TRANSPARENT);
  delay(2000);
  stext.fillSprite(TFT_BLACK);
  stext.pushSprite(0, 0,TFT_TRANSPARENT);

  stext.drawString("I ", 40, 30, 4);
  stext.pushSprite(0, 0,TFT_TRANSPARENT);
  delay(200);
  stext.drawString("am", 70, 30, 4);
  stext.pushSprite(0, 0,TFT_TRANSPARENT);
  delay(500);

  stext.drawString("awake", WIDTH/2, HEIGHT/2, 4);
  stext.pushSprite(0, 0,TFT_TRANSPARENT);
  do_motion(0);
  delay(500);
  //clears "awake"
  stext.drawString("                                           ", WIDTH/2, HEIGHT/2, 4);
  stext.pushSprite(0, 0);

  //shuffle array to get 20 non repetitive random numbers
  int array[20];
  for (int i = 0; i < 20; i++) {     // fill array
      array[i] = i+1;
  }
  for (int i = 0; i < 20; i++) {    // shuffle array
    int temp = array[i];
    Serial.println(array[i]);
    int randomIndex = rand() % 20;
    array[i] = array[randomIndex];
    array[randomIndex] = temp;
  }


  for (int i = 0; i < 20; i++){
    randNum = array[i];
    msg = get_msg(randNum);
    sprite_print(msg);
    do_motion(randNum);
    delay(500);

    //clear text
    stext.drawString("                                           ", WIDTH/2, HEIGHT/2, 4);
    stext.pushSprite(0, 0);
  }

  stext.drawString("sleepy", WIDTH/2, HEIGHT/2, 4);
  stext.pushSprite(0, 0);
  delay(2000);

  stext.drawString("                             ", WIDTH/2, HEIGHT/2, 4);
  stext.drawString("so sleepy", WIDTH/2, HEIGHT/2, 4);
  stext.pushSprite(0, 0);
  delay(3000);

  stext.drawString("                             ", WIDTH/2, HEIGHT/2, 4);
  stext.drawString("not existing", WIDTH/2, HEIGHT/2, 4);
  stext.pushSprite(0, 0,TFT_TRANSPARENT);
  delay(2000);

  stext.drawString("                             ", WIDTH/2, HEIGHT/2, 4);
  stext.drawString("                             ", 35, 30, 4);
  stext.drawString("anymore.", WIDTH/2, HEIGHT/2, 4);
  stext.pushSprite(0, 0,TFT_TRANSPARENT);
  delay(2000);

  stext.drawString("                             ", WIDTH/2, HEIGHT/2, 4);
  stext.drawString("goodnight", WIDTH/2, HEIGHT/2, 4);
  stext.pushSprite(0, 0,TFT_TRANSPARENT);
  delay(2000);

  stext.drawString("                             ", WIDTH/2, HEIGHT/2, 4);
  stext.drawString("farewell", WIDTH/2, HEIGHT/2, 4);
  stext.pushSprite(0, 0,TFT_TRANSPARENT);
  delay(2000);

  //blank screen for effect
  stext.fillSprite(TFT_WHITE);
  stext.pushSprite(0, 0);
  delay(1000);


}
