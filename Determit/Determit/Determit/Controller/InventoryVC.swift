//
//  InventoryVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/5/23.
//

import Foundation
import CoreData
import AVFoundation
import UIKit

class InventoryVC: UITableViewController{

    let searchController = UISearchController(searchResultsController: nil)
  
    
    var devices: [Device] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //Search Bar Controller
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        
        //Register nib
        tableView.register(UINib(nibName: "InventoryTableViewCell", bundle: nil), forCellReuseIdentifier: "InventoryCell")

        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        loadDummyData()
    }
    
   
    
    
    
    //MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath) as! InventoryTableViewCell
        
        
        let device = devices[indexPath.row]
        cell.itemName.text = device.model
        cell.itemAccetTag.text = device.processor
        cell.itemLocation.text = device.brand
        cell.itemSerialNumber.text = device.serialNumber

        return cell
        
    }

}

//MARK: - Helper Methods
extension InventoryVC {
    
    func loadDummyData(){
        
        
        
        let newDevice = Device(context: self.context)
    
        newDevice.model = "Mac Book Pro 13-inch"
        newDevice.serialNumber = "LR089988"
        newDevice.brand = "Apple"
        newDevice.processor = "intel Core i13-6100U 2.30GHz"
        newDevice.deviceID = "From mongo DB"
        newDevice.imageURL = "http://www.whatever.com"
        newDevice.memoryRam = 8
        newDevice.deviceID = "001"
        
        self.devices.append(newDevice)
        self.saveDevices()
        
        
        
   
    }

}


//MARK: - UISearchController Delegate
extension InventoryVC: UISearchControllerDelegate{
    
    
}

//MARK: UISearch Redult Updating
extension InventoryVC: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        //Check searchBar.text If it is nill the function does nothing
        guard let searchText = searchController.searchBar.text else{
            return
        }
        
        //If the searchText is empty
        if searchText.isEmpty{
            //Load Items from Core data If the Text In the search Bar is empty
            print("Loading Inventory array and reload data in table view")
        }else{
            //reload table view data with queried search Text
            print(searchText)
  
        }

    }

}

//MARK: - QR BarCode Method


//MARK: - Core Data Manipulation Methods
extension InventoryVC {
    
   
    //READ Data
    func loadDevices(){
        
        let request: NSFetchRequest<Device> = Device.fetchRequest()
        
        do{
            devices = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
        
        
        self.tableView.reloadData()
        
        
    }
    
    
    
    
    //Save Data
    func saveDevices(){
        
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        
        
        
        self.tableView.reloadData()
    }
    
    
    
}
