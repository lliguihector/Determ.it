//
//  AssetVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/7/24.
//

import UIKit
import SwiftUI

class AssetVC: UIViewController {

    
    //Properties
    var assetTag = "Apple "
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Present Custome SwiftUI View in UIKit ViewController
        configureSwiftUI()
    }
    

    //MARK: -- Integrate Swift UI To UIKIt Method
   
    
    private func configureSwiftUI(){
        
        
        // Create a SwiftUI view and wrap it in a UIHostingController
        let assetRow = AssetRow(asset: APIAsset(_id: "001", assetTag: assetTag,deviceID: "77",serialNumber: "0")) // Provide appropriate asset tag
        
        
               let hostingController = UIHostingController(rootView: assetRow)
               
               // Set up constraints if needed Constaraints
               hostingController.view.translatesAutoresizingMaskIntoConstraints = false
               view.addSubview(hostingController.view)
               NSLayoutConstraint.activate([
                   hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
                   hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
               ])
     
        
    }

}
