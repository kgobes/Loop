#include <Adafruit_NeoPixel.h>
#include <SPI.h>
#if not defined (_VARIANT_ARDUINO_DUE_X_) && not defined (_VARIANT_ARDUINO_ZERO_)
  #include <SoftwareSerial.h>
#endif
#ifdef __AVR__
  #include <avr/power.h>
#endif
#include "Adafruit_BLE.h"
#include "Adafruit_BluefruitLE_UART.h"
#include <String.h>

#define BLUEFRUIT_HWSERIAL_NAME      Serial1
#define BLUEFRUIT_UART_MODE_PIN        10    //we aren't using this because we aren't switching modes
#define BUFSIZE                        128   // Size of the read buffer for incoming data
#define VERBOSE_MODE                   true  // If set to 'true' enables debug output
#define NEO_PIXEL_PIN                   8    //On-board NeoPixel on Flora 2
#define PIN                     12
#define NUMPIXELS               6


Adafruit_BluefruitLE_UART ble(BLUEFRUIT_HWSERIAL_NAME, BLUEFRUIT_UART_MODE_PIN);
String currentColorValue = "FF-FF-FF";
Adafruit_NeoPixel onBoardPixel = Adafruit_NeoPixel(1, NEO_PIXEL_PIN, NEO_GRB + NEO_KHZ800);
//Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(6, 12, NEO_GRB + NEO_KHZ800);

int redVal = 255;
int greenVal = 255;
int blueVal = 255;
int delayval = 500;
// A small helper
void error(const __FlashStringHelper*err) {
  Serial.println(err);
  //Set Red LED
  redVal = 255;
  greenVal = 0;
  blueVal = 0;
  //setPixelColor();
  while (1);
}

void setup() {
  //remove these 2 lines if not debugging
  while (!Serial); // required for Flora & Micro
  delay(500);
#if defined (__AVR_ATtiny85__)
  if (F_CPU == 16000000) clock_prescale_set(clock_div_1);
#endif
  // End of trinket special code

  pixels.begin(); // This initializes the NeoPixel library.

  for(int i; i<6;i++)
      {
        Serial.println("in initial for loop");
        pixels.setPixelColor(i, pixels.Color(153,153,255));
        pixels.show();
        //delay(delayval);
      }
  Serial.begin(115200);
  Serial.println(F("Adafruit Flora BLE LED Example"));
  Serial.println(F("---------------------------------------------------"));

  randomSeed(micros()); //WHAT IS THIS

  if ( !ble.begin(VERBOSE_MODE) )
  {
    error(F("Couldn't find Bluefruit, make sure it's in CoMmanD mode & check wiring?"));
  }
  Serial.println( F("OK!") );

  /* Disable command echo from Bluefruit */
  ble.echo(false);

  Serial.println("Requesting Bluefruit info:");
  /* Print Bluefruit information */
  ble.info();

  // this line is particularly required for Flora, but is a good idea
  // anyways for the super long lines ahead!
  ble.setInterCharWriteDelay(5); // 5 ms
  Serial.println();
  
  //maybe set up for the strand in here?
  onBoardPixel.begin();
  setPixelColor();
  
}

void loop() {
  bool hasChanged = false;
 
  //check writable characteristic for a new color
  ble.println("AT+GATTCHAR=2");
  ble.readline();
  if (strcmp(ble.buffer, "OK") == 0) {
    // no data
    return;
  }
  // Some data was found, its in the buffer
  Serial.print(F("[Recv] ")); 
  //Serial.println(ble.buffer); //format FF-FF-FF R-G-B
  
  String buffer = String(ble.buffer);

//COMPARE buffer to options
  if(buffer == "1"){
    //green
    for(int i=0;i<6;i++){
    // pixels.Color takes RGB values, from 0,0,0 up to 255,255,255
    pixels.setPixelColor(i, pixels.Color(255,0,0)); // Moderately bright green color.
    pixels.show(); // This sends the updated pixel color to the hardware.
    delay(delayval); // Delay for a period of time (in milliseconds).
  }
    Serial.println("heeyeeyo I got a 1");
    //String buffer2 = "ffd700"; //yellow
    String buffer2 = "FF0000"; 
    String redBuff = buffer2.substring(0,2);
    String greenBuff = buffer2.substring(2,4);
    String blueBuff = buffer2.substring(4);
    Serial.println("Buffer 2 value: " + buffer2);
    Serial.println("red: " + redBuff);
    Serial.println("green: "+ greenBuff);
    Serial.println("blue: " + blueBuff);
    const char* red = redBuff.c_str();
    const char* green =  greenBuff.c_str();
    const char* blue = blueBuff.c_str();
    redVal = strtoul(red,NULL,16);
    greenVal = strtoul(green, NULL, 16);
    blueVal = strtoul(blue,NULL,16);
    setPixelColor();

    
  }
  //put option 2 code in here
  if(buffer == "2"){
     //green
    for(int i=0;i<6;i++){
    // pixels.Color takes RGB values, from 0,0,0 up to 255,255,255
    pixels.setPixelColor(i, pixels.Color(0,0,255)); // Moderately bright green color.
    pixels.show(); // This sends the updated pixel color to the hardware.
    delay(delayval); // Delay for a period of time (in milliseconds).
  }
      Serial.println("Flora received a 2");
      String buffer2 = "0000FF"; 
      String redBuff = buffer2.substring(0,2);
      String greenBuff = buffer2.substring(2,4);
      String blueBuff = buffer2.substring(4);
      Serial.println("Buffer 2 value: " + buffer2);
      Serial.println("red: " + redBuff);
      Serial.println("green: "+ greenBuff);
      Serial.println("blue: " + blueBuff);
      const char* red = redBuff.c_str();
      const char* green =  greenBuff.c_str();
      const char* blue = blueBuff.c_str();
      redVal = strtoul(red,NULL,16);
      greenVal = strtoul(green, NULL, 16);
      blueVal = strtoul(blue,NULL,16);
      setPixelColor();

     
  
  }

  
  //put option 3 code in here
  if(buffer == "3"){
    //colorWipe(pixels.Color(0, 0, 0), 20);
    for(int i; i<6;i++)
      {
        pixels.setPixelColor(i, pixels.Color(0,255,0));
        pixels.show();
        delay(delayval);
      }
      Serial.println("Flora received a 3");
      String buffer2 = "00FF00"; 
      String redBuff = buffer2.substring(0,2);
      String greenBuff = buffer2.substring(2,4);
      String blueBuff = buffer2.substring(4);
      Serial.println("Buffer 2 value: " + buffer2);
      Serial.println("red: " + redBuff);
      Serial.println("green: "+ greenBuff);
      Serial.println("blue: " + blueBuff);
      const char* red = redBuff.c_str();
      const char* green =  greenBuff.c_str();
      const char* blue = blueBuff.c_str();
      redVal = strtoul(red,NULL,16);
      greenVal = strtoul(green, NULL, 16);
      blueVal = strtoul(blue,NULL,16);
      setPixelColor();


      //green
  
  
  }
  
 /* ORIGINAL
  *  
  *  
  *  if(buffer!=currentColorValue){
    Serial.println("Changed color value");
    hasChanged = true;
    currentColorValue = buffer;
    String redBuff = buffer.substring(0,2);
    String greenBuff = buffer.substring(3,5);
    String blueBuff = buffer.substring(6); 
     Serial.println(redBuff +"\n");
     Serial.println(greenBuff+ "\n");
     Serial.println(blueBuff + "\n");
    const char* red = redBuff.c_str();
    const char* green =  greenBuff.c_str();
    const char* blue = blueBuff.c_str();
    redVal = strtoul(red,NULL,16);
    greenVal = strtoul(green, NULL, 16);
    blueVal = strtoul(blue,NULL,16);
    setPixelColor();
  }*/
  ble.waitForOK();
  
  if(hasChanged){
    Serial.println("Notify of color change");
    //write to notifiable characteristic
    String notifyCommand = "AT+GATTCHAR=1,"+ currentColorValue;
    ble.println( notifyCommand ); 
    if ( !ble.waitForOK() )
    {
      error(F("Failed to get response from notify property update"));
    }

    //write to readable characteristic for current color
    String readableCommand = "AT+GATTCHAR=3,"+ currentColorValue;
    ble.println(readableCommand);

    if ( !ble.waitForOK() )
    {
      error(F("Failed to get response from readable property update"));
    }
  }
  delay(1000);
}


void setPixelColor() {
  onBoardPixel.setPixelColor(0,onBoardPixel.Color(redVal, greenVal, blueVal));
  onBoardPixel.show();
}

void colorWipe(uint32_t c, uint8_t wait) {
  for(uint16_t i=0; i<6; i++) {
      pixels.setPixelColor(i, c);
      pixels.show();
      delay(wait);
  }
}
/*
void flashRandom(int wait, uint8_t howmany) {
 randomSeed(analogRead(0));
  for(uint16_t i=0; i<howmany; i++) {
    // get a random pixel from the list
    int j = random(6);
    
    // now we will 'fade' it in 5 steps
    for (int x=0; x < 5; x++) {
      int r = red * (x+1); r /= 5;
      int g = green * (x+1); g /= 5;
      int b = blue * (x+1); b /= 5;
      
      pixels.setPixelColor(j, pixels.Color(r, g, b));
      pixels.show();

    }
    // & fade out in 5 steps
    for (int x=5; x >= 0; x--) {
      int r = red * x; r /= 5;
      int g = green * x; g /= 5;
      int b = blue * x; b /= 5;
      
      pixels.setPixelColor(j, pixels.Color(r, g, b));
      pixels.show();
    
    }
  }
  // LEDs will be off when done (they are faded to 0)
}*/


