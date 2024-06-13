//
//  CategorySelectionView.swift
//  Determit
//
//  Created by Blanca Tixi on 6/12/24.
//

import UIKit



protocol CategorySelectionDelegate: AnyObject{
    func didSelectCategory(_ category: String, _ sfImage: String)
}

class CategorySelectionView: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate{
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    weak var delegate: CategorySelectionDelegate?
    
    var selectedIndexPath: IndexPath?
    //Menu buttons title and image 2D Array
    let categoryButtonData = [
    ("Laptop","laptopcomputer"),
    ("Desktop","pc"),
    ("Tablet","ipad.landscape"),
    ("Mouse","computermouse"),
    ("Keyboard","keyboard"),
    ("Printer","printer"),
    ("Gaming Console","gamecontroller.fill"),
    ("Fax Machine","faxmachine"),
    ("Display","display"),
    ("tv","tv"),
    ("Server","xserve"),
    ("Server Rack","server.rack"),
    ("smartphone","iphone"),
    ("smart watch","applewatch"),
    ("headphones","headphones")
    ]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        //Register Cell file
        collectionView.register(UINib(nibName: "categoryCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        

        
        
    }
    
    
    

    func setupui(){
        
        
        
    }
    
    //MARK: -- Collection View Code
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        categoryButtonData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! categoryCell
        
        let menuItem = categoryButtonData[indexPath.row]
        
    
        cell.categoryImage.image = UIImage(systemName: menuItem.1)
        cell.categoryTitle.text = menuItem.0
        
        
        
        
    
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        // Update the previously selected cell
                if let previousIndexPath = selectedIndexPath {
                    if let previousCell = collectionView.cellForItem(at: previousIndexPath) as? categoryCell {
                        previousCell.updateLabelColor(isSelected: false)
                        previousCell.updateImageBorder(isSelected: false)
                    }
                }
                
                // Update the currently selected cell
                selectedIndexPath = indexPath
                if let currentCell = collectionView.cellForItem(at: indexPath) as? categoryCell {
                    currentCell.updateLabelColor(isSelected: true)
                    currentCell.updateImageBorder(isSelected: true)
                }
                
        
        
        
        
    }
    
    
    
    
    @IBAction func selectedCategoryButton(_ sender: Any) {
        
        
        guard let selectedIndexPath = selectedIndexPath else {
            Alert.showBasicAlert(on: self, with: "", message: "Please Select a Category")
                   return
               }

               let selectedCategory = categoryButtonData[selectedIndexPath.row].0
              let selectedSF = categoryButtonData[selectedIndexPath.row].1
               delegate?.didSelectCategory(selectedCategory,selectedSF)
               navigationController?.popViewController(animated: true)
           }
        
        
        
    
    
    

    

}
