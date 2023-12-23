//
//  CoreDataManager.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 12/19/23.
//

import Foundation
import CoreData
import UIKit


class CoreDataManager {
    
    //create an shared instance of the class Singleton instance
    static let shared = CoreDataManager()
    
    
    private init() {}
    
    //Properties
//    var viewContext: NSManagedObjectContext{
//
//        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    }
   
    var viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    

    
//MARK: - DEVICE
    
    
    //CREATE
    func CreateDevice( _ device: device){
        
        let newDevice = Device(context: self.viewContext)
        
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
        
        saveContext()
    }
    
    //READ_BY_ID
    //READ_ALL
    func readAllDevices() -> [Device] {
        
        let request:NSFetchRequest<Device> = Device.fetchRequest()
        
        do{
            let devices = try viewContext.fetch(request)
            return devices
        }catch{
            print("Error fetching data from context \(error)")
            return []
        }
       
        
    }
    
    //UPDATE
    //DELETE_BY_ID
    //DELTE_ALL
    func deleteAllDevices(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Device")

        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try viewContext.execute(deleteRequest)
            print("All Device data deleted successfully.")
        } catch {
            print("Error deleting Device data: \(error)")
        }
        
        
    }
    
    
   //MATK: - DEVICE QUERY
    
    
    


    //Save to CoreData
    func saveContext(){
        
        let context = viewContext
        do{
            
            try context.save()
        }catch{
            let nserror = error as NSError
           fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}





