//
//  CustomeTextField.swift
//  Determit
//
//  Created by Blanca Tixi on 6/9/24.
//

import Foundation
import UIKit

protocol CustomTextFieldDelegate: AnyObject {
    func textFieldDidEndEditing(_ textField: CustomTextField, isValid: Bool, errorMessage: String?)
}

@IBDesignable
class CustomTextField: UITextField {

    private let checkmarkImageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))

    var validationType: ValidationType = .email {
        didSet { viewModel.validationType = validationType }
    }

    weak var customDelegate: CustomTextFieldDelegate?
    private let viewModel = InventoryViewModel()

    private var validationResult: (isValid: Bool, errorMessage: String?) = (false, nil) {
        didSet { updateAppearance() }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            setupView()
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.white {
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
        viewModel.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        delegate = self
        setupCheckmarkImageView()
        viewModel.delegate = self
    }

    private func setupView() {
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        backgroundColor = UIColor.white
    }

    private func setupCheckmarkImageView() {
        checkmarkImageView.tintColor = .green
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

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: padding)
    }

    func showErrorState(message: String) {
        self.layer.borderColor = UIColor.red.cgColor
//        self.backgroundColor = UIColor.red.withAlphaComponent(0.1)
        checkmarkImageView.isHidden = true
        print("Error:", message)
    }

    func clearErrorState() {
        self.layer.borderColor = borderColor.cgColor
//        self.backgroundColor = UIColor.white
    }

    func showCheckmark() {
        checkmarkImageView.isHidden = false
        self.layer.borderColor = UIColor.green.cgColor
    }

    private func updateAppearance() {
        if validationResult.isValid {
            clearErrorState()
            showCheckmark()
        } else {
            showErrorState(message: validationResult.errorMessage ?? "Invalid input")
        }
    }
}

extension CustomTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.validate(input: self.text, for: validationType)
    }
}

extension CustomTextField: ValidationDelegate {
    func validationDidFinish(isValid: Bool, errorMessage: String?) {
        validationResult = (isValid, errorMessage)
        customDelegate?.textFieldDidEndEditing(self, isValid: isValid, errorMessage: errorMessage)
    }
}
