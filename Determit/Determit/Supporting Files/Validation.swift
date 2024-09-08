//
//  Validation.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 1/27/23.
//

import Foundation
class Validation{
    
  
    
    //MARK: -- Login and Registration
    public func validateEmail(email: String) -> Bool{
        
        let emailRegEx =  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let trimmedString = email.trimmingCharacters(in: .whitespaces)
        let validateEmail = NSPredicate(format: "SELF MATCHES %@",emailRegEx)
        let isValidatedEmail = validateEmail.evaluate(with: trimmedString)
        
       
        return isValidatedEmail
    }
    
    
    
    public func validatePassword(password: String) -> Bool{
       //Minimum 6 characters at least 1 Alpabet and 1 Number
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,32}$"
        let trimmedString = password.trimmingCharacters(in: .whitespaces)
        let validatePassword = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        let isvalidatePass = validatePassword.evaluate(with: trimmedString)

     return isvalidatePass
    }
    
    
  //MARK: -- new device form
    
    //Brand
    public func validateBrand(brand: String) -> Bool{


        let trimmedBrand = trimWhiteSpaces(str: brand)
        
        
        return !trimmedBrand.isEmpty && trimmedBrand.count >= 3

    }
    
    public func validateDeviceName(deviceName: String) -> Bool{
        
        let trimmedBrand = trimWhiteSpaces(str: deviceName)
        
        return !trimmedBrand.isEmpty && trimmedBrand.count >= 1
        
    }
    
    
    //Trim any empty Spaces
    public func trimWhiteSpaces(str: String) -> String{
        let trimmedStr = str.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr
        
    }
    
    
    
}
