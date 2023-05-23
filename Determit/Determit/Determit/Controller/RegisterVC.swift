//
//  RegisterVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 9/4/22.
//

import Foundation
import UIKit
import Firebase


class RegisterVC: UIViewController,Loadable{
    
    
    //Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    
    
    let defaults = UserDefaults.standard
    
    var validation = Validation()
    
    override func viewDidLoad() {
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
        
        
        signUpBtn.layer.cornerRadius = 4
    }
    
 
    
    
    //ACTIONS
    @IBAction func signUpBtnPressed(_ sender: Any) {
        
        //Client Side Form Validation
        if let email = emailTextField.text, let password = passwordTextField.text, let confirmPass = confirmPasswordTextField.text {
            
            let isValidateEmail = self.validation.validateEmail(email: email)
            if(isValidateEmail == false){
                Alert.showBasicAlert(on: self, with: "Format", message: "Please enter a valid email address format")
                print(isValidateEmail)
                return
            }
            
            
            let isValidatePassword = self.validation.validatePassword(password: password)
            if(isValidatePassword == false){
                Alert.showBasicAlert(on: self, with: "Format", message: "Incorect Password Format Minimum 6 characters at least 1 Alpabet and 1 Number")
                print(isValidatePassword)
                return
            }
            
            if confirmPass.isEmpty {
                
                Alert.showBasicAlert(on: self, with: "Format", message: "Please confirm password")
            }
            
            if confirmPass != password{
                Alert.showBasicAlert(on: self, with: "Format", message: "Passwords do not match")
            }
        }
        
            showLoadingView()
            signUpUserToFirebase()
    }
    
    
    
    func signUpUserToFirebase(){
        if let email = emailTextField.text,let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                
                if let e = error{
                    self.hideLoadingView()
                    Alert.showBasicAlert(on: self, with: "", message: "\(e.localizedDescription)")
           
                }else {
                    //save the user name to user defaults
                    self.defaults.set(self.emailTextField.text, forKey: "UserEmail")
        
                    //Let User Know Account was created
                    DispatchQueue.main.async {
                        Alert.showBasicAlert(on: self, with: "", message: "Account successfully created")
                        self.performSegue(withIdentifier: "RegisterToHome", sender: self)
                        
                    }
                }
            }

        }else{
            Alert.showBasicAlert(on: self, with: "", message: "Please enter all fields")
        }
        
    }
    
    
  
    //Built in Method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
  
    
}

//MARK: - UITextFieldDelegate
extension RegisterVC: UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
            
        switch textField{
            
        case emailTextField:
             passwordTextField.becomeFirstResponder()
        case passwordTextField:
            confirmPasswordTextField.becomeFirstResponder()
        default:
            confirmPasswordTextField.resignFirstResponder()
        }
        return true
        
        
        }
   
    
 
}
