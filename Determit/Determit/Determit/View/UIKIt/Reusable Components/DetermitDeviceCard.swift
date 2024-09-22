//
//  DetermitDeviceCardView.swift
//  Determit
//
//  Created by Blanca Tixi on 9/19/24.
//

import UIKit

class DetermitDeviceCard: UIView {
    
    
    
    
    //Data That Will be pulled from  the back end
    //DeviceName
    //Device ImageURL
    //Device Category
    //Asset Tag
    
    let deviceImageView = DetermitDeviceImageView(frame: .zero)
    let deviceNameLabel = DetermitLabel()
    let deviceHelpButton = DetermitOutlineButton(outlineColor: UIColor.systemGreen, title: "Get Help")
    let subLabel = DetermitSubLabel(title: "Tablet",fontName: "Futura")
    let assetTagLabel = DetermitSubLabel(title: "DOE-LN0482884", fontName: "Menlo")
    
    
    
    
    
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
        
        setUpDeviceNameLabel()
        
        setUpDeviceImageView()
        setUpSublabel()
        setUpAssetLabel()
        setUpDeviceHelpButton()
        
//        deviceNameLabel.backgroundColor = .red
//        deviceImageView.backgroundColor = .green
//        subLabel.backgroundColor = .blue
//        deviceHelpButton.backgroundColor = .yellow
//        assetTagLabel.backgroundColor = .orange

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setUpDeviceNameLabel()
        
        setUpDeviceImageView()
        setUpSublabel()
        setUpAssetLabel()
        setUpDeviceHelpButton()
     
    }
    
    private func setupView(){
        
        
        backgroundColor = UIColor { traits in
            return traits.userInterfaceStyle == .dark ? UIColor.systemGray2 : UIColor.white
        }

                

        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 5
        translatesAutoresizingMaskIntoConstraints = false // Important for Auto Layout
    }
    
    
    
    private func setUpDeviceNameLabel(){
        
        
        deviceNameLabel.text = "iPad Mini"
        addSubview(deviceNameLabel)
        
        NSLayoutConstraint.activate([
            deviceNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            deviceNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10), // 10 points from the right
            deviceNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    
    
    
    
    private func setUpDeviceImageView(){
        
 //       deviceImageView.image = UIImage(named: "ipad Mini")
        deviceImageView.image = UIImage(systemName: "photo")
        addSubview( deviceImageView)
        
        // Set up Auto Layout constraints
        deviceImageView.translatesAutoresizingMaskIntoConstraints = false // Important for Auto Layout
        
        NSLayoutConstraint.activate([
            deviceImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10), // 10 points from the left
            deviceImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10), // 10 points from the right
            deviceImageView.topAnchor.constraint(equalTo: deviceNameLabel.bottomAnchor, constant: 2), // 10 points from the top
            
            deviceImageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 100), // Adjust as needed
            deviceImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100) // Adjust as needed
            ])
            

        
    }
    
    
    
    private func setUpSublabel(){
        
        addSubview(subLabel)
        
        subLabel.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            
            
        
            
            subLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10), // Fixed the leading constraint
            subLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10), // 10 points from the right
                        subLabel.topAnchor.constraint(equalTo: deviceImageView.bottomAnchor, constant: 2),
            subLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20) // Minimum height

        ])
        
    }
    
    
    private func setUpAssetLabel(){
        
        
        addSubview(assetTagLabel)
        
        assetTagLabel.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            
            
        
            
            assetTagLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10), // Fixed the leading constraint
            assetTagLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10), // 10 points from the right
            assetTagLabel.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 2),
            assetTagLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20) // Minimum height

        ])
        
        
    }
    
    
    
    
    private func setUpDeviceHelpButton(){
        
        addSubview(deviceHelpButton)

        
        
        NSLayoutConstraint.activate([
            
            deviceHelpButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4), // 50% width
//            deviceHelpButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40 ), // 10 points from the left
            deviceHelpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10), // 10 points from the right
            deviceHelpButton.topAnchor.constraint(equalTo: assetTagLabel.bottomAnchor, constant: 2), // 10 points from the top
            deviceHelpButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10), // Ensures button has padding from bottom
            deviceHelpButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40 ) // Minimum height
            
        ])
        
        
    }
    
    
    
    
    

    
    
}
