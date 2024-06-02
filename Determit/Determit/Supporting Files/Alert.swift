//
//  Alert.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 9/4/22.
//

import Foundation
import UIKit


struct Alert {
    
    //Resource URL: https://www.youtube.com/watch?v=ZBS2uRP6_2U
    static func showBasicAlert(on vc: UIViewController, with title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        // Customizing the alert background color
                let backgroundColor = UIColor(red: 5/255, green: 80/255, blue: 172/255, alpha: 1.0) // Example light gray color
                let textColor = UIColor.white // Example white color for title and message
                
        
        // Set the background color of the alert's view
                if let backgroundView = alert.view.subviews.first?.subviews.first?.subviews.first {
                    backgroundView.backgroundColor = backgroundColor
                    backgroundView.layer.cornerRadius = 8 // Optional: to make the corners rounded
                }
                
        
        // Set the title and message text color
               let titleAttributes = [NSAttributedString.Key.foregroundColor: textColor]
               let messageAttributes = [NSAttributedString.Key.foregroundColor: textColor]
               
               let attributedTitle = NSAttributedString(string: title, attributes: titleAttributes)
               let attributedMessage = NSAttributedString(string: message, attributes: messageAttributes)
               
               alert.setValue(attributedTitle, forKey: "attributedTitle")
               alert.setValue(attributedMessage, forKey: "attributedMessage")
               
               // Add and customize the OK button
               let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
               okAction.setValue(textColor, forKey: "titleTextColor")
               alert.addAction(okAction)
        

        
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
 
        
    }
    
    
    
    
    
    
}
