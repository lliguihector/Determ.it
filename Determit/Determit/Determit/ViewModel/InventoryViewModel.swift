//
//  InventoryViewModel.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 12/17/23.
//

import Foundation
import CoreData
import UIKit


protocol ValidationDelegate: AnyObject {
    func validationDidFinish(isValid: Bool, errorMessage: String?)
}

class InventoryViewModel{
    
  
    //MARK: - Properties

    
    //API
    private let deviceManager = DeviceManagerAPI()
    //Create an empty array to hold the values loaded from api call
    var devices:[APIDevice] = []
    //This closure willbe called when data is succesfull update.
    var onError: ((String) -> Void)?
    var onSuccess:((String) ->Void)?
    //This error closure is used to handle and display errors
    var onDataUpdated: (() -> Void)?
    //Create an empty array to hold Core Data Device entety
    var devicesCoreData: [Device] = []
    let coreDataManager = CoreDataManager.shared
    
    
    weak var delegate: ValidationDelegate?
    var validationType: ValidationType = .email

    //Form Validation
    private let validation = Validation()
    
    var updateValidationStatus: ((Bool) -> Void)?
    var updateErrorMessage: ((String?) -> Void)?

    //MARK: - API METHODS
    //CREATE
    func createData(_ newDevice: APIDevice){
        deviceManager.createDevice(url: constant.POST_Device, deviceData: newDevice) { [weak self] result in
            switch result{
            case .success(let apiStringResponse):
                print("\(apiStringResponse)")
                
    
                self?.apiStringResponse(apiStringResponse)
                
                
            case.failure(let error):
                
                self?.handleError(error)
            }
        }
    }
    
    
    //READ_ALL
    func fetchData(){
        deviceManager.getDevices(url: constant.GET_All_dEVICES, expecting: [APIDevice].self)
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
    
    
    
 //MARK: -  CoreData METHODS
    
    
    //CREATE
    private func  saveDevicesToCoreData(){
        for device in devices{
            let newDevice = device
            coreDataManager.CreateDevice(newDevice)
        }
    }
    
    //READ_ALL
    public func readAllDevicesFromCoreData(){
        devicesCoreData = coreDataManager.readAllDevices()
    }
    
    
    
    //Custome Search
    
    public func queryDeviceData(_ searcBarString: String){
        
        
    
        
        devicesCoreData = coreDataManager.customeSearch(searcBarString)
        
        
   
    }
    
    
//MARK: - Helper Methods
private func handleError(_ error: APIErrors){
    
    let errorMessage: String
           switch error {
           case .requestFailed:
               errorMessage = "Unable to connect to the server."
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
    
    private func apiStringResponse(_ apiStringResponse: String){
        
        
        let apiMessage = apiStringResponse
        
     
        
        
        
        //Update the UI on Main thread
               DispatchQueue.main.async {
                  
                   self.onSuccess?(apiMessage)
                   
                   
               }
    }
    
    
    
    //MARK: -- Form validation
    
    
    var isValid: Bool = false{
        didSet{
            updateValidationStatus?(isValid)
        }
    }
    
    var errorMessage: String? {
         didSet {
             updateErrorMessage?(errorMessage)
         }
     }
    
    
   

    func validate(input: String?, for type: ValidationType){
        
        
            guard let input = input, !input.isEmpty else {
              isValid = false
                errorMessage = "Input cannot be empty"
                delegate?.validationDidFinish(isValid: false,errorMessage: "Input cannot be empty")
                return
            }
        
        
        let isValid: Bool
        let errorMessage: String?
        
        switch type {
                case .email:
            
            
                    isValid =  validation.validateEmail(email: input)
            
                    errorMessage = isValid ? nil : "Invalid email format"
            
                  
                case .password:
                   
            isValid = validation.validatePassword(password: input)
            errorMessage = isValid ? nil : "Password must be at least 6 characters long, with at least one letter and one number"
            
            // Add more cases for other validation types if needed
        }
        
        delegate?.validationDidFinish(isValid: isValid, errorMessage: errorMessage)

    }

    
    
    
    
    
}
        
        
        
