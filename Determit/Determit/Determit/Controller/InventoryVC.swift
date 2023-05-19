//
//  InventoryVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/5/23.
//

import Foundation
import AVFoundation
import UIKit

//Sample Item class

class item{
    var id: String
    var name: String

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
class InventoryVC: UITableViewController{

    let searchController = UISearchController(searchResultsController: nil)
    var items: [item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
       //Search Bar Controller
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        
        //Register nib
        tableView.register(UINib(nibName: "InventoryTableViewCell", bundle: nil), forCellReuseIdentifier: "InventoryCell")

        
        loadDummyData()
    }
    
   
    
    
    
    //MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath) as! InventoryTableViewCell
        let item = items[indexPath.row]
        cell.itemName.text = item.name

        return cell
        
    }

}

//MARK: - Helper Methods
extension InventoryVC {
    
    func loadDummyData(){
        
        let item0 = item(id: "001", name: "Mac Book Air")
        let item1 = item(id: "002", name: "Mac Book Pro")
        let item2 = item(id: "003", name: "Mac Book Mini")
        let item3 = item(id: "004", name: "iMac")
        let item4 = item(id: "005", name: "ipad pro")
        let item5 = item(id: "006", name: "ipad")
        let item6 = item(id: "007", name: "Cannon printer")
        let item7 = item(id: "008", name: "smart board")
        let item8 = item(id: "009", name: "Samsung tv")
        let item9 = item(id: "010", name: "Ipod touch")
        let item10 = item(id: "011", name: "Dell Laptop")
        let item11 = item(id: "012", name: "Crom laptop")
        let item12 = item(id: "013", name: "HDD")
        let item13 = item(id: "014", name: "label printer")
        let item14 = item(id: "015", name: "Card Reader")
        let item15 = item(id: "016", name: "Smart table")
        items += [item0,item1,item2,item3,item4,item5,item6,item7,item8,item9,item10,item11,item12,item13,item14,item15]

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
