//
//  LoginViewModel.swift
//  Determit
//
//  Created by Blanca Tixi on 6/5/24.
//

import Foundation
import Firebase



class LoginViewModel{
    
    
    //Define an enum for the authentication state
    enum AuthState{
        case authenticated(role: String)
        case unauthenticated(error: Error)
        case loading
    }
    
    //Create a property to handle the authentication state
    var authState: ((AuthState) -> Void)?
    
    
    private let apiManager: APIManager
    
  
    var onError: ((String)->Void)?
//    var onloginSuceess: ((String)->Void)?
    
   
    
    
    init(apiManager: APIManager = APIManager.shared){
        self.apiManager = apiManager
    }
    
    
    
    
    
    
    //MARK: -- Firebase
    func signInUserToFireBase(email: String, password: String){

        self.authState?(.loading)
        
            guard !email.isEmpty, !password.isEmpty else{
                
                onError?("Missing email or password")
                return
            }
            
            
            //>>> Firebase Code
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                
                if let error = error{
                    
                    self?.authState?(.unauthenticated(error: error))
//                    self?.onError?("Error signing in: \(error.localizedDescription)")
                    return
 
                }

                
                
                guard let user = authResult?.user else{
                    return
                }
                
                
                user.getIDToken() { idToken, error in
                    
                    if let error = error {
                        self?.authState?(.unauthenticated(error: error))
//                        self?.onError?("Error fetching ID Token: \(error.localizedDescription)")
                        return
                    }
                    
            
                
                guard let idToken = idToken else {
                    return
                }

//                    print(">>>ID Token:\(idToken)")
                    self?.authenticateWithBackend(idToken: idToken)
                   
   
                }
            }
    }
    
    private func authenticateWithBackend(idToken: String) {
        
          apiManager.authenticateWithBackEnd(idToken: idToken) { [weak self] result in
              switch result {
              case .success(let role):
                  self?.authState?(.authenticated(role: role))
              case .failure(let error):
                  self?.authState?(.unauthenticated(error: error))
              }
          }
      }
    
    
    
    
    
    
    
}
