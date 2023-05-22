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
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var serialNumberTextField: UITextField!
    @IBOutlet weak var storageCapacityTextFiled: UITextField!
    @IBOutlet weak var memoryCpacityTextField: UITextField!
    @IBOutlet weak var processorDescriptionTextField: UITextField!
    @IBOutlet weak var imageURLTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
          tapGesture.cancelsTouchesInView = false
          view.addGestureRecognizer(tapGesture)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
@objc func handleTap() {
    view.endEditing(true)
}
//
    //Built in Method
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }

    
    
    
    @IBAction func addNewPressed(_ sender: Any) {
        
        
        
        
        
        let isEmpty =
                            brandTextField.text?.isEmpty ?? true ||
                            modelTextField.text?.isEmpty ?? true
        ||
        serialNumberTextField.text?.isEmpty ?? true ||
        storageCapacityTextFiled.text?.isEmpty ?? true ||
        memoryCpacityTextField.text?.isEmpty ?? true ||
        processorDescriptionTextField.text?.isEmpty ?? true ||
        imageURLTextField.text?.isEmpty ?? true ||
       categoryTextField.text?.isEmpty ?? true
    

              if isEmpty {
                  
                  Alert.showBasicAlert(on: self, with: "", message: "One or more fields are missing inputs, Please enter all fields")

                  print("One or more text fields are empty. Cannot save.")
                  
              } else {
                  saveDeviceDataToCoreData()
                  
                  let alertController = UIAlertController(title: "Success!", message: "new device data was successfuly added.", preferredStyle: .alert)

                  let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                             // Code to handle the OK action
                             print("OK button pressed")
                             
//                      self.navigationController?.popViewController(animated: true)
                      DispatchQueue.main.async {
                          
                          self.navigationController?.popViewController(animated: true)
                         
                      }
                      
                  }
                  
                  
                  alertController.addAction(okAction)
                  present(alertController, animated: true, completion: nil)
                         
                  
                  
              }
          }
        
        
        
        
        
        
        
    func saveDeviceDataToCoreData(){
        
        
       
        let newDevice = Device(context: self.context)
        newDevice.deviceID = "001"
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
    
    
