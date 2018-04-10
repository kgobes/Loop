#include <Arduino.h>
#include <Adafruit_NeoPixel.h>
#include <SPI.h>
#if not defined (_VARIANT_ARDUINO_DUE_X_) && not defined (_VARIANT_ARDUINO_ZERO_)
  #include <SoftwareSerial.h>
#endif
#ifdef __AVR__
  #include <avr/power.h>
#endif
#include "Adafruit_BLE.h"
#include "Adafruit_BluefruitLE_SPI.h"
#include "Adafruit_BluefruitLE_UART.h"
#include "BluefruitConfig.h"
#include <String.h>

#define BLUEFRUIT_HWSERIAL_NAME      Serial1
#define BLUEFRUIT_UART_MODE_PIN        10    //we aren't using this because we aren't switching modes
#define BLUEFRUIT_SPI_RST               4
#define BUFSIZE                        128   // Size of the read buffer for incoming data
#define VERBOSE_MODE                   true  // If set to 'true' enables debug output
#define NEO_PIXEL_PIN                   8    //On-board NeoPixel on Flora 2
#define PIN                     6
#define NUMPIXELS               4

#include "BluefruitConfig.h"
//Adafruit_BluefruitLE_UART ble(BLUEFRUIT_HWSERIAL_NAME, BLUEFRUIT_UART_MODE_PIN);
Adafruit_BluefruitLE_SPI ble(BLUEFRUIT_SPI_CS, BLUEFRUIT_SPI_IRQ, BLUEFRUIT_SPI_RST);
String currentColorValue = "FF-FF-FF";
//Adafruit_NeoPixel Pixel = Adafruit_NeoPixel(1, NEO_PIXEL_PIN, NEO_GRB + NEO_KHZ800);

Adafruit_NeoPixel pixels = Adafruit_NeoPixel(60, PIN, NEO_GRB + NEO_KHZ800);

int motorPin = 12; //vibrating motor

int redVal = 255;
int greenVal = 255;
int blueVal = 255;

int redValFlash = 0;
int greenValFlash = 0;
int blueValFlash = 0;

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
  //while (!Serial); // required for Flora & Micro
  delay(500);
#if defined (__AVR_ATtiny85__)
  if (F_CPU == 16000000) clock_prescale_set(clock_div_1);
#endif
  // End of trinket special code

  pixels.begin(); // This initializes the NeoPixel library.
  pinMode(motorPin, OUTPUT); 
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
 // ble.setInterCharWriteDelay(5); // 5 ms
 
  Serial.println();
  //setPixelColor();
  //rainbowCycle(20);
  /*for(int i; i<6;i++)
      {
        pixels.setPixelColor(i, pixels.Color(0,255,0));
        pixels.setBrightness(50);
        pixels.show();
        delay(delayval);
      }*/
  
}Z

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
  Serial.println(ble.buffer); //format FF-FF-FF R-G-B
  
  String buffer = String(ble.buffer);
  Serial.print("buffer as string: ");
  Serial.println(buffer);

//COMPARE buffer to options
  if(buffer == "A0-FF-00"){
   // hasChanged = true;
    for(int i=0;i<6;i++){
    // pixels.Color takes RGB values, from 0,0,0 up to 255,255,255
    pixels.setPixelColor(i, pixels.Color(255,0,0)); // Moderately bright green color.
    pixels.setBrightness(50);
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
  if(buffer == "4C-FF-00"){
   // hasChanged = true;
     //green
    for(int i=0;i<6;i++){
    // pixels.Color takes RGB values, from 0,0,0 up to 255,255,255
    pixels.setPixelColor(i, pixels.Color(0,0,255)); // Moderately bright green color.
    pixels.setBrightness(50);
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
  if(buffer == "0B-FF-00"){
    //hasChanged = true;
    //colorWipe(pixels.Color(0, 0, 0), 20);
    for(int i; i<6;i++)
      {
        pixels.setPixelColor(i, pixels.Color(0,255,0));
        pixels.setBrightness(50);
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
  if(buffer == "07-FF-00"){ //rainbow code
    //hasChanged = true;
   rainbowCycle(20);
  }
  
 if(buffer == "4"){
   // hasChanged = true;
    Serial.println("trinket detected");
    for(int i; i<6;i++)
      {
        pixels.setPixelColor(i, pixels.Color(0,255,0));
        pixels.setBrightness(50);
        pixels.show();
        delay(delayval);
      }
      Serial.println("Flora should flash new color");
      String buffer2 = "800080"; 
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
      redValFlash = strtoul(red,NULL,16);
      greenValFlash = strtoul(green, NULL, 16);
      blueValFlash = strtoul(blue,NULL,16);
      //setPixelColorFlash();
  }
  
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
//  Pixel.setPixelColor(0,Pixel.Color(redVal, greenVal, blueVal));
  //Pixel.show();
}
void rainbowCycle(uint8_t wait) {
  uint16_t i, j;

  for(j=0; j<256*5; j++) { // 5 cycles of all colors on wheel
    for(i=0; i< pixels.numPixels(); i++) {
      pixels.setPixelColor(i, Wheel(((i * 256 / pixels.numPixels()) + j) & 255));
      pixels.setBrightness(50);
    }
    pixels.show();
    delay(wait);
  }
}
uint32_t Wheel(byte WheelPos) {
  WheelPos = 255 - WheelPos;
  if(WheelPos < 85) {
    return pixels.Color(255 - WheelPos * 3, 0, WheelPos * 3);
  }
  if(WheelPos < 170) {
    WheelPos -= 85;
    return pixels.Color(0, WheelPos * 3, 255 - WheelPos * 3);
  }
  WheelPos -= 170;
  return pixels.Color(WheelPos * 3, 255 - WheelPos * 3, 0);
}
/*
void setPixelColorFlash(){ //flash new color twice, going back to original color values
 // Pixel.setPixelColor(0,Pixel.Color(redValFlash, greenValFlash, blueValFlash));
  Pixel.show();
  delay(1000);
  Pixel.setPixelColor(0,Pixel.Color(redVal, greenVal, blueVal));
  Pixel.show();
  delay(1000);
  Pixel.setPixelColor(0,Pixel.Color(redValFlash, greenValFlash, blueValFlash));
  Pixel.show();
  delay(1000);
  Pixel.setPixelColor(0,Pixel.Color(redVal, greenVal, blueVal));
  Pixel.show();
  Pixel.setPixelColor(0,Pixel.Color(redValFlash, greenValFlash, blueValFlash));
  Pixel.show();
  delay(1000);
  Pixel.setPixelColor(0,Pixel.Color(redVal, greenVal, blueVal));
  Pixel.show();
}*/

void colorWipe(uint32_t c, uint8_t wait) {
  for(uint16_t i=0; i<6; i++) {
      pixels.setPixelColor(i, c);
      pixels.show();
      delay(wait);
  }
}

void vibrate(){ //vibrate on then off again
  int onTime = 2500;  //the number of milliseconds for the motor to turn on for
  int offTime = 1000; //the number of milliseconds for the motor to turn off for
 
  digitalWrite(motorPin, HIGH); // turns the motor On
  delay(onTime);                // waits for onTime milliseconds
  digitalWrite(motorPin, LOW);  // turns the motor Off
  delay(offTime);               // waits for offTime milliseconds
}


