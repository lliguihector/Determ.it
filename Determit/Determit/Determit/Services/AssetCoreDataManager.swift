//
//  AssetCoreDataManager.swift
//  Determit
//
//  Created by Blanca Tixi on 5/3/24.
//

import Foundation
import CoreData
import UIKit


class AssetCoreDataManager {
    
    //create an shared instance of the class Singleton instance
    static let shared = AssetCoreDataManager()
    
    
    private init() {}
    
    //Properties
//    var viewContext: NSManagedObjectContext{
//
//        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    }
   
    var viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    

    
//MARK: - ASSET METHODS
    
    
    //CREATE
    func CreateAsset( _ asset: APIAsset){
        
        let newAsset = Asset(context: self.viewContext)
        
        newAsset.assetTag = asset.assetTag
        newAsset.deviceID = asset.deviceID
        newAsset.serialNumber = asset.serialNumber
       
        
        saveContext()
    }
    
    //READ_BY_ID
    //READ_ALL
    func readAllAssets(with request: NSFetchRequest<Asset> = Asset.fetchRequest()) -> [Asset] {
        
        
        do{
            let assets = try viewContext.fetch(request)
            return assets
        }catch{
            print("Error fetching data from context \(error)")
            return []
        }
       
        
    }
    
    //UPDATE
    //DELETE_BY_ID
    //DELTE_ALL
    func deleteAllAssets(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Asset")

        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try viewContext.execute(deleteRequest)
            print("All Asset data deleted successfully.")
        } catch {
            print("Error deleting Asset data: \(error)")
        }
        
        
    }
    
    

    
    
    


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
    
    
    
    
    
    
    //MARK: - ASSET QUERY
    
    
    //Search by m
   
    func customeSearch(_ searchBarString: String) -> [Asset] {

   
           let request : NSFetchRequest<Asset> = Asset.fetchRequest()
   
           let predicate = NSPredicate(format: "modelName CONTAINS[cd] %@", searchBarString)
   
           request.predicate = predicate
   
           let sortDescriptor = NSSortDescriptor(key: "modelName", ascending: true)
   
   
           request.sortDescriptors = [sortDescriptor]
   
        
        return readAllAssets(with: request)
        

       }
       
    
    
    
    
    
    
    
}



