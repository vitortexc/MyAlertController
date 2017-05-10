//
//  UIView+Animations.swift
//  MyAlertController
//
//  Created by Vitor Carrasco on 03/05/17.
//  Copyright © 2017 Empresinha. All rights reserved.
//

import UIKit

internal enum AnimationDirection {
	case `in`
	case out
}

internal extension UIView {
	
	internal var fadeKey: String {return "fade"}
	
	internal func fadeWith(_ direction: AnimationDirection, _ value: Float, duration: CFTimeInterval = 0.08) {
		self.layer.removeAnimation(forKey: fadeKey)
		
		let animation = CABasicAnimation(keyPath: "opacity")
		
		animation.duration = duration
		animation.fromValue = layer.presentation()?.opacity
		layer.opacity = value
		animation.fillMode = kCAFillModeForwards
		layer.add(animation, forKey: fadeKey)
	}
	
	internal func layoutIfNeededAnimated(duration: CFTimeInterval = 0.08, completion: ((Bool) -> Void)? = nil) {
		UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(), animations: {
			self.layoutIfNeeded()
		}, completion: completion)
	}
}
