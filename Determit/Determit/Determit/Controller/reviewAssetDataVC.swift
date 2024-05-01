//
//  reviewAssetDataVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/27/23.
//

import UIKit

class reviewAssetDataVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
    }
    
    
    @IBAction func cancelPressed(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func savedPressed(_ sender: Any) {

        let alertController = UIAlertController(title: "Success!", message: "new accet was added to inventory.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
          
            //                      self.navigationController?.popViewController(animated: true)
            DispatchQueue.main.async {
                
//                self.navigationController?.popViewController(animated: true)
                // Pop back two view controllers
                        if let navigationController = self.navigationController,
                           navigationController.viewControllers.count >= 2 {
                            navigationController.popViewController(animated: true)
                            navigationController.popViewController(animated: true)
                        }
                
            }
            
        }
        
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        
    }
}
