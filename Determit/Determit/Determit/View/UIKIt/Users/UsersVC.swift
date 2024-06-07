//
//  UsersVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/27/23.
//

import UIKit

class UsersVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    
 
    @IBOutlet weak var tableView: UITableView!
    
    var users = ["Hector Lliguichuzhca","Odalis Tixi","Hector Lliguichuzhca","Odalis Tixi","Hector Lliguichuzhca","Odalis Tixi","Hector Lliguichuzhca","Odalis Tixi","Hector Lliguichuzhca","Odalis Tixi","Hector Lliguichuzhca","Odalis Tixi"]

    override func viewDidLoad() {
        super.viewDidLoad()

     
        
        tableView.delegate = self
        tableView.dataSource = self
        //Register NIB
        tableView.register(UINib(nibName: "usersTableViewCell", bundle: nil), forCellReuseIdentifier: "userCell")
        
        
    }
    
    //MARK: - Table View Data Source
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! usersTableViewCell
    
    
        
        let user = users[indexPath.row]
        
        
        cell.userName.text = user
        
        
        return cell
    }
    
    
    
    
    


}
