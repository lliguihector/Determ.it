//
//  emptyStateView.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/22/24.
//

import Foundation
import UIKit

class EmptyStateView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit // Set content mode to scale aspect fit
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0 // Allow multiple lines
        return label
    }()
    
    // Public properties to set image, title, and caption
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    //    var title: String? {
    //        didSet {
    //            titleLabel.text = title
    //        }
    //    }
    
    var caption: String? {
        didSet {
            captionLabel.text = caption
        }
    }
    
    
    //Public method to update title
    
    func updateTitle(_ title: String){
        titleLabel.text = title
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupKeyboardNotifications()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupKeyboardNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(captionLabel)
        
        NSLayoutConstraint.activate([
//            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
//            imageView.widthAnchor.constraint(equalToConstant: 60), // Set image width
//            imageView.heightAnchor.constraint(equalToConstant: 60), // Set image height
//            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
//            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            captionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
//            captionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            captionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16), // Set image top anchor
                    imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                    imageView.widthAnchor.constraint(equalToConstant: 60), // Set image width
                    imageView.heightAnchor.constraint(equalToConstant: 60), // Set image height
                    titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
                    titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                    titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                    captionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                    captionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                    captionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                    captionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16) // Set caption bottom anchor
            
        ])
    }
    
    

    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        let safeAreaBottom = windowScene.windows.first?.safeAreaInsets.bottom ?? 0
        
        // Calculate the distance between the bottom of the view and the top of the keyboard
        let distanceToKeyboard = frame.maxY - (UIScreen.main.bounds.height - keyboardHeight - safeAreaBottom)
        
        // Shift the view upwards if it's covered by the keyboard
        if distanceToKeyboard < 0 {
            transform = CGAffineTransform(translationX: 0, y: distanceToKeyboard)
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        // Reset the view's transform when the keyboard is hidden
        transform = .identity
    }



}
