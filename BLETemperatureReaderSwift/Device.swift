

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
    /*COPIED and modified to test Flora*/
    
    static let TemperatureServiceUUID = "00771312-1100-0000-0000-ABBA0FA1AFE1" //first one in list from atcommand output
    
    static let TemperatureDataUUID = "00684201-1488-5977-4242-ABBA0FA1AFE1"//second one in list
    static let TemperatureConfig =   "00694203-0077-1210-1342-ABBA0FA1AFE1" //third- maybe write?
    
    static let HumidityServiceUUID = "F000AA20-0451-4000-B000-000000000000"
    static let HumidityDataUUID = "F000AA21-0451-4000-B000-000000000000"
    static let HumidityConfig = "F000AA22-0451-4000-B000-000000000000"
    
    //new IDs for Feather
    //second version
    static let featherService1 = "00771312-1100-0000-0000-ABBA0FA1AFE1"
    static let featherData1 = "00684201-1488-5977-4242-ABBA0FA1AFE1"
    static let featherConfig1 = "00694203-0077-1210-1342-ABBA0FA1AFE1"
    
    static let featherService2 = "F000AA20-0451-4000-B000-000000000000"
    static let featherData2 = "F000AA21-0451-4000-B000-000000000000"
    static let featherConfig2 = "F000AA22-0451-4000-B000-000000000000"
    
    //new IDs for Feather
    /*first version
    static let uuidFeather1 = "00001530-1212-EFDE-1523-785FEABCD123"
    static let uuidFeather2 = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
    static let uuidFeather3 = "EE0C2080-8786-40BA-AB96-99B91AC981D8"
    
    static let featherChar1 = "00001530-1212-EFDE-1523-785FEABCD123"
    static let featherChar2 = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
    static let featherChar3 = "EE0C2080-8786-40BA-AB96-99B91AC981D8"*/
    
    
}
