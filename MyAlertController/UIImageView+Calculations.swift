//
//  UIImageView+Calculations.swift
//  MyAlertController
//
//  Created by Vitor Carrasco on 03/05/17.
//  Copyright © 2017 Empresinha. All rights reserved.
//

import UIKit

internal extension UIImageView {
	
	internal func heightLimited(to height: CGFloat) -> CGFloat {
		guard let image = image, image.size.height > 0 else {
			return 0.0
		}
		let ratio = image.size.height / image.size.width
		return height * ratio
	}
	
	internal func heightWithRatio() -> CGFloat {
		guard let image = image, image.size.height > 0 else {
			return 0.0
		}
		let width = bounds.size.width
		let ratio = image.size.height / image.size.width
		return width * ratio
	}
}

