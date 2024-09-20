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
    let deviceCV = DetermitDeviceCard()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .secondarySystemBackground

        configureProfileCardView()
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
    
    private func configureDeviceCardView(){
        deviceCV.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(deviceCV)
        
        NSLayoutConstraint.activate([
        
            deviceCV.topAnchor.constraint(equalTo: profileCV.bottomAnchor, constant: 20),
            deviceCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            deviceCV.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            deviceCV.heightAnchor.constraint(equalToConstant: 400) // Adjust as needed
        ])
        
        
    }
        

    

    

}
