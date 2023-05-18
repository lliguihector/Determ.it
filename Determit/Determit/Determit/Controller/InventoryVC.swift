//
//  InventoryVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/5/23.
//

import Foundation
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
    

    var items: [item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        tableView.delegate = self
//        
//        
//        tableView.dataSource = self
        
        
        
        loadDummyData()
    }
    
    
    
    
    
    
    //MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Code
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath)
        
        
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        
        
        print("method was called")
        
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
