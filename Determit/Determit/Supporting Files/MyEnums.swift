//
//  MyEnums.swift
//  Determit
//
//  Created by Blanca Tixi on 5/4/24.
//

import Foundation

enum APIErrors: Error{
    case requestFailed
    case responseFailed
    case jsonDecodingFailed
    case invalidURL
    case invalidImageURL
    
}


//For Validating user Login and Registration Form
enum validationLoginType{
    case email
    case password
    case confirmPassword
}




//For Validating new Device Form
enum ValidationNewDeviceType {
    case brand
    case name
}
