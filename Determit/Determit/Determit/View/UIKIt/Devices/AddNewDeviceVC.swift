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

class AddNewDeviceVC: UIViewController,Loadable, UITextFieldDelegate, ValidationDelegate,CategorySelectionDelegate,CustomTextFieldDelegate, UIPickerViewDataSource,   UIPickerViewDelegate {
    
    

    
    let storageCapacityOptions = ["64 GB", "128 GB", "256 GB", "512 GB", "1 TB"]
    var selectedStorageCapacity: String? // To store the selected storage capacity
   

    var ValidationBool = true
    
    
    @IBOutlet weak var testLabel: UILabel!
  
    //MARK: Text Fields
    //brand
    @IBOutlet weak var brandTextField: UITextField!
    //name
    @IBOutlet weak var deviceNameTextField: UITextField!
    //model
    @IBOutlet weak var modelNameTextField: UITextField!
    //Category Button
    @IBOutlet weak var selectCategoryBtn: UIButton!
    
    //GB Button
    @IBOutlet weak var secondaryMemorySelectorBtn: UIButton!
    
    //GB Dropdown
   
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    
    
    @IBOutlet weak var memoryCpacityTextField: UITextField!
    @IBOutlet weak var processorDescriptionTextField: UITextField!
    @IBOutlet weak var osTextField: UITextField!
    
 
    //MARK: -- Error Feedback Labels
 
    
    @IBOutlet weak var brandErrorLabel: UILabel!
    
    @IBOutlet weak var deviceNameErrorLabel: UILabel!
    
    
    
    private let viewModel = InventoryViewModel()
    weak var delegate: addNewDeviceVCDelegate?

    //MARK: -- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        pickerView.dataSource = self
//        pickerView.delegate  = self
        
        // Assuming storageOptions is your data array
//            pickerView.reloadAllComponents()
        
        pickerView.isHidden = true // Initially hide the picker view
        
        
        
        // Set the custom delegate for custom text fields
            if let customBrandTextField = brandTextField as? CustomTextField {
                customBrandTextField .validationType = .brand
                customBrandTextField.errorLabel = brandErrorLabel
                customBrandTextField .customDelegate = self
            }
        
        
        if let customDeviceNameTextField = deviceNameTextField as? CustomTextField {
        customDeviceNameTextField.validationType = .name
            customDeviceNameTextField.errorLabel = deviceNameErrorLabel
        customDeviceNameTextField.customDelegate = self
            }
//            if let customTextField = modelNameTextField as? CustomTextField {
//                customTextField.customDelegate = self
//            }
//            if let customTextField = memoryCpacityTextField as? CustomTextField {
//                customTextField.customDelegate = self
//            }
//            if let customTextField = processorDescriptionTextField as? CustomTextField {
//                customTextField.customDelegate = self
//            }
//            if let customTextField = osTextField as? CustomTextField {
//                customTextField.customDelegate = self
//            }
        
        
        
        
        bindViewModel()
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        viewModel.delegate = self

        setupUserInterface()
    }

    

    func validationDidFinish(isValid: Bool, errorMessage: String?) {
        print("Bolean: \(isValid) + Error Message: \(errorMessage ?? "ok")")
    }
 
    //MARK: -- Picker View
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        return storageCapacityOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return storageCapacityOptions[row]
       }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

           
           selectedStorageCapacity = storageCapacityOptions[row]
           secondaryMemorySelectorBtn.setTitle(selectedStorageCapacity, for: .normal)
           pickerView.isHidden = true
          
       }
       
 
    
    //MARK: -- Custom Text
    //This method updates the label
    func updateMyLabel(_ errorMessage: String) {
//        nameError.text = errorMessage
    }
    
   
    
    
    //MARK: -- Actions
    @IBAction func selectStorage(_ sender: Any) {
        pickerView.isHidden = !pickerView.isHidden
    }
    
    
    //MARK: -- Category
    func didSelectCategory(_ category: String, _ sfImage: String) {
        let sfImage = ""
        setButtonUI(selectCategoryBtn,category, sfImage)
    }
    
    
   func setButtonUI( _ button: UIButton, _ title:  String, _ sfIcon: String){

         // Create a UIButtonConfiguration
           var config = UIButton.Configuration.plain()
           
           // Set the title and image
           config.title = title
           config.image = UIImage(systemName: sfIcon)
           
           // Adjust the placement of the image and title
           config.imagePlacement = .trailing // This places the image to the left of the title
           config.imagePadding = 8.0 // Spacing between image and title
           config.baseForegroundColor = .systemGreen // Set the color of the image and title
           
           // Apply the configuration to the button
           button.configuration = config
           button.contentHorizontalAlignment = .center// Align content to the left
    
         
     }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let categorySelectionView = segue.destination as? CategorySelectionView {
                categorySelectionView.delegate = self
            }
        }
    
    //MARK: -- Methods
    func setupUserInterface(){
        //Style Select Category Button
        selectCategoryBtn.layer.borderWidth = 1.0
        selectCategoryBtn.layer.cornerRadius = 4
        selectCategoryBtn.layer.borderColor = UIColor.black.cgColor
        selectCategoryBtn.tintColor = UIColor.black
        
        setButtonUI(selectCategoryBtn,"Select Category","")
        
        //Style Secondary Memory Button
        secondaryMemorySelectorBtn.layer.borderWidth = 1.0
        secondaryMemorySelectorBtn.layer.cornerRadius = 4
        secondaryMemorySelectorBtn.layer.borderColor = UIColor.black.cgColor
        secondaryMemorySelectorBtn.tintColor = UIColor.black
        
        setButtonUI(secondaryMemorySelectorBtn,"Select Storage","")
     

    }
  
    
    @objc func handleTap() {
        view.endEditing(true)
    }

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    
    @IBAction func addNewPressed(_ sender: Any) {
        
        let isEmpty =
        brandTextField.text?.isEmpty ?? true
        ||
        memoryCpacityTextField.text?.isEmpty ?? true ||
        processorDescriptionTextField.text?.isEmpty ?? true ||
        deviceNameTextField.text?.isEmpty ?? true ||
        osTextField.text?.isEmpty ?? true

        
        if isEmpty{
            Alert.showBasicAlert(on: self, with: "", message: "One or more fields are missing inputs, Please enter all fields")
            print("One or more text fields are empty. Cannot save.")
        } else {
            
            
            
            //Store Data to databse
//
//            let newDevice = APIDevice(_id: "", brand: brandTextField.text!, deviceName: deviceNameTextField.text!, model: modelTextField.text!, serialNumber: serialNumberTextField.text!, storage: storageCapacityTextFiled.text!, memory: memoryCpacityTextField.text!, processor: processorDescriptionTextField.text!, imageURL: imageURLTextField.text!, category: categoryTextField.text!, operatingSystem: osTextField.text!)
//
//            //Call the API
//            viewModel.createData(newDevice)
            
            
            self.navigationController!.popViewController(animated: true)
       
            self.delegate!.reloadData() //Call the delegate method here
            }
 
        }
    
    
 
    
    //MARK: -- View Model Binding
    func bindViewModel(){
        
        viewModel.onError = { [weak self] errorMessage in
            
            Alert.showBasicAlert(on: self!, with: "Error", message: errorMessage)
            
        }
        
        viewModel.onSuccess = { [weak self] apiMessage in
            //THIRD
            
            DispatchQueue.main.async {
                
                Alert.showBasicAlert(on: self!, with: "Success", message: apiMessage)
                
            }
      
        }
  

}





}

