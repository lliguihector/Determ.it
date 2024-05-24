//
//  HomeMenuVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/26/23.
//

import UIKit

class AdminView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    

    let menuItems = ["Accets","IT Requests","Technicians","Clients"]
    let sfSymbolTitle = ["laptopcomputer.and.iphone","ticket","person.text.rectangle","person.3.sequence"]
    
    //Company Logo Outlit
    @IBOutlet weak var companyLogo: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        collectionView.register(UINib(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        
        
        setUpCompanyImageUI()
        
            
    }
    
    
    
    
    
    
    func setUpCompanyImageUI(){
        
       
        // Apply rounded corners
        companyLogo.layer.cornerRadius = companyLogo.frame.size.width / 2
              
              // Apply border
        companyLogo.layer.borderWidth = 0.5
        companyLogo.layer.borderColor = UIColor.lightGray.cgColor
        
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
            self.performSegue(withIdentifier: "menuToinHouseInventory", sender: self)
            
        }else if indexPath.row == 1{
            self.performSegue(withIdentifier: "menuToAssetView", sender: self)
            
            print("Ticket")
        }else if indexPath.row == 3 {
            
            self.performSegue(withIdentifier: "toUsers", sender: self)
            print("Users")
        }
            else{
                
                print("Other was pressed")
            }
            
        }


}

    
    
    
    
    
    
    
    





//MARK: - Collection View Delegate
