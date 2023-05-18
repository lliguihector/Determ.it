//
//  AccountVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 9/4/22.
//

import Foundation
import UIKit
import Firebase
import LocalAuthentication

class AccountVC: UITableViewController{
    
    
    //OUTLETS
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    

    @IBOutlet weak var profileInitialLabel: UILabel!
    @IBOutlet weak var profileCardView: UIView!
    
    var sectionTitles = ["Profile","Security","Notification Prefrence","Help & Policies"]
    

    override func viewDidLoad() {
        
        super.viewDidLoad()

        title = "Gorilla GYM"
        navigationItem.hidesBackButton = true
        //Style sign out button
        signOutButton.layer.cornerRadius = 10
        signOutButton.layer.borderWidth = 1
        signOutButton.layer.borderColor = CGColor(srgbRed:0/225, green: 0/225, blue: 0/225, alpha: 1)
        
        //Round of Profile Initials Label
        profileInitialLabel.layer.cornerRadius = profileInitialLabel.frame.size.height / 2
        profileInitialLabel.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        profileInitialLabel.layer.masksToBounds = true
        profileInitialLabel.layer.borderWidth = 1
    }
    

//MARK: - UITableView DataSource

override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     
     
     let view = UIView()
     view.frame = CGRect(x: 0, y: 0, width: 266, height: 30)
     view.backgroundColor = UIColor(red: 241/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0)
     
    let label = UILabel()
 
     label.textColor = UIColor(red: 77/255.0, green: 77/255.0, blue: 77/255.0, alpha: 1.0)
     label.font = UIFont.boldSystemFont(ofSize: 16)
     label.frame = CGRect(x: 10, y: 0, width: view.frame.size.width, height: 24)
     
     view.addSubview(label)

     label.text = self.sectionTitles[section]
     return view
     
     
 }
 
 override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
     return 30
 }

 override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
     return 0
 }

//MARK: - ACTIONS
    @IBAction func signOutButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Are you shure?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Not now", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Sign out", style: .default, handler: {
            action in
            self.signOutUser()
        }))
        self.present(alert, animated: true)
    }
    

func signOutUser(){

    do{
        try Auth.auth().signOut()
        //Takes you to the initial view controller
        navigationController?.popToRootViewController(animated: true)
    }catch let signOutError as NSError{
        print("Error signing out: %@", signOutError)
        
    }
   
}
    
}
