//
//  constant.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 1/16/23.
//

import Foundation
struct constant{
    
    
    static let loadingViewTag = 1234
    
    
    
    
    //MARK: - API URL End Point CallS
    static let  GET_All_dEVICES = URL(string: "http://localhost:3000/devices")
    static let  POST_Device = URL(string: "http://localhost:3000/devices")
    
    static let  GET_All_ASSETS = URL(string: "http://localhost:3000/assets")
    static let  POST_Asset = URL(string: "http://localhost:3000/assets")
}
