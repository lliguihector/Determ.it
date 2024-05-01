//
//  AddNewDeviceVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/19/23.
//

import UIKit




protocol addNewDeviceVCDelegate: AnyObject{
    func reloadData()
}




class AddNewDeviceVC: UIViewController,Loadable {
    
    //OUTLITS
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var deviceNameTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var serialNumberTextField: UITextField!
    @IBOutlet weak var storageCapacityTextFiled: UITextField!
    @IBOutlet weak var memoryCpacityTextField: UITextField!
    @IBOutlet weak var processorDescriptionTextField: UITextField!
    @IBOutlet weak var imageURLTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var osTextField: UITextField!
    
    @IBOutlet weak var modelNameTextField: UITextField!
    
    var ViewModel = InventoryViewModel()
    
    
    
    weak var delegate: addNewDeviceVCDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
    }
    
    
    
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    //
    //Built in Method
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        self.view.endEditing(true)
    //    }
    
    
    
    
    
    func bindViewModel(){
        
        ViewModel.onError = { [weak self] errorMessage in
            
            Alert.showBasicAlert(on: self!, with: "Error", message: errorMessage)
            
        }
        
        ViewModel.onSuccess = { [weak self] apiMessage in
            //THIRD
            
            DispatchQueue.main.async {
                
                Alert.showBasicAlert(on: self!, with: "Success", message: apiMessage)
                
            }
                
                
      
        }
    }
    
    
    
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
        deviceNameTextField.text?.isEmpty ?? true ||
        osTextField.text?.isEmpty ?? true ||
        categoryTextField.text?.isEmpty ?? true
        
        if isEmpty {
            
            Alert.showBasicAlert(on: self, with: "", message: "One or more fields are missing inputs, Please enter all fields")
            
            print("One or more text fields are empty. Cannot save.")
            
        } else {
            
            
            
            //Store Data to databse
            
            let newDevice = APIDevice(_id: "", brand: brandTextField.text!, deviceName: deviceNameTextField.text!, model: modelTextField.text!, serialNumber: serialNumberTextField.text!, storage: storageCapacityTextFiled.text!, memory: memoryCpacityTextField.text!, processor: processorDescriptionTextField.text!, imageURL: imageURLTextField.text!, category: categoryTextField.text!, operatingSystem: osTextField.text!)
            
            
    
            
            
            //Call the API
            ViewModel.createData(newDevice)
            
            
            self.navigationController!.popViewController(animated: true)
       
            self.delegate!.reloadData() //Call the delegate method here
            }
            
         
            
            
                
    
            
            
            
        }
    }
    
    
    
    

    
    
