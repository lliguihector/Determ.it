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
    @IBOutlet weak var selectButton: UIButton!
    
    var showBttnIsTrue = true
    
    
    var selectedDevice : Device?{
        
           didSet{
           print(selectedDevice)
           }
       }
       
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Hide the select button depending on source of view loading
        selectButton.isHidden = showBttnIsTrue
        
        
        if let device = selectedDevice {
            
            // Safely unwrap the optional value and provide a default value if it's nil
            let modelName = device.modelName ?? "No value"
            let model = device.model ?? "No value"
            navigationItem.title =  "\(modelName) \(model)"
            
            
            brandLabel.text = device.brand
            categoryLabel.text = device.category
            serialNumberLabel.text = device.serialNumber
            processorLabel.text = device.processor
            storageLabel.text = device.storageCapacity
            ramLabel.text = device.memoryRam
            osLabel.text = device.os
//            
        }else{
           
            //Unwind back to previous View
        }
        
        
        
        
        
    }
    



}
