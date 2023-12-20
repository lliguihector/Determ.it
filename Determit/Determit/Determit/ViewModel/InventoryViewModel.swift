//
//  InventoryViewModel.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 12/17/23.
//

import Foundation



class InventoryViewModel{
    
    
    private let deviceManager = DeviceManagerAPI()
    
    
    
    
    //MARK: - Properties
    
    //Create an empty array to hold the values loaded from api call
    var devices:[device] = []
    
    
    //This closure willbe called when data is succesfull update.
    var onError: ((String) -> Void)?
    
    
    //This error closure is used to handle and display errors
    var onDataUpdated: (() -> Void)?
    
    
    
    //Function to GET data from API
    func fetchData(){
        
        
        
        deviceManager.getDevices(url: constant.GET_All_dEVICES, expecting: [device].self)
        {[weak self] result in
            
            switch result{
                
            case .success(let devices):
                DispatchQueue.main.async{
                    self?.devices = devices
                    print("Success here is the API data that was Fetched: ")
                    print(self!.devices)
                    
                    
                    
                    self?.onDataUpdated?()
                    
                }
                
            case.failure(let error):


                self?.handleError(error)
                
                
            }
        }
    }

private func handleError(_ error: APIErrors){
    
    let errorMessage: String
           switch error {
           case .requestFailed:
               errorMessage = "Request Failed"
           case .responseFailed:
               errorMessage = "Response Failed"
           case .jsonDecodingFailed:
               errorMessage = "JSON Decoding Failed"
           case .invalidURL:
               errorMessage = "Invalid URL"
           case .invalidImageURL:
               errorMessage = "Invalid Image URL"
           }
           DispatchQueue.main.async {
               self.onError?(errorMessage)
           }
    
    }
    
    

    
    
    
    
    
    
    
}
        
        
        
