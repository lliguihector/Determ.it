//
//  DetermitCard.swift
//  Determit
//
//  Created by Blanca Tixi on 9/18/24.
//

import UIKit

class DetermitProfileCard: UIView {

    var profilePictureURL: String?
    
    //UIComponents
    let companyProfilePicture = DetermitProfileImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    let userNameLabel = DetermitLabel()
    let callToActionButton = DetermitOutlineButton(outlineColor: UIColor.systemBlue, title: "View Profile")
    let subLabel = DetermitSubLabel(title: "UI/UX Designer",fontName: "Futura")
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupView()
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
        
            // Configure the profile image view
            configureProfileImageView()
            //Configure the label title
            configureLabel()
        //configure sublabel
          configureSubLabel()           //Configure View Profile Button
//
    }
    
    @objc func pushUserToProfileVC(){
        //This Function will navigate the user to the profile view
        print("The button is working")
    }
    
    private func configureLabel(){
        userNameLabel.text = "HECTOR LLIGUICHUZHCA"
        addSubview(userNameLabel)
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: companyProfilePicture.trailingAnchor, constant: 10), // 5 points to the right of the image view
            userNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor), // Center vertically
        ])
    }
    
    
    private func configureSubLabel(){
        
        
        addSubview(subLabel)
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subLabel.leadingAnchor.constraint(equalTo: companyProfilePicture.trailingAnchor, constant: 10), // 5 points to the right of the image view
            subLabel.topAnchor.constraint(equalTo: userNameLabel.topAnchor, constant: 20),
//            subLabel.centerYAnchor.constraint(equalTo: centerYAnchor) // Center vertically
        ])
        
    }
    
    private func configureProfileImageView(){
        companyProfilePicture.image = UIImage(named: "ig")
        
        
//   companyProfilePicture.image = UIImage(systemName: "person.circle.fill")
       addSubview(companyProfilePicture)
        
        // Set up Auto Layout constraints
        companyProfilePicture.translatesAutoresizingMaskIntoConstraints = false // Important for Auto Layout
        
        NSLayoutConstraint.activate([
             companyProfilePicture.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12), // 10 points from the left
             companyProfilePicture.centerYAnchor.constraint(equalTo: centerYAnchor), // Center vertically
             companyProfilePicture.widthAnchor.constraint(equalToConstant: 60), // Adjust as needed
             companyProfilePicture.heightAnchor.constraint(equalToConstant: 60) // Adjust as needed
             ])
    }
    

   private func configureViewProfileButton(){
        
        addSubview(callToActionButton)
        
        callToActionButton.addTarget(self, action: #selector(pushUserToProfileVC), for: .touchUpInside)
   
        //Array of constraints
        NSLayoutConstraint.activate([
                     callToActionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20), // 10 points from the bottom
                       callToActionButton.centerXAnchor.constraint(equalTo: centerXAnchor), // Center horizontally
                       callToActionButton.widthAnchor.constraint(equalToConstant: 160), // Fixed width
                       callToActionButton.heightAnchor.constraint(equalToConstant: 40) // Fixed height
        ])
    }
}
