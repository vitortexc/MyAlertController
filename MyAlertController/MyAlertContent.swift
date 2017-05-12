//
//  MyAlertContent.swift
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

internal extension UIView {
	internal func setupView() {
		self.translatesAutoresizingMaskIntoConstraints = false
		
		var auxHeight : CGFloat = 0
		
		let views = ["content": self]
		var metrics : [String:Any] = [:]
		
		var constraints = [NSLayoutConstraint]()
		
//		switch self {
//		case is UILabel:
//			break
//		default:
//			break
//		}
		
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(==20@900)-[content]-(==20@900)-|", options: [], metrics: metrics, views: views)
		if self.frame.size.height > 0 {
			auxHeight = self.frame.size.height

			metrics["height"] = auxHeight
			constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[content(height)]", options: [], metrics: metrics, views: views)
		} else if !(self is UITextField) && !(self is UILabel) {
			auxHeight = 60
			
			metrics["height"] = auxHeight
			constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[content(height)]", options: [], metrics: metrics, views: views)
		}
		
		NSLayoutConstraint.activate(constraints)
	}
}
