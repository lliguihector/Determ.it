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

enum ValidationType {
    case email
    case password
//    case username
//    case phoneNumber
    // Add more validation types as needed
}
