//
//  MyAlert+Keyboard.swift
//  MyAlertController
//
//  Created by Vitor Carrasco on 08/05/17.
//  Copyright © 2017 Empresinha. All rights reserved.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

extension MyAlert: UITextFieldDelegate {
	// MARK: Internal methods
	internal func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: view.window)
	}
	
	internal func removeObservers() {
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: view.window)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: view.window)
	}
	
	@objc private func keyboardWillHide(_ notification: Notification) {
		var info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -keyboardSize!.height, right: 0.0)
		self.alertView.contentInset = contentInsets
		self.alertView.scrollIndicatorInsets = contentInsets
		self.view.endEditing(true)
	}
	
	@objc private func keyboardWillShow(_ notification: Notification) {
		var info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize!.height, right: 0.0)
		
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
