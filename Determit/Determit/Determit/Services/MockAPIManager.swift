//
//  MockAPIManager.swift
//  Determit
//
//  Created by Blanca Tixi on 6/19/24.
//

import Foundation
import JWTDecode

class MockAPIManager: APIManagerProtocol{
    
    
    // Simulated data for mock purposes
       private let mockData = [
           "wAV9mT2ROXc4N2fn5bG7pU1Xj3M2": "admin",
           "OGgHfTcl1vTSXCq8uM4Jx80P4Gf2": "user",
           "AYbcFAfu0Dac9T33ohFB1eC5L1V2": "tech"
       ]
       
    
    
    
    func authenticateWithBackEnd(idToken: String, completion: @escaping (Result<String, Error>) -> Void) {
    
        

           let idToken = decodeJWTAndGetUserID(idToken: idToken)
        
        
        //Similate a delay to mimic network latency
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Simulate success or failure based on mock data
            if let role = self.mockData[idToken!] {
                           completion(.success(role))
                       } else {
                           let error = NSError(domain: "MockAPIManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "Role not found"])
                           completion(.failure(error))
                       }
            
            
            
            
    }
        
        
       
        
    }
    
    func decodeJWTAndGetUserID(idToken: String) -> String? {
        do {
            let jwt = try decode(jwt: idToken)
            let userId = jwt.claim(name: "user_id").string
            return userId
        } catch {
            print("Error decoding JWT: \(error)")
            return nil
        }
    }
     
    
    
    
}
