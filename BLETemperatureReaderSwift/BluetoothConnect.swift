
import CoreBluetooth
import UIKit
import Foundation

class BluetoothConnect: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral!
    var currentCharacteristic: CBCharacteristic! = nil
    var readRSSITimer: Timer!
    var RSSIholder: NSNumber = 0
    let txCharacteristic = CBUUID(string: "F000AA02-0451-4000-B000-000000000000")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startManager()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("checking state")
        var state = central.state
        if (state == .poweredOn) { //modified
            print("powered on")
            self.centralManager?.scanForPeripherals(withServices: nil, options: nil)
        } else {
            print("BLE not on")
        }
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print("discovering services")
        if (peripheral.name != nil && peripheral.name! == "Adafruit Bluefruit LE"){
            self.peripheral = peripheral
            self.centralManager.connect(self.peripheral, options: [CBConnectPeripheralOptionNotifyOnDisconnectionKey : true])
        }
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("connected to peripheral")
        peripheral.readRSSI()
        self.startReadRSSI()
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        print("connected to \(peripheral)")
        self.stopScan()
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?){
        self.stopReadRSSI()
        if self.peripheral != nil {
            self.peripheral.delegate = nil
            self.peripheral = nil
        }
        print("did disconnect")
        self.startManager()
    }
    
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: Error?){
        print("connection failed")
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: Error?){
        peripheral.discoverCharacteristics(nil, for: peripheral.services![0])
    }
    
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: Error?){
        for characteristic in service.characteristics! {
            let thisCharacteristic = characteristic as CBCharacteristic
            if thisCharacteristic.uuid == txCharacteristic{
                self.currentCharacteristic = thisCharacteristic
            }
        }
        if let error = error {
            print("characteristics error", error)
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: Error?){
        if let error = error {
            print("updated error", error)
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didWriteValueForCharacteristic characteristic: CBCharacteristic, error: Error?){
        if let error = error {
            print("Writing error", error)
        } else {
            print("Succeeded")
        }
    }
    func stopScan(){
        self.centralManager.stopScan()
    }
    
    func startManager(){
        centralManager = CBCentralManager(delegate: self, queue: nil)//modified?
    }
    
    func peripheral(peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        self.RSSIholder = RSSI
    }
    
    @objc func readRSSI(){
        if (self.peripheral != nil){
            self.peripheral.delegate = self
            self.peripheral.readRSSI()
        } else {
            print("peripheral = nil")
        }
        if (Int(truncating: self.RSSIholder) > -70) {
            let openValue = "1".data(using: String.Encoding.utf8)!
            self.peripheral.writeValue(openValue, for: self.currentCharacteristic, type: CBCharacteristicWriteType.withResponse)
        }
    }
    
    func startReadRSSI() {
        if self.readRSSITimer == nil {
            self.readRSSITimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.readRSSI), userInfo: nil, repeats: true)
        }
    }
    
    func stopReadRSSI() {
        if (self.readRSSITimer != nil){
            self.readRSSITimer.invalidate()
            self.readRSSITimer = nil
        }
    }
    @IBAction func connectButton(_ sender: Any) {
        startManager();
    }
}

