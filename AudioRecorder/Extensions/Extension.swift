//
//  Extension.swift
//  AudioRecorder
//
//  Created by Ibrahim Mo Gedami on 7/19/22.
//

import UIKit
//MARK:- Adding Attributes to UIView
extension UIView {

@IBInspectable
var cornerRadius: CGFloat {
    get {
        return layer.cornerRadius
    }
    set {
        layer.cornerRadius = newValue
    }
}

@IBInspectable
var borderWidth: CGFloat {
    get {
        return layer.borderWidth
    }
    set {
        layer.borderWidth = newValue
    }
}

@IBInspectable
var borderColor: UIColor? {
    get {
        if let color = layer.borderColor {
            return UIColor(cgColor: color)
        }
        return nil
    }
    set {
        if let color = newValue {
            layer.borderColor = color.cgColor
        } else {
            layer.borderColor = nil
        }
    }
}
}

//MARK:- Hide keyboard when tapped
extension UIViewController {
    // Function for tap gesture
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    // Calling dismiss selector actions
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
