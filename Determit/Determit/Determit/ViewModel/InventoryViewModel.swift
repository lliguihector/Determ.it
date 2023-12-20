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
    
    
    
    //Core Data
    var devicesCoreData: [Device] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

   
    

    
    
    //MARK: - Methods
    
    
    //Function to GET data from API
    func fetchData(){
        deviceManager.getDevices(url: constant.GET_All_dEVICES, expecting: [device].self)
        {[weak self] result in
            
            switch result{
                
            case .success(let devices):
                DispatchQueue.main.async{
                    
                    //Store the API array Data in an array named devices
                    self?.devices = devices
            
                    
                    
                    //Delete All Data From Core Data
                    self?.deleteAllDevices()
                    //Write API Data to Core Data
                    self?.saveDevicesToCoreData()
                    
                    
                    self?.onDataUpdated?()
                    
                }
                
            case.failure(let error):


                self?.handleError(error)
                
                
            }
        }
    }
    
    
    
    
    
    
    private func  saveDevicesToCoreData(){
        
        for device in devices{
            
            
             let newDevice = Device(context: self.context)
            
            
            newDevice.deviceID = device._id
            newDevice.brand = device.brand
            newDevice.model = device.model
            newDevice.modelName = device.deviceName
            newDevice.serialNumber = device.serialNumber
            newDevice.storageCapacity = device.storage
            newDevice.memoryRam = device.memory
            newDevice.processor = device.processor
            newDevice.imageURL = device.imageURL
            newDevice.category = device.category
            newDevice.os = device.operatingSystem
            
            
            
            saveDevices(newDevice)
            
    
        }
    }
    
    
    
    private func updateCoreData(){
        
     var counter = 0
            
            for device in devices {
                
                counter += 1
                
                print("COUNTER >>>>>>\(counter)")
                
                
                       // Check if the device already exists in Core Data
                       if let existingDevice = devicesCoreData.first(where: { $0.deviceID == device._id }) {
                           // Update existing record
                           updateExistingDevice(existingDevice, with: device)
                       } else {
                           // Create a new record if it doesn't exist
                           createNewDevice(with: device)
                       }
                   }
                   
                   // Delete records that are in Core Data but not in the API response
                   deleteStaleRecords()
            
            
  
        
    }

    
    
    private func deleteAllDevices() {
           let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Device")

           let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

           do {
               try context.execute(deleteRequest)
               print("All Device data deleted successfully.")
           } catch {
               print("Error deleting Device data: \(error)")
           }
       }
   
    
    
    private func updateExistingDevice(_ existingDevice: Device, with newDevice: device){
        
        
        
        existingDevice.deviceID = newDevice._id
        existingDevice.brand = newDevice.brand
        existingDevice.model = newDevice.model
        existingDevice.modelName = newDevice.deviceName
        existingDevice.serialNumber = newDevice.serialNumber
        existingDevice.storageCapacity = newDevice.storage
        existingDevice.memoryRam = newDevice.memory
        existingDevice.processor = newDevice.processor
        existingDevice.imageURL = newDevice.imageURL
        existingDevice.category = newDevice.category
        existingDevice.os = newDevice.operatingSystem
        
        
        
        saveDevices(existingDevice)
        
    }
    
    
    
    private func createNewDevice(with device: device) {
           let newDevice = Device(context: context)
        
        
        
        newDevice.deviceID = device._id
        newDevice.brand = device.brand
        newDevice.model = device.model
        newDevice.modelName = device.deviceName
        newDevice.serialNumber = device.serialNumber
        newDevice.storageCapacity = device.storage
        newDevice.memoryRam = device.memory
        newDevice.processor = device.processor
        newDevice.imageURL = device.imageURL
        newDevice.category = device.category
        newDevice.os = device.operatingSystem
        
        
        
        
        
        
           saveDevices(newDevice)
       }
    
    
    
    private func deleteStaleRecords() {
        // Find records in Core Data that are not present in the API response
        let staleRecords = devicesCoreData.filter { coreDataDevice in
            !devices.contains { $0._id == coreDataDevice.deviceID }
        }
        
        // Delete stale records
        for staleRecord in staleRecords {
            context.delete(staleRecord)
        }
        
        // Save the changes
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        
    }

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
           DispatchQueue.main.async {
               self.onError?(errorMessage)
           }
    
    }
    
    
    
    //Save Data
    func saveDevices(_ device: Device){
        
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        
        
    }
    
//READ From Core Data
    func loadDevices() {
        let request: NSFetchRequest<Device> = Device.fetchRequest()
        
        do {
            devicesCoreData = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    
    
    
    //Core Data Search
    
    func searchByTitle(_ searchBarString: String){
        
        
        
        let request : NSFetchRequest<Device> = Device.fetchRequest()


        let predicate = NSPredicate(format: "modelName CONTAINS[cd] %@", searchBarString)

        request.predicate = predicate

        let sortDescriptor = NSSortDescriptor(key: "modelName", ascending: true)


        request.sortDescriptors = [sortDescriptor]

        do{
            devicesCoreData = try context.fetch(request)

        }catch{
            print("Error fetching data from context \(error)")
        }
        
        
        
        
        
    }
    
    
    
    
}
        
        
        
