//
//  LogInVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 9/4/22.
//

import Foundation
import UIKit
import Firebase


class LogInVC: UIViewController,Loadable {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginBtn.layer.cornerRadius = 4
        registerBtn.layer.cornerRadius = 4

    }
    


    //MARK: - ACTIONS
    @IBAction func LoginPressed(_ sender: Any) {
        
       showLoadingView()
       signInUserFirebase()
        
        //Hide the keyboard
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
 
    }
 
    
    //MARK: -- METHODS
    func signInUserFirebase(){
        
        if let email = emailTextField.text, let  password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                
                if let e = error{
                    
                    self.hideLoadingView()
                    Alert.showBasicAlert(on: self, with: "", message: "\(e.localizedDescription)")
 
                }else{
                    
                    
                    //save the user name to user defaults
                    self.defaults.set(self.emailTextField.text, forKey: "UserEmail")
                    self.performSegue(withIdentifier: "loginToHome", sender: self)
                    self.hideLoadingView()
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
