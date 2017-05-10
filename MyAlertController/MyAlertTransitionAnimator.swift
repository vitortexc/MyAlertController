//
//  MyAlertTransitionAnimator.swift
//  MyAlertController
//
//  Created by Vitor Carrasco on 08/05/17.
//  Copyright © 2017 Empresinha. All rights reserved.
//

import UIKit


internal class MyAlertTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
	
	var to: UIViewController!
	var from: UIViewController!
	let inDuration: TimeInterval
	let outDuration: TimeInterval
	let direction: AnimationDirection
	
	init(inDuration: TimeInterval, outDuration: TimeInterval, direction: AnimationDirection) {
		self.inDuration = inDuration
		self.outDuration = outDuration
		self.direction = direction
		super.init()
	}
	
	internal func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return direction == .in ? inDuration : outDuration
	}
	
	internal func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		switch direction {
		case .in:
			to = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
			from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
			let container = transitionContext.containerView
			container.addSubview(to.view)
		case .out:
			to = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
			from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
		}
	}
}
