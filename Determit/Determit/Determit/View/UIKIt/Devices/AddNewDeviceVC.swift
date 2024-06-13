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

class AddNewDeviceVC: UIViewController,Loadable, UITextFieldDelegate,CustomTextFieldDelegate, ValidationDelegate, CategorySelectionDelegate{
    
    
    
    func didSelectCategory(_ category: String, _ sfImage: String) {
        categorySelectedLabel.text = category
        categoryIcon.image = UIImage(systemName: sfImage)
    }
    
    
    
    
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let categorySelectionView = segue.destination as? CategorySelectionView {
                categorySelectionView.delegate = self
            }
        }
    
    
    
    func validationDidFinish(isValid: Bool, errorMessage: String?) {
        print("Bolean: \(isValid) + Error Message: \(errorMessage ?? "ok")")
    }
  
    
    
    
    
    
    
    
    func textFieldDidEndEditing(_ textField: CustomTextField, isValid: Bool, errorMessage: String?) {
                 if isValid {
                     textField.clearErrorState()
                     textField.showCheckmark()
                     updateErrorLabel(for: textField, with: nil)
                 } else {
                     textField.showErrorState(message: errorMessage ?? "Invalid input")
                     updateErrorLabel(for: textField, with: errorMessage)
                 }
    }
    
    
    
    var ValidationBool = true
    
    
    @IBOutlet weak var testLabel: UILabel!
    
    
    
    //OUTLITS
    @IBOutlet weak var brandTextField: UITextField!
    
    @IBOutlet weak var deviceNameTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var serialNumberTextField: CustomTextField!
    @IBOutlet weak var storageCapacityTextFiled: UITextField!
    @IBOutlet weak var memoryCpacityTextField: UITextField!
    @IBOutlet weak var processorDescriptionTextField: UITextField!
    @IBOutlet weak var imageURLTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var osTextField: UITextField!
    
    @IBOutlet weak var modelNameTextField: UITextField!
    
    
    
    //Category
    
    
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var categorySelectedLabel: UILabel!
    
    
    
    
    private let viewModel = InventoryViewModel()
    
    weak var delegate: addNewDeviceVCDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        viewModel.delegate = self
        
//        serialNumberTextField.customDelegate = self
        
        setupUi()
        
    }
    
    

     private func updateErrorLabel(for textField: CustomTextField, with message: String?) {
         switch textField {
         case brandTextField:
             testLabel.text = message
         case modelTextField:
             testLabel.text = message
         // Add cases for other text fields...
         default:
             break
         }
     }
    
    
    func setupUi(){
        
   
        
        
    }
    
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    //
    //Built in Method
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    
    
    
    
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
        // Observe ViewModel properties for updates
//               ViewModel.updateValidationStatus = { [weak self] isValid in
//                   self?.updateValidationStatus(isValid: isValid)
//               }
//
//               ViewModel.updateErrorMessage = { [weak self] errorMessage in
//                   self?.updateErrorMessage(errorMessage: errorMessage)
//               }

        
    }
    
    
//    func updateValidationStatus(isValid: Bool) {
//
//
//        self.ValidationBool = isValid
//        }
//
//        func updateErrorMessage(errorMessage: String?) {
//
//        }


    
    
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
            viewModel.createData(newDevice)
            
            
            self.navigationController!.popViewController(animated: true)
       
            self.delegate!.reloadData() //Call the delegate method here
            }
 
        }
    
    
 
    
    

    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//
//
//        viewModel.validate(input: serialNumberTextField.text, for: .email)
//
//
//
//
//
//
//
//    }
    
    

}
    
