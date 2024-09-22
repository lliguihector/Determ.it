//
//  EmployeeView.swift
//  Determit
//
//  Created by Blanca Tixi on 6/6/24.
//

import UIKit

class EmployeeView: UIViewController {

  //UI Components
    
    let profileCV = DetermitProfileCard()
    let myDevicesLabel = DetermitSubLabel(title: "My Devices",fontName: "Open Sans")
    let deviceCV = DetermitDeviceCard()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        
        
        
        
      
        view.backgroundColor =   UIColor { traits in
            return traits.userInterfaceStyle == .dark ? UIColor.darkGray: .secondarySystemBackground
        }


        configureProfileCardView()
        configureMyListOfDevicesLabel()
        configureDeviceCardView()
        
    }
    
   private func configureProfileCardView(){
        // Set translatesAutoresizingMaskIntoConstraints to false
        profileCV.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(profileCV)
        NSLayoutConstraint.activate([
        
            profileCV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            profileCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            profileCV.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            profileCV.heightAnchor.constraint(equalToConstant: 120) // Adjust as needed
        ])
    }
    
    
    
    private func configureMyListOfDevicesLabel(){
        
        
        view.addSubview(myDevicesLabel)
        
 
        
        NSLayoutConstraint.activate([
        
            myDevicesLabel.topAnchor.constraint(equalTo: profileCV.bottomAnchor, constant: 1),
            myDevicesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            myDevicesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            myDevicesLabel.heightAnchor.constraint(equalToConstant: 40) // Adjust as needed
        ])
        
   
    }
    
    private func configureDeviceCardView(){
        deviceCV.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(deviceCV)
        
        NSLayoutConstraint.activate([
        
            deviceCV.topAnchor.constraint(equalTo: myDevicesLabel.bottomAnchor, constant: 1),
            deviceCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            deviceCV.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            deviceCV.heightAnchor.constraint(equalToConstant: 400) // Adjust as needed
            
        ])
        // Ensure the deviceCV is responsive by setting up top and bottom constraints
          let bottomConstraint = deviceCV.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
          bottomConstraint.priority = UILayoutPriority(rawValue: 999) // Give it a slightly lower priority
          bottomConstraint.isActive = true
        
    }
        

    

    

}
