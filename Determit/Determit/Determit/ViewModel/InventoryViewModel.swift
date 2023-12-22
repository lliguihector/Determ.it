//
//  InventoryViewModel.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 12/17/23.
//

import Foundation
import CoreData
import UIKit



class InventoryViewModel{
    
  
    //MARK: - Properties

    
    //API
    private let deviceManager = DeviceManagerAPI()
    //Create an empty array to hold the values loaded from api call
    var devices:[device] = []
    //This closure willbe called when data is succesfull update.
    var onError: ((String) -> Void)?
    //This error closure is used to handle and display errors
    var onDataUpdated: (() -> Void)?
    
    
    
    //Create an empty array to hold Core Data Device entety
    var devicesCoreData: [Device] = []
    
    let coreDataManager = CoreDataManager.shared

   


    
    
    //MARK: - Methods
    
    
    //Function to GET data from API
    func fetchData(){
        deviceManager.getDevices(url: constant.GET_All_dEVICES, expecting: [device].self)
        {[weak self] result in
            
            switch result{
                
            case .success(let devices):
                
                
                
//                DispatchQueue.main.async{
                    
                //Store the API array Data in an array named devices
                self?.devices = devices
                //Delete All Data From Core Data
                self?.coreDataManager.deleteAllDevices()
                //Write API Data to Core Data
                self?.saveDevicesToCoreData()
                
                //The UI Update should happen in the main thread
                
                DispatchQueue.main.async{
                    self?.onDataUpdated?()
                }
                
            case.failure(let error):
                self?.handleError(error)
            }
        }
    }
    
    
    
 //MARK: -  CoreData Helper Methods
    
    //API Decoded JSON Array Objects is stored in CoreData Device entety
    private func  saveDevicesToCoreData(){
        for device in devices{
            let newDevice = device
            coreDataManager.CreateDevice(newDevice)
        }
    }
    
    //load array of Device entety from core data to empty array
    public func readAllDevicesFromCoreData(){
        devicesCoreData = coreDataManager.readAllDevices()
    }
    
    
    
    
//Handel API call errors
private func handleError(_ error: APIErrors){
    
    let errorMessage: String
           switch error {
           case .requestFailed:
               errorMessage = "Unable to establish a network connection with the server. Please check your internet connection and try again later."
           case .responseFailed:
               errorMessage = "Response Failed"
           case .jsonDecodingFailed:
               errorMessage = "JSON Decoding Failed"
           case .invalidURL:
               errorMessage = "Invalid URL"
           case .invalidImageURL:
               errorMessage = "Invalid Image URL"
           }
    
    //Update the UI on Main thread
           DispatchQueue.main.async {
               self.onError?(errorMessage)
           }
    
    }
    
    

    
}
        
        
        
