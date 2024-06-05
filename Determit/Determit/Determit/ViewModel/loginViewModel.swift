//
//  LoginViewModel.swift
//  Determit
//
//  Created by Blanca Tixi on 6/5/24.
//

import Foundation
import Firebase



class loginViewModel{
    
    
    private let apiManager: APIManager
    
    var onSuccessMock: ((String)->Void)?
    var onError: ((String)->Void)?
    var onloginSuceess: (([String: Any]) ->Void)?
    
   
    
    
    init(apiManager: APIManager = APIManager.shared){
        self.apiManager = apiManager
    }
    
    
    
    
    
    
    //MARK: -- Firebase
    func signInUserToFireBase(email: String, password: String){

            
            guard !email.isEmpty, !password.isEmpty else{
                
                onError?("Missing email or password")
                return
            }
            
            
            //>>> Firebase Code
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                
                if let error = error{
                    self?.onError?("Error signing in: \(error.localizedDescription)")
                    return
 
                }

                
                
                guard let user = authResult?.user else{
                    
                    self?.onError?("No user found")
                    return
                }
                
                
                user.getIDToken() { idToken, error in
                    
                    if let error = error {
                        self?.onError?("Error fetching ID Token: \(error.localizedDescription)")
                        return
                    }
                    
            
                
                guard let idToken = idToken else {
                    self?.onError?("ID token is nil")
                    return
                }

                    self?.authenticateWithBackend(idToken: idToken)
   
                }
            }
    }
    
    private func authenticateWithBackend(idToken: String) {
          apiManager.authenticateWithBackEnd(idToken: idToken) { [weak self] result in
              switch result {
              case .success(let json):
                  self?.onloginSuceess?(json)
              case .failure(let error):
                  self?.onError?("Error: \(error.localizedDescription)")
              }
          }
      }
    
    
    
    
    
    
    
}
