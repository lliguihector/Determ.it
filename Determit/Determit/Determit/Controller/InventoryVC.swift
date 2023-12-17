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
 
    
    
    //MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)
    var devices: [Device] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
       
 

        configureUI()
       
        loadDevices()
        
        //        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    
    //MARK: - ACTIONS
    @IBAction func addNewItem(_ sender: Any) {

            let addNewDeviceVC = storyboard?.instantiateViewController(withIdentifier: "AddNewDeviceVC") as! AddNewDeviceVC
            addNewDeviceVC.delegate = self
            navigationController?.pushViewController(addNewDeviceVC, animated: true)

    }
    
   //MARK: - UI Configuration
    
    func configureUI(){
        registerNib()
        refreshControlSetUp()
        configureSearchCotroller()
    }

    
func registerNib(){
    tableView.register(UINib(nibName: "InventoryTableViewCell", bundle: nil), forCellReuseIdentifier: "InventoryCell")
    }
    
func refreshControlSetUp(){
        //Add Refresh Controll to UIScrollView object
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action:
                                           #selector(refreshData),
                                           for: .valueChanged)
    }
    
    //MARK: - Data Refresh
@objc func refreshData(){
        // For example, you might reload your data from a server or fetch new data snipit: data = fetchDataFromServer()
           loadDevices()
           // End refreshing
       self.tableView.refreshControl?.endRefreshing()
    }
    
    

    
    //MARK - Search Controller
    func configureSearchCotroller(){
        
        //Search Bar Controller
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    
    //Activated when the scrollview isdraged
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
    
    //MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath) as! InventoryTableViewCell
    
    
        
        let device = devices[indexPath.row]
        
        
        // Safely unwrap the optional value and provide a default value if it's nil
        let modelName = device.modelName ?? "No value"
        let model = device.model ?? "No value"
        
        cell.itemName.text =  "\(modelName) \(model)"
        cell.ManufactureBrandLabel.text = device.brand
        cell.categoryLabel.text = device.category
        cell.serialNumberLabel.text = device.serialNumber
     
        return cell
        
    }
    
    
    
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
           
        self.performSegue(withIdentifier: "deviceDetails", sender: self)
        
        
        print([indexPath.row])
              
    }
    
    
//Performe before segue is display
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){


        
        if segue.identifier == "deviceDetails"{
            
            let destinationVC = segue.destination as! DeviceDetailsVC
            if let indexPath = tableView.indexPathForSelectedRow{

            destinationVC.selectedDevice = devices[indexPath.row]
            
        }
       



            print("DestinationVC type: \(type(of: destinationVC))")

        }

    }
}


//MARK: - UISearchBarDelegate
extension InventoryVC: UISearchBarDelegate{
    
    
}


//MARK: - UISearchResultUpdating
extension InventoryVC: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        //Check searchBar.text If it is nill the function does nothing
        guard let searchText = searchController.searchBar.text else{
            return
        }
        
        //If the searchText is empty
        if searchText.isEmpty{
            //Load Items from Core data If the Text In the search Bar is empty
            print("Empty Search Field Reloading Data...")
            loadDevices()
        }else{
            //reload table view data with queried search Text
            print("Searching for: \(searchText)")
            let request : NSFetchRequest<Device> = Device.fetchRequest()
            
            
            let predicate = NSPredicate(format: "modelName CONTAINS[cd] %@", searchText)
            
            request.predicate = predicate
            
            let sortDescriptor = NSSortDescriptor(key: "modelName", ascending: true)
            
            
            request.sortDescriptors = [sortDescriptor]
            
            do{
                devices = try context.fetch(request)
                
            }catch{
                print("Error fetching data from context \(error)")
            }
            
            
            tableView.reloadData()
            
            
  
        }
       
    }

}




//MARK: - AddNewDeviceVCDelegate
extension InventoryVC: addNewDeviceVCDelegate {
    
    func reloadData() {
        loadDevices()
    }
    
    

    
}

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
