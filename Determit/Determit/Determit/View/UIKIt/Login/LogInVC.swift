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



    // Replace the let with var to allow setting from SceneDelegate
      var viewModel: LoginViewModel!

    
    
    
    
    // Dependency Injection via initializer
       init(viewModel: LoginViewModel) {
           self.viewModel = viewModel
           super.init(nibName: nil, bundle: nil)
       }
    
    
       
       required init?(coder: NSCoder) {
           self.viewModel = LoginViewModel(apiManager: APIManager.shared)
           super.init(coder: coder)
       }
    
    
    
    
    
       
   
    //MARK: -- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()


        setUpMyUI()

    }
    
    func setupBinding(){
        
        
        viewModel.authState = {[weak self] state in
            
            switch state{
            case .authenticated(let role):
                self?.loadAppropriateViewController(role: role)
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

    //Load Proper View Controller
    
    private func loadAppropriateViewController(role: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        
        // Create the tab bar controller from the storyboard
              guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController,
                    let navigationController = tabBarController.viewControllers?.first as? UINavigationController else {
                  return
              }

        
        let viewController: UIViewController
        
        switch role {
        case "admin":
            viewController = storyboard.instantiateViewController(withIdentifier: "AdminViewController")
        case "user":
            viewController = storyboard.instantiateViewController(withIdentifier: "UserViewController")
        default:
            // Handle unknown role by showing an error message or a default view controller
            print("Unknown role: \(role)")
            // Optionally, instantiate a default view controller or return
            viewController = storyboard.instantiateViewController(withIdentifier: "DefaultViewController") // Replace with your default VC identifier
        }

        // Set the view controller in the navigation stack
               navigationController.setViewControllers([viewController], animated: false)
               
        // Replace the root view controller using the active window scene
          if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
             let window = windowScene.windows.first {
              window.rootViewController = tabBarController
              window.makeKeyAndVisible()
          }
    }

    //MARK: - ACTIONS
    @IBAction func LoginPressed(_ sender: Any) {
        


        
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
              return
        }
        
        
        //Sign in the user to fire base and st
        
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

