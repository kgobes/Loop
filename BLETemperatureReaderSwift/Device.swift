//
//  BLEConstants.swift
//  iOSRemoteConfBLEDemo
//
//  Created by Evan Stone on 4/9/16.
//  Copyright © 2016 Cloud City. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------
// Information about Texas Instruments SensorTag UUIDs can be found at:
// http://processors.wiki.ti.com/index.php/SensorTag_User_Guide#Sensors
//------------------------------------------------------------------------
// From the TI documentation:
//  The TI Base 128-bit UUID is: F0000000-0451-4000-B000-000000000000.
//
//  All sensor services use 128-bit UUIDs, but for practical reasons only
//  the 16-bit part is listed in this document.
//
//  It is embedded in the 128-bit UUID as shown by example below.
//
//          Base 128-bit UUID:  F0000000-0451-4000-B000-000000000000
//          "0xAA01" maps as:   F000AA01-0451-4000-B000-000000000000
//                                  ^--^
//------------------------------------------------------------------------

struct Device {
    
    static let SensorTagAdvertisingUUID = "AA10"
   /* ORIGINAL:
    static let TemperatureServiceUUID = "F000AA00-0451-4000-B000-000000000000"
    static let TemperatureDataUUID = "F000AA01-0451-4000-B000-000000000000"
    static let TemperatureConfig = "F000AA02-0451-4000-B000-000000000000"

    static let HumidityServiceUUID = "F000AA20-0451-4000-B000-000000000000"
    static let HumidityDataUUID = "F000AA21-0451-4000-B000-000000000000"
    static let HumidityConfig = "F000AA22-0451-4000-B000-000000000000"

    static let SensorDataIndexTempInfrared = 0
    static let SensorDataIndexTempAmbient = 1
    static let SensorDataIndexHumidityTemp = 0
    static let SensorDataIndexHumidity = 1
 */
    
    /*COPIED and modified to test Flora*/
    
    static let TemperatureServiceUUID = "00771312-1100-0000-0000-ABBA0FA1AFE1" //first one in list from atcommand output
    
    static let TemperatureDataUUID = "00684201-1488-5977-4242-ABBA0FA1AFE1"//second one in list
    //static let TemperatureDataUUID = "0x4201"
    //static let TemperatureDataUUID = "0x1702a0180"
    static let TemperatureConfig =   "00694203-0077-1210-1342-ABBA0FA1AFE1" //third- maybe write?
    
    static let HumidityServiceUUID = "F000AA20-0451-4000-B000-000000000000"
    static let HumidityDataUUID = "F000AA21-0451-4000-B000-000000000000"
    static let HumidityConfig = "F000AA22-0451-4000-B000-000000000000"
    
    static let SensorDataIndexTempInfrared = 0
    static let SensorDataIndexTempAmbient = 1
    static let SensorDataIndexHumidityTemp = 0
    static let SensorDataIndexHumidity = 1
    
}
