//
//  MyAlertContent.swift
//  MyAlertController
//
//  Created by Vitor Carrasco on 08/05/17.
//  Copyright © 2017 Empresinha. All rights reserved.
//

import UIKit

internal extension UIView {
	internal func setupView() {
		self.translatesAutoresizingMaskIntoConstraints = false
		
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
			var auxHeight : CGFloat = 0
			
			if self.frame.size.height > 0 {
				auxHeight = self.frame.size.height
			} else {
				switch self {
				case is UITableView:
					auxHeight = 60
					break
				case is UITextField:
					auxHeight = 30
					break
				default:
					break
				}
			}

			metrics["height"] = auxHeight
			constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[content(height)]", options: [], metrics: metrics, views: views)
		}
		
		NSLayoutConstraint.activate(constraints)
	}
}
