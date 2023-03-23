int xyzPins[] = {12,13, 15};   //x,y,z pins
const int buttonPin = 2;  // the number of the pushbutton pin

void setup()	{	
	Serial.begin(9600) ;
	// pinMode(8,INPUT); 
	// digitalWrite(8,HIGH);	
  // initialize the pushbutton pin as an input:
  pinMode(buttonPin, INPUT_PULLUP);
  pinMode(xyzPins[2], INPUT_PULLUP);
}	

void loop()	{	
	int xVal = analogRead(xyzPins[0]);	
	int yVal = analogRead(xyzPins[1]);	
	int zVal = digitalRead(xyzPins[2]);	
  int buttonState = digitalRead(buttonPin);
	Serial.print(xVal,DEC);
	Serial.print(",");
	Serial.print(yVal,DEC);
	Serial.print(",");
	Serial.print(!zVal);
  Serial.print(",");
  Serial.print(buttonState);
	Serial.print("\n");
	delay(100);	
}