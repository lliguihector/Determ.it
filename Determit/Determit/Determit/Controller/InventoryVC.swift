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

class InventoryVC: UITableViewController,Loadable, UISearchBarDelegate{

    //MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)

    
    //Instantiate ViewModelS
    var ViewModel = InventoryViewModel()
    
    
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureUI()
        
        //Load Data from API and load it to CoreData
        bindViewModel()
        self.ViewModel.fetchData()
    
        //load current CoreData array
        self.ViewModel.readAllDevicesFromCoreData()
        
        
        
        //        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    
    //MARK: - ACTIONS
    @IBAction func addNewItem(_ sender: Any) {

            let addNewDeviceVC = storyboard?.instantiateViewController(withIdentifier: "AddNewDeviceVC") as! AddNewDeviceVC
            addNewDeviceVC.delegate = self
            navigationController?.pushViewController(addNewDeviceVC, animated: true)

    }
    
    
    
    //MARK: - View Model Methods and binding
    @IBAction func loadData(_ sender: Any) {
        bindViewModel()
        //Load Devices from viewModel
        ViewModel.fetchData()
        
    }
    
    func bindViewModel(){
        
        ViewModel.onError = { [weak self] errorMessage in
            
            
            self?.showLoadingView()
            
            Alert.showBasicAlert(on: self!, with: "Error", message: errorMessage)
            
            self?.hideLoadingView()
        }
        
        
        ViewModel.onDataUpdated = { [weak self] in
            
            self?.showLoadingView()
            Alert.showBasicAlert(on: self!, with: "Success ", message: "Data loaded successfully")
        
            
            //Read Core data and repopulate table view
            self?.ViewModel.readAllDevicesFromCoreData()
            
           
             
                self?.tableView.reloadData()
            
            self?.hideLoadingView()
            
        }
        
        
        
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
    
    
    DispatchQueue.main.async{ [self] in
        ViewModel.fetchData()
    }
    
    
    print("SLIDE VIEW WAS SLIDEDED>>>>")
    
    DispatchQueue.main.async{
        self.tableView.refreshControl?.endRefreshing()
    }
      
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
        return ViewModel.devicesCoreData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath) as! InventoryTableViewCell
    
        let device = ViewModel.devicesCoreData[indexPath.row]
        
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

            destinationVC.selectedDevice = ViewModel.devicesCoreData[indexPath.row]
            
        }
            print("DestinationVC type: \(type(of: destinationVC))")

        }

    }
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
            
            ViewModel.readAllDevicesFromCoreData()
              tableView.reloadData()
        }else{
            
           // reload table view data with queried search Text
            print("Searching for: \(searchText)")
            
            
            
            
            ViewModel.queryDeviceData(searchText)

            
            tableView.reloadData()
            
            
  
        }
       
    }

}




//MARK: - AddNewDeviceVCDelegate
extension InventoryVC: addNewDeviceVCDelegate {
    
    func reloadData() {
        
        
        refreshData()
        tableView.reloadData()
        
    }
    
    

    
}

