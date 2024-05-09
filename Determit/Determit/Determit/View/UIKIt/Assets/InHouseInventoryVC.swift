//
//  inHouseInventoryVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/26/23.
//


import Foundation
import AVFoundation
import UIKit
import CoreData



class InHouseInventoryVC: UITableViewController ,Loadable,UISearchBarDelegate{
 

let searchController = UISearchController(searchResultsController: nil)
    
    
    
    
    //Instantiate ViewModel
    var ViewModel = AssetViewModel()
    
    
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         configureUI()

 
        
        //Load Data from API and load it to CoreData
        bindViewModel()
        self.ViewModel.fetchData()
    
        //load current CoreData array
        self.ViewModel.readAllAssetsFromCoreData()
        
    }

    
    //MARK: - Configure UI
    
    private func configureUI(){
        registerNib()
        refreshControlSetUp()
        configureSearchCotroller()
    }
    
    //Registers the custome nib files
    private func registerNib(){
        tableView.register(UINib(nibName: "inHouseInventoryTableViewCell", bundle: nil), forCellReuseIdentifier: "inHouseInventoryCell")
    }
    
    //Adds a Refresh Controller to UIScrollView
    private func refreshControlSetUp(){
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    //Function that refreshes the data on the UI by fetching the API
    @objc func refreshData(){
        DispatchQueue.main.async{ [self] in
            ViewModel.fetchData()
        }
        
        DispatchQueue.main.async{
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    
    func configureSearchCotroller(){
        //Search Bar Controller
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    

    
    
    //MARK: - Bind View Model
    
    @IBAction func loadData(_ sender: Any) {
        bindViewModel()
        //Load Assets from viewModel
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
            self?.ViewModel.readAllAssetsFromCoreData()
            
           
             
                self?.tableView.reloadData()
            
            self?.hideLoadingView()
            
        }
        
        
        
    }
    

    
    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewModel.assetsCoreData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "inHouseInventoryCell", for: indexPath) as! inHouseInventoryTableViewCell
        
       
        let asset = ViewModel.assetsCoreData[indexPath.row]
        
        
             
        
        
        cell.assetTag.text = asset.assetTag
        
   
        return cell
    }
  
}


//MARK: - UITableViewDelegate    (This Delegate Methods actions are made when a table row is selected )
//override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//    self.performSegue(withIdentifier: "deviceDetails", sender: self)
//    print([indexPath.row])
//}
//
////Performe before segue is display
//override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//
//    if segue.identifier == "deviceDetails"{
//
//        let destinationVC = segue.destination as! DeviceDetailsVC
//        if let indexPath = tableView.indexPathForSelectedRow{
//
//        destinationVC.selectedDevice = ViewModel.devicesCoreData[indexPath.row]
//
//    }
//        print("DestinationVC type: \(type(of: destinationVC))")
//
//    }
//
//}
//}
//MARK: UISearchResultUpdating

extension InHouseInventoryVC: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        
        //Check searchBar.text If it is nill the function does nothing
        guard let searchText = searchController.searchBar.text else{
            return
        }
        
        //If the searchText is empty
        if searchText.isEmpty{
            //Load Items from Core data If the Text In the search Bar is empty
            print("Empty Search Field Reloading Data...")
            
            ViewModel.readAllAssetsFromCoreData()
            tableView.reloadData()
        }else{
            
            // reload table view data with queried search Text
            print("Searching for: \(searchText)")
            
            
            
            
            ViewModel.queryAssetData(searchText)
            
            
            tableView.reloadData()
            
        }
        
        
        
        
    }
    
    
}
