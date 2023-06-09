//
//  DeviceDetailsVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/23/23.
//

import UIKit
import Foundation

class DeviceDetailsVC: UIViewController {

    
    //OUTLITS
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var processorLabel: UILabel!
    @IBOutlet weak var storageLabel: UILabel!
    @IBOutlet weak var ramLabel: UILabel!
    
    
    
    var selectedDevice : Device?{
        
           didSet{
           print(selectedDevice)
           }
       }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        if let device = selectedDevice {
            
            brandLabel.text = device.brand
            categoryLabel.text = "Laptop"
            serialNumberLabel.text = device.serialNumber
            processorLabel.text = device.processor
            storageLabel.text = device.storageCapacity
            ramLabel.text = "9"
            navigationItem.title = device.model
//            
        }else{
           
            //Unwind back to previous View
        }
        
        
        
        
        
    }
    



}
