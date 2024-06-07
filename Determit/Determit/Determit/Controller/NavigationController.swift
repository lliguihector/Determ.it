//
//  HomeVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 9/4/22.
//

import Foundation
import UIKit

class NavigationController:  UINavigationController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      

        navigationItem.hidesBackButton = true
        navigationItem.backButtonTitle = ""
        
        // Make navigation bar transparent
           navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
           navigationController?.navigationBar.shadowImage = UIImage()
           navigationController?.navigationBar.isTranslucent = true
           navigationController?.view.backgroundColor = .clear
    }

    
    
    
    
    
    
    
    
    
    
    
}
