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
    
    //create an shared instance of the classs
    static let shared = CoreDataManager()
    
    
    private init() {}
    
    
    
    
    
    
    
    
    
    //Properties
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var devices: [Device] = []
    

    
    
    
    //read data
    func loadDeviceData(){
        
        let request: NSFetchRequest<Device> = Device.fetchRequest()
        
        do{
            devices = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
        
        //self.tableView.reloadData()
    }
    
    
    
    
    //Save Data
    func saveDevices(){
        
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        
        
        
        //self.tableView.reloadData()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}





