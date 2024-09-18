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
    
    
    
    
    //Devices
    static let  GET_All_dEVICES = URL(string: "http://localhost:3000/devices")
    static let  GET_All_dEVICES_Heroku = URL(string: "https://determitapi-5d3a49176afa.herokuapp.com/devices")
    static let  POST_Device = URL(string: "http://localhost:3000/devices")
    
    //Assets
    static let GET_ALL_ASSETS = URL(string: "http://localhost:3000/assets")
    static let GET_ALL_ASSETS_Heroku = URL(string: "https://determitapi-5d3a49176afa.herokuapp.com/assets")
    static let POST_ASSET = URL(string: "http://localhost:3000/assets")
    
    //Tickets
    static let GET_ALL_TICKETS =  URL(string: "http://localhost:3000/ticket/tickets")
    
    static let CREATE_TICKET =  URL(string: "http://localhost:3000/ticket/ticket")
    
    
    
    //Testing Local Host lOGIN
    static let Authenticate_With_Back_End_3000 = "http://localhost:3000/api/users/authenticate"
    
    
    //Testing Horoku lOGIN
    static let Authenticate_With_Back_End_Heroku = "https://determitapi-5d3a49176afa.herokuapp.com/api/users/authenticate"
    
    
}
