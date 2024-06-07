//
//  AdminMenuContainerView.swift
//  Determit
//
//  Created by Blanca Tixi on 5/29/24.
//

import UIKit
import SwiftUI


class AdminMenuContainerView: UIView{
    
    
    //Allows to wrap SwiftUI View so it can be managed by UIKIit
    
    private let hostingController: UIHostingController<AdminMenuList>
    
    
    override init(frame: CGRect){
     //Initialize the hosting controller with the SwiftUI view
        
        hostingController = UIHostingController(rootView: AdminMenuList())
        
        super.init(frame: frame)
        
        //Set up background color for the entire view
//        self.backgroundColor = UIColor.systemBlue   //Set your desired Background color here
        
        
        //Add the hosting controlller's view as a subview
        addSubview(hostingController.view)
        
        //Set up Auto Layout constraints for the hosting controller's view
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   hostingController.view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                   hostingController.view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                   hostingController.view.topAnchor.constraint(equalTo: self.topAnchor),
                   hostingController.view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
               ])
        
        
        
    }
    
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
}
