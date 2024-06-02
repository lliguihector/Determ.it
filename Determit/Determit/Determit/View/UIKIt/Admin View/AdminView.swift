//
//  HomeMenuVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/26/23.
//

import UIKit

class AdminView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    

    let menuItems = ["Devices","Assets","Service Requests","Technicians","Clients"]
    let sfSymbolTitle = ["laptopcomputer.and.iphone","qrcode.viewfinder","wrench.and.screwdriver.fill","person.fill","person.3.fill"]
    
    //Company Logo Outlit
    @IBOutlet weak var companyLogo: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupUI()

    }
    
    
    
    
    
    
    func setupUI(){
        
        // Register Menu Cell Nib File
        collectionView.register(UINib(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        
        // Set Up company Profile Image View
        companyLogo.layer.cornerRadius = companyLogo.frame.size.width / 2
        companyLogo.layer.borderWidth = 0.5
        companyLogo.layer.borderColor = UIColor.lightGray.cgColor
        
        // Initialize the custom view
             let adminMenuContainerView = AdminMenuContainerView()
             adminMenuContainerView.translatesAutoresizingMaskIntoConstraints = false
             
             // Add the custom view to the view controller's view hierarchy
             view.addSubview(adminMenuContainerView)
             
             // Set up Auto Layout constraints for the custom view
             NSLayoutConstraint.activate([
//                 adminMenuContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                 adminMenuContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                 adminMenuContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//                 adminMenuContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                 adminMenuContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                 adminMenuContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                 adminMenuContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                 adminMenuContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 242),
//                 adminMenuContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5) // Bottom half of the screen
                 
                 
                 adminMenuContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
             ])
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCollectionViewCell
        
        
        let sfTitle  = sfSymbolTitle[indexPath.row]
        cell.menuTitle.text = menuItems[indexPath.item]
        cell.menuImage.image = UIImage(systemName: sfTitle)
      
             return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        if indexPath.row == 0 {
            print("Device")
            self.performSegue(withIdentifier: "adminToDevices", sender: self)
            
        }else if indexPath.row == 1{
            print("Assets")
            self.performSegue(withIdentifier: "menuToinHouseInventory", sender: self)
            print("Tickets")
        }else if indexPath.row == 2{
            self.performSegue(withIdentifier: "menuToTicketView", sender: self)
            
        }else if indexPath.row == 3 {
            
          
            print("Technicians")
        }else if indexPath.row == 4 {
            
            self.performSegue(withIdentifier: "toUsers", sender: self)
            print("Users")
        }
            else{
                
                print("Other was pressed")
            }
            
        }


}

    
    
    
    
    
    
    
    





//MARK: - Collection View Delegate
