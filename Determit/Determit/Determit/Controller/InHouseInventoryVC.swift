//
//  inHouseInventoryVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/26/23.
//

import UIKit

class InHouseInventoryVC: UITableViewController{
 

    
    var testing = ["iPad Pro","MacBook Air","Mac Book Pro"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        tableView.dataSource = self
//        tableView.delegate = self
        //Regester NIB
        
       tableView.register(UINib(nibName: "inHouseInventoryTableViewCell", bundle: nil), forCellReuseIdentifier: "inHouseInventoryCell")
        

        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testing.count
    }
    
   
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "inHouseInventoryCell", for: indexPath) as! inHouseInventoryTableViewCell
        
        let hardware = testing[indexPath.row]
        cell.assetTag.text = hardware
   
        return cell
    }
  
}
