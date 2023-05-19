//
//  AddNewDeviceVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/19/23.
//

import UIKit
import CoreData

class AddNewDeviceVC: UIViewController {

    //OUTLITS
    @IBOutlet weak var deviceIDTextField: UITextField!
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var serialNumberTextField: UITextField!
    @IBOutlet weak var storageCapacityTextFiled: UITextField!
    @IBOutlet weak var memoryCpacityTextField: UITextField!
    @IBOutlet weak var processorDescriptionTextField: UITextField!
    @IBOutlet weak var imageURLTextField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    //Built in Method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    
    
    @IBAction func addNewPressed(_ sender: Any) {
        
        
        
        
        
        let isEmpty = deviceIDTextField.text?.isEmpty ?? true ||
                            brandTextField.text?.isEmpty ?? true ||
                            modelTextField.text?.isEmpty ?? true
        ||
        serialNumberTextField.text?.isEmpty ?? true ||
        storageCapacityTextFiled.text?.isEmpty ?? true ||
        memoryCpacityTextField.text?.isEmpty ?? true ||
        processorDescriptionTextField.text?.isEmpty ?? true ||
        imageURLTextField.text?.isEmpty ?? true
    

              if isEmpty {
                  
                  Alert.showBasicAlert(on: self, with: "", message: "One or more fields are missing inputs, Please enter all fields")
                  print("One or more text fields are empty. Cannot save.")
              } else {
                  saveDeviceDataToCoreData()
                  Alert.showBasicAlert(on: self, with: "", message: "New Device Info was successfuly added to database")
              }
          }
        
        
        
        
        
        
        
    func saveDeviceDataToCoreData(){
        
        
       
        let newDevice = Device(context: self.context)
        newDevice.deviceID = deviceIDTextField.text
        newDevice.brand = brandTextField.text
        newDevice.model = modelTextField.text
        newDevice.serialNumber = serialNumberTextField.text
        newDevice.storageCapacity = storageCapacityTextFiled.text
        newDevice.memoryRam = 8
        newDevice.processor = processorDescriptionTextField.text
        newDevice.imageURL = imageURLTextField.text
    
        saveDevices()
    }

        
        
    
    //Save Data
    func saveDevices(){
        
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        
        
    }
    
        
        
    }
    
    
