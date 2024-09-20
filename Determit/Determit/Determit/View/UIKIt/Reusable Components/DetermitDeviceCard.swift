//
//  DetermitDeviceCardView.swift
//  Determit
//
//  Created by Blanca Tixi on 9/19/24.
//

import UIKit

class DetermitDeviceCard: UIView {

  
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupView()
        }
    
    private func setupView(){
              backgroundColor = .white
              layer.cornerRadius = 10
              layer.shadowColor = UIColor.black.cgColor
              layer.shadowOpacity = 0.2
              layer.shadowOffset = CGSize(width: 0, height: 2)
              layer.shadowRadius = 5
              translatesAutoresizingMaskIntoConstraints = false // Important for Auto Layout
    }
    
    
    
    
    

}
