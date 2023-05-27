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
    
    @IBOutlet weak var osLabel: UILabel!
    
    
    var selectedDevice : Device?{
        
           didSet{
           print(selectedDevice)
           }
       }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        if let device = selectedDevice {
            navigationItem.title = device.model
            brandLabel.text = device.brand
            categoryLabel.text = "Laptop"
            serialNumberLabel.text = device.serialNumber
            processorLabel.text = device.processor
            storageLabel.text = device.storageCapacity
            ramLabel.text = "9"
            osLabel.text = device.os
//            
        }else{
           
            //Unwind back to previous View
        }
        
        
        
        
        
    }
    



}
