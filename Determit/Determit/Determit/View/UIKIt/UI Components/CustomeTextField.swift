//
//  CustomeTextField.swift
//  Determit
//
//  Created by Blanca Tixi on 6/9/24.
//

import Foundation
import UIKit

protocol CustomTextFieldDelegate: AnyObject {
//    func textFieldDidEndEditing(_ textField: CustomTextField, isValid: Bool, errorMessage: String?)
    
    
    func updateMyLabel(_ errorMessage: String)
}
    
    

@IBDesignable
class CustomTextField: UITextField {

    private let checkmarkImageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
    
    private let exclamationmarkImageView = UIImageView(image: UIImage(systemName: "exclamationmark.circle.fill"))

    var validationType: ValidationType = .email {
        didSet { viewModel.validationType = validationType }
    }

    weak var customDelegate: CustomTextFieldDelegate?
    private let viewModel = InventoryViewModel()

    private var validationResult: (isValid: Bool, errorMessage: String?) = (false, nil) {
        didSet { updateAppearance() }
    }

    @IBInspectable var cornerRadius: CGFloat = 2 {
        didSet {
            setupView()
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            setupView()
        }
    }

    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            setupView()
        }
    }

    @IBInspectable var padding: CGFloat = 10.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        delegate = self
        setupCheckmarkImageView()
        setupExclamationmarkImageView()
        viewModel.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        delegate = self
        setupCheckmarkImageView()
        setupExclamationmarkImageView()
        viewModel.delegate = self
    }

    private func setupView() {
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        backgroundColor = UIColor.white
    }

    private func setupCheckmarkImageView() {
        checkmarkImageView.tintColor = .systemGreen
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(checkmarkImageView)
        NSLayoutConstraint.activate([
            checkmarkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            checkmarkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 20),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        checkmarkImageView.isHidden = true
    }
    
    
    private func setupExclamationmarkImageView() {
        exclamationmarkImageView.tintColor = .systemRed
        exclamationmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(exclamationmarkImageView)
        NSLayoutConstraint.activate([
            exclamationmarkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            exclamationmarkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            exclamationmarkImageView.widthAnchor.constraint(equalToConstant: 20),
            exclamationmarkImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        exclamationmarkImageView.isHidden = true
    }
    
    
    

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: padding)
    }

    func showErrorState() {
        self.layer.borderColor = UIColor.systemRed.cgColor
        checkmarkImageView.isHidden = true
        exclamationmarkImageView.isHidden = false
    }

    func clearErrorState() {
        self.layer.borderColor = borderColor.cgColor
        exclamationmarkImageView.isHidden = true

    }

    func showCheckmark() {
        checkmarkImageView.isHidden = false
        self.layer.borderColor = UIColor.systemGreen.cgColor
    }

    private func updateAppearance() {
        if validationResult.isValid {
            clearErrorState()
            showCheckmark()
        } else {
            
            
            showErrorState()
            
            
        }
    }
}

extension CustomTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        viewModel.validate(input: self.text, for: validationType)
        
        
    }
}

extension CustomTextField: ValidationDelegate {
    
    
    //From View Model
    func validationDidFinish(isValid: Bool, errorMessage: String?) {
        
        
        //Update UI based on Validation result
        validationResult = (isValid, errorMessage)
        
        
        if let errorMessage = errorMessage{
            
            print("CT: \(errorMessage)")
            
            
            customDelegate?.updateMyLabel(errorMessage)
        }
        
        
      
    }
}
