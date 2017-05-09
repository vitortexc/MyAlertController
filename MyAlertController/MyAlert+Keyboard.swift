//
//  MyAlert+Keyboard.swift
//  MyAlertController
//
//  Created by Vitor Carrasco on 08/05/17.
//  Copyright © 2017 Empresinha. All rights reserved.
//

import UIKit

extension MyAlert: UITextFieldDelegate {
	// MARK: Internal methods
	internal func addObservers() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: view.window)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: view.window)
	}
	
	internal func removeObservers() {
		NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: view.window)
		NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: view.window)
	}
	
	@objc private func keyboardWillHide(_ notification: Notification) {
		var info = notification.userInfo!
		let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
		let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
		self.alertView.contentInset = contentInsets
		self.alertView.scrollIndicatorInsets = contentInsets
		self.view.endEditing(true)
	}
	
	@objc private func keyboardWillShow(_ notification: Notification) {
		var info = notification.userInfo!
		let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
		let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
		
		self.alertView.contentInset = contentInsets
		self.alertView.scrollIndicatorInsets = contentInsets
		
		var aRect : CGRect = self.view.frame
		aRect.size.height -= keyboardSize!.height
		if let activeField = self.activeField {
			if (!aRect.contains(activeField.frame.origin)){
				
				self.alertView.scrollRectToVisible(activeField.frame, animated: true)
			}
		}
	}
	
	func dismissKeyboard () {
		self.view.endEditing(true)
	}
	
	@objc private func close() {
		self.activeField?.resignFirstResponder()
		self.dismiss(animated: true, completion: nil)
	}
	
	public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	public func textFieldDidBeginEditing(_ textField: UITextField) {
		self.activeField = textField
	}
	
	public func textFieldDidEndEditing(_ textField: UITextField) {
		self.activeField = nil
	}
}
