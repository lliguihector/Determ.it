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
    //Outlits
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    
//User Defaults
    let defaults = UserDefaults.standard
    
    private let viewModel: loginViewModel
    
    // Dependency Injection via initializer
       init(viewModel: loginViewModel = loginViewModel()) {
           self.viewModel = viewModel
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           self.viewModel = loginViewModel()
           super.init(coder: coder)
       }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Bimd ViewModel callbacks
        viewModel.onError = {[weak self] errorMessage in
            DispatchQueue.main.async {
                          self?.showErrorAlert(message: errorMessage)
                      }
        }
        
        viewModel.onloginSuceess = {[weak self] json in
            DispatchQueue.main.async {
                           self?.handleLoginSuccess(response: json)
                       }
        }
        
        
        
        viewModel.onSuccessMock = { [weak self] idToken in

            DispatchQueue.main.async {
                self?.handleSuccessMock(idToken: idToken)
                       }


        }

        setUpMyUI()

    }
    
    
    
    //MARK: -- Binding Methods
    private func showErrorAlert(message: String){
        //Show Alert
        Alert.showBasicAlert(on: self, with: "", message: "\(message)")
        hideLoadingView()
    }

    
    
    private func handleLoginSuccess(response: [String: Any]){
        
        // Handle login success (e.g., navigate to another screen)
             print("Login successful: \(response)")
        
        
    //If statement where depending on roles will Login in user to there custome screen
        
                            //save the user name to user defaults
                            self.defaults.set(self.emailTextField.text, forKey: "UserEmail")
                            //Perform a segue based on rolles Admin, technician, client
                            self.performSegue(withIdentifier: "loginToHome", sender: self)
        
        
                            self.hideLoadingView()
    }
    
    
    private func handleSuccessMock(idToken: String){
        
        
        print("ID Token: \(idToken)")
        
        //save the user name to user defaults
        self.defaults.set(self.emailTextField.text, forKey: "UserEmail")
        //Perform a segue based on rolles Admin, technician, client
        self.performSegue(withIdentifier: "loginToHome", sender: self)
        
        
        
        
        hideLoadingView()
        
        
    }

    
    
    //MARK: - ACTIONS
    @IBAction func LoginPressed(_ sender: Any) {
        
       showLoadingView()

        
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
              return
        }
        
        viewModel.signInUserToFireBase(email: email, password: password)
        
        //Hide the keyboard
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
 

    func setUpMyUI(){
        loginBtn.layer.cornerRadius = 4
        registerBtn.layer.cornerRadius = 4
    }
    
    //Built in Method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

   
}

