//
//  Organization.swift
//  Determit
//
//  Created by Blanca Tixi on 9/7/24.
//

import Foundation
struct Organization: Codable{
    
    
    let name: String
    let phoneNumber: String
    let email: String
    let companyLogoUrl: String
    let cordinates: [Double]//Store Cordinates
    let address: Address
    
    
    
    
    
    struct Address: Codable{
        let city: String
        let state: String
        let zipcCode: String
        let country: String
        
    }
    
    
}
