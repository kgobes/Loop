

import UIKit
import CoreBluetooth

// Conform to CBCentralManagerDelegate, CBPeripheralDelegate protocols
class BluetoothHandler: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    @IBOutlet weak var temperatureLabel: UILabel! //connected text
    @IBOutlet weak var disconnectButton: UIButton!
    
    //Connect 3 change color button
    /*@IBOutlet weak var changeColorToRed: UIButton!
    
    @IBOutlet weak var changeColorToBlue: UIButton!
    
    @IBOutlet weak var changeColorToGreen: UIButton!*/
    // define our scanning interval times
    let timerPauseInterval:TimeInterval = 10.0
    let timerScanInterval:TimeInterval = 2.0
    
    // UI-related
    let temperatureLabelFontName = "HelveticaNeue-Thin"
    let temperatureLabelFontSizeMessage:CGFloat = 56.0
    let temperatureLabelFontSizeTemp:CGFloat = 81.0
    
    //var backgroundImageViews: [UIImageView]!
    var visibleBackgroundIndex = 0
    var invisibleBackgroundIndex = 1
    var keepScanning = false
    var enableValue:UInt8 = 2
    //var enableValue:String = "2"
    var foundMyBracelet = false
    var foundFriendA = false;
    
    //var isScanning = false
    
    // Core Bluetooth properties
    var centralManager:CBCentralManager!
    var sensorTag:CBPeripheral?
    var temperatureCharacteristic:CBCharacteristic?
    var humidityCharacteristic:CBCharacteristic?
    
    // This could be simplified to "SensorTag" and check if it's a substring.
    // (Probably a good idea to do that if you're using a different model of
    // the SensorTag, or if you don't know what model it is...)
    let sensorTagName = "Adafruit Bluefruit LE"
    
    let trinketID = "Adafruit Bluefruit LE"
    
    var newColor = "purple";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        
        // Create our CBCentral Manager
        // delegate: The delegate that will receive central role events. Typically self.
        // queue:    The dispatch queue to use to dispatch the central role events.
        //           If the value is nil, the central manager dispatches central role events using the main queue.
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
        // Central Manager Initialization Options (Apple Developer Docs): http://tinyurl.com/zzvsgjh
        //  CBCentralManagerOptionShowPowerAlertKey
        //  CBCentralManagerOptionRestoreIdentifierKey
        //      To opt in to state preservation and restoration in an app that uses only one instance of a
        //      CBCentralManager object to implement the central role, specify this initialization option and provide
        //      a restoration identifier for the central manager when you allocate and initialize it.
        //centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
        
        // configure initial UI
        temperatureLabel.font = UIFont(name: temperatureLabelFontName, size: temperatureLabelFontSizeMessage)
        temperatureLabel.text = "Searching"
        
    }
    
    
    // MARK: - Handling User Interaction
    
    
    
    @IBAction func handleDisconnectButtonTapped(_ sender: AnyObject) {
        // if we don't have a sensor tag, start scanning for one...
        if sensorTag == nil {
            keepScanning = true
            resumeScan()
            return
        } else {
            disconnect()
        }
    }
    func disconnect() {
        if let sensorTag = self.sensorTag {
            if let tc = self.temperatureCharacteristic {
                sensorTag.setNotifyValue(false, for: tc)
            }
            if let hc = self.humidityCharacteristic {
                sensorTag.setNotifyValue(false, for: hc)
            }
            
            /*
             NOTE: The cancelPeripheralConnection: method is nonblocking, and any CBPeripheral class commands
             that are still pending to the peripheral you’re trying to disconnect may or may not finish executing.
             Because other apps may still have a connection to the peripheral, canceling a local connection
             does not guarantee that the underlying physical link is immediately disconnected.
             
             From your app’s perspective, however, the peripheral is considered disconnected, and the central manager
             object calls the centralManager:didDisconnectPeripheral:error: method of its delegate object.
             */
            centralManager.cancelPeripheralConnection(sensorTag)
        }
        temperatureCharacteristic = nil
        humidityCharacteristic = nil
    }
    
    
    // MARK: - Bluetooth scanning
    
    @objc func pauseScan() {
        // Scanning uses up battery on phone, so pause the scan process for the designated interval.
        print("*** PAUSING SCAN...")
        _ = Timer(timeInterval: timerPauseInterval, target: self, selector: #selector(resumeScan), userInfo: nil, repeats: false)
        centralManager.stopScan()
        disconnectButton.isEnabled = true
    }
    
    @objc func resumeScan() {
        if keepScanning {
            // Start scanning again...
            print("*** RESUMING SCAN!")
            disconnectButton.isEnabled = false
            temperatureLabel.font = UIFont(name: temperatureLabelFontName, size: temperatureLabelFontSizeMessage)
            temperatureLabel.text = "Searching"
            _ = Timer(timeInterval: timerScanInterval, target: self, selector: #selector(pauseScan), userInfo: nil, repeats: false)
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        } else {
            disconnectButton.isEnabled = true
        }
    }
    
    // MARK: - CBCentralManagerDelegate methods
    
    // Invoked when the central manager’s state is updated.
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var showAlert = true
        var message = ""
        
        switch central.state {
        case .poweredOff:
            message = "Bluetooth on this device is currently powered off."
        case .unsupported:
            message = "This device does not support Bluetooth Low Energy."
        case .unauthorized:
            message = "This app is not authorized to use Bluetooth Low Energy."
        case .resetting:
            message = "The BLE Manager is resetting; a state update is pending."
        case .unknown:
            message = "The state of the BLE Manager is unknown."
        case .poweredOn:
            showAlert = false
            message = "Bluetooth LE is turned on and ready for communication."
            
            print(message)
            keepScanning = true
            _ = Timer(timeInterval: timerScanInterval, target: self, selector: #selector(pauseScan), userInfo: nil, repeats: false)
            
            // Initiate Scan for Peripherals
            //Option 1: Scan for all devices
            centralManager.scanForPeripherals(withServices: nil, options: nil)
            
            // Option 2: Scan for devices that have the service you're interested in...
            //let sensorTagAdvertisingUUID = CBUUID(string: Device.SensorTagAdvertisingUUID)
            //print("Scanning for SensorTag adverstising with UUID: \(sensorTagAdvertisingUUID)")
            //centralManager.scanForPeripheralsWithServices([sensorTagAdvertisingUUID], options: nil)
            
        }
        
        if showAlert {
            let alertController = UIAlertController(title: "Central Manager State", message: message, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(okAction)
            self.show(alertController, sender: self)
        }
    }
    
    
    /*
     Invoked when the central manager discovers a peripheral while scanning.
     
     The advertisement data can be accessed through the keys listed in Advertisement Data Retrieval Keys.
     You must retain a local copy of the peripheral if any command is to be performed on it.
     In use cases where it makes sense for your app to automatically connect to a peripheral that is
     located within a certain range, you can use RSSI data to determine the proximity of a discovered
     peripheral device.
     
     central - The central manager providing the update.
     peripheral - The discovered peripheral.
     advertisementData - A dictionary containing any advertisement data.
     RSSI - The current received signal strength indicator (RSSI) of the peripheral, in decibels.
     
     */
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // Retrieve the peripheral name from the advertisement data using the "kCBAdvDataLocalName" key
        if let peripheralName = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            print("NEXT PERIPHERAL NAME: \(peripheralName)")
            print("NEXT PERIPHERAL UUID: \(peripheral.identifier.uuidString)")
            if !foundMyBracelet{ //no bracelet found yet, the one we have found is users
                if peripheralName == sensorTagName {
                    foundMyBracelet = true
                    //pauseScan()
                    print("Found bracelet. ")
                    // to save power, stop scanning for other devices
                    keepScanning = false
                    disconnectButton.isEnabled = true
                    
                    // save a reference to the sensor tag
                    sensorTag = peripheral
                    sensorTag!.delegate = self
                    
                    // Request a connection to the peripheral
                    centralManager.connect(sensorTag!, options: nil)
                }
            }
            else if peripheralName == trinketID && foundMyBracelet && !foundFriendA { //find another bracelet after the first one
                print("found trinket")
                foundFriendA = true
                nearTrinket()
            }
        }
    }
    
    
    /*
     Invoked when a connection is successfully created with a peripheral.
     
     This method is invoked when a call to connectPeripheral:options: is successful.
     You typically implement this method to set the peripheral’s delegate and to discover its services.
     */
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("**** SUCCESSFULLY CONNECTED TO SENSOR TAG!!!")
        
        
        temperatureLabel.font = UIFont(name: temperatureLabelFontName, size: temperatureLabelFontSizeMessage)
        temperatureLabel.text = "Connected to bracelet!"
        
        
        // Now that we've successfully connected to the SensorTag, let's discover the services.
        // - NOTE:  we pass nil here to request ALL services be discovered.
        //          If there was a subset of services we were interested in, we could pass the UUIDs here.
        //          Doing so saves battery life and saves time.
        peripheral.discoverServices(nil)
    }
    
    
    /*
     Invoked when the central manager fails to create a connection with a peripheral.
     
     This method is invoked when a connection initiated via the connectPeripheral:options: method fails to complete.
     Because connection attempts do not time out, a failed connection usually indicates a transient issue,
     in which case you may attempt to connect to the peripheral again.
     */
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("**** CONNECTION TO SENSOR TAG FAILED!!!")
    }
    
    
    /*
     Invoked when an existing connection with a peripheral is torn down.
     
     This method is invoked when a peripheral connected via the connectPeripheral:options: method is disconnected.
     If the disconnection was not initiated by cancelPeripheralConnection:, the cause is detailed in error.
     After this method is called, no more methods are invoked on the peripheral device’s CBPeripheralDelegate object.
     
     Note that when a peripheral is disconnected, all of its services, characteristics, and characteristic descriptors are invalidated.
     */
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("**** DISCONNECTED FROM SENSOR TAG!!!")
        temperatureLabel.font = UIFont(name: temperatureLabelFontName, size: temperatureLabelFontSizeMessage)
        temperatureLabel.text = "Tap to search"
        if error != nil {
            print("****** DISCONNECTION DETAILS: \(error!.localizedDescription)")
        }
        sensorTag = nil
        foundMyBracelet = false
    }
    

    
    /*
     Invoked when you discover the peripheral’s available services.
     
     This method is invoked when your app calls the discoverServices: method.
     If the services of the peripheral are successfully discovered, you can access them
     through the peripheral’s services property.
     
     If successful, the error parameter is nil.
     If unsuccessful, the error parameter returns the cause of the failure.
     */
    // When the specified services are discovered, the peripheral calls the peripheral:didDiscoverServices: method of its delegate object.
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("in discover services method")
        if error != nil {
            print("ERROR DISCOVERING SERVICES: \(String(describing: error?.localizedDescription))")
            return
        }
        
        // Core Bluetooth creates an array of CBService objects —- one for each service that is discovered on the peripheral.
        if let services = peripheral.services {
            print("in if statement")
            for service in services {
                print("Discovered service \(service)")
                // If we found either the temperature or the humidity service, discover the characteristics for those services.
                if (service.uuid == CBUUID(string: Device.TemperatureServiceUUID)) ||
                    (service.uuid == CBUUID(string: Device.HumidityServiceUUID)) {
                    print("MATCHED EXPECTED SERVICE UUID")
                    peripheral.discoverCharacteristics(nil, for: service)
                    
                }
            }
        }
    }
    
    
    /*
     Invoked when you discover the characteristics of a specified service.
     
     If the characteristics of the specified service are successfully discovered, you can access
     them through the service's characteristics property.
     
     If successful, the error parameter is nil.
     If unsuccessful, the error parameter returns the cause of the failure.
     */
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("in discover characteristics method");
        if error != nil {
            print("ERROR DISCOVERING CHARACTERISTICS: \(String(describing: error?.localizedDescription))")
            return
        }
        if let characteristics = service.characteristics {
            print("in if for char")
            let enableBytes = withUnsafePointer(to: &enableValue){ //did this to convert in xcode9
                return Data(bytes: $0, count: MemoryLayout<UInt8>.size)
            }
            print("enable Value:" )
            print(enableValue)
            for characteristic in characteristics {
                print("checking characteristics")
                // Matches UUID characteristic
                if characteristic.uuid == CBUUID(string: Device.TemperatureDataUUID) {
                    // Enable the IR Temperature Sensor notifications
                    print("Matching characteristic ID")
                    temperatureCharacteristic = characteristic
                    sensorTag?.setNotifyValue(true, for: characteristic)
                    print("after set notify value");
                }
                
                // LED Configuration Characteristic
                if characteristic.uuid == CBUUID(string: Device.TemperatureConfig) {
                    // Enable IR Temperature Sensor
                    print("Matching characteristic round 2")
                    sensorTag?.writeValue(enableBytes as Data, for: characteristic, type: .withResponse)
                    print("after send bytes");
                }
                
            }
            
        }
    }
    
    
    /*
     Invoked when you retrieve a specified characteristic’s value,
     or when the peripheral device notifies your app that the characteristic’s value has changed.
     
     This method is invoked when your app calls the readValueForCharacteristic: method,
     or when the peripheral notifies your app that the value of the characteristic for
     which notifications and indications are enabled has changed.
     
     If successful, the error parameter is nil.
     If unsuccessful, the error parameter returns the cause of the failure.
     */
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil {
            print("ERROR ON UPDATING VALUE FOR CHARACTERISTIC: \(characteristic) - \(String(describing: error?.localizedDescription))")
            return
        }
        
        // extract the data from the characteristic's value property and display the value based on the characteristic type
        if let dataBytes = characteristic.value {
            if characteristic.uuid == CBUUID(string: Device.TemperatureDataUUID) {
                //displayTemperature(dataBytes)
            } else if characteristic.uuid == CBUUID(string: Device.HumidityDataUUID) {
               // displayHumidity(dataBytes)
            }
        }
    }
    
    // Below are the functions of changing color
    @IBAction func changeLEDToRed(_ sender: UIButton) {
        enableValue = 1//"FF0000" //orginally 1
        print("change color to 1")
        sensorTag?.discoverServices(nil)
        print("after discover services call")
    }
    
    @IBAction func changeLEDToBlue(_ sender: UIButton) {
        enableValue = 2//"0000FF"
        print("change color to 2")
        if sensorTag == nil{ //check to see if sensor is still active
            print("sensor tag is nil")
        }
        else{
            print(sensorTag)
        }
        sensorTag?.discoverServices(nil)
    }
    
    @IBAction func changeLEDToGreen(_ sender: UIButton) {
        enableValue = 3//"00FF00"
        print("change color to 3")
        sensorTag?.discoverServices(nil)
    }
    
    func nearTrinket(){
        enableValue = 4//"4"
        print("going to change color for detected friend")
        sensorTag?.discoverServices(nil)
    }
    func nearFriendAdded(color: String){
        nearTrinket();
        print(color)
        
    }
    
    // MARK: - TI Sensor Tag Utility Methods
}













