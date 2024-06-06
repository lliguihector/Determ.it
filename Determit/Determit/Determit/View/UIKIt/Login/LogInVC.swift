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
    
    

// self.defaults.set(self.emailTextField.text, forKey: "UserEmail")



      
    private let viewModel: LoginViewModel
    
    // Dependency Injection via initializer
       init(viewModel: LoginViewModel = LoginViewModel()) {
           self.viewModel = viewModel
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           self.viewModel = LoginViewModel()
           super.init(coder: coder)
       }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()


        setUpMyUI()

    }
    
    func setupBinding(){
        viewModel.authState = {[weak self] state in
            
            switch state{
            case .authenticated(let role):
                self?.navigateBasedOnRole(role: role)
            case .unauthenticated(let error):
                self?.showErrorAlert(error: error)
            case .loading:
                
                self!.showLoadingView()
                
                
                
                break
            }
   
        }
        
    }
    
    
    
    
    
    
    //MARK: -- Binding Methods
    private func showErrorAlert(error: Error){
        
        let errorMessage = error.localizedDescription
        DispatchQueue.main.async {
        //Show Alert
        Alert.showBasicAlert(on: self, with: "", message: "\(errorMessage)")
            self.hideLoadingView()
        }
        
        
    }

    
    
private func navigateBasedOnRole(role: String){
    
    switch role {
        
    case "admin":
        
        DispatchQueue.main.async {
        self.performSegue(withIdentifier: "loginToAdmin", sender: self)
            self.hideLoadingView()
        }
        print("Admin View")
    case "user":
        DispatchQueue.main.async {
//        self.performSegue(withIdentifier: "loginToAdmin", sender: self)
            self.hideLoadingView()
        }

        print("User View")

    case "tech":
        
        DispatchQueue.main.async {
//        self.performSegue(withIdentifier: "loginToAdmin", sender: self)
            self.hideLoadingView()
        }
        print("Technician View")

    default:
        
        //Handle other roles or show an error
        print("Unknown role: \(role)")
    }
                          
    }
    
    
 
    
    
    //MARK: - ACTIONS
    @IBAction func LoginPressed(_ sender: Any) {
        


        
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

