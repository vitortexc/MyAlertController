//
//  MyAlertTransitionAnimations.swift
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

public enum MyAlertTransitionStyle: Int {
	case bounceUp
	case bounceDown
	case zoomIn
	case fadeIn
}

final internal class BounceUpTransition: MyAlertTransitionAnimator {
	
	init(direction: AnimationDirection) {
		super.init(inDuration: 0.22, outDuration: 0.2, direction: direction)
	}
	
	override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		super.animateTransition(using: transitionContext)
		
		switch direction {
		case .in:
			to.view.bounds.origin = CGPoint(x: 0, y: -from.view.bounds.size.height)
			UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
				self.to.view.bounds = self.from.view.bounds
			}) { (completed) in
				transitionContext.completeTransition(completed)
			}
		case .out:
			UIView.animate(withDuration: outDuration, delay: 0.0, options: [.curveEaseIn], animations: {
				self.from.view.bounds.origin = CGPoint(x: 0, y: -self.from.view.bounds.size.height)
				self.from.view.alpha = 0.0
			}) { (completed) in
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
			}
		}
	}
}

final internal class BounceDownTransition: MyAlertTransitionAnimator {
	
	init(direction: AnimationDirection) {
		super.init(inDuration: 0.22, outDuration: 0.2, direction: direction)
	}
	
	override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		super.animateTransition(using: transitionContext)
		
		switch direction {
		case .in:
			to.view.bounds.origin = CGPoint(x: 0, y: from.view.bounds.size.height)
			UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
				self.to.view.bounds = self.from.view.bounds
			}) { (completed) in
				transitionContext.completeTransition(completed)
			}
		case .out:
			UIView.animate(withDuration: outDuration, delay: 0.0, options: [.curveEaseIn], animations: {
				self.from.view.bounds.origin = CGPoint(x: 0, y: self.from.view.bounds.size.height)
				self.from.view.alpha = 0.0
			}) { (completed) in
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
			}
		}
	}
}

final internal class ZoomTransition: MyAlertTransitionAnimator {
	
	init(direction: AnimationDirection) {
		super.init(inDuration: 0.22, outDuration: 0.2, direction: direction)
	}
	
	override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		super.animateTransition(using: transitionContext)
		
		switch direction {
		case .in:
			to.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
			UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
				self.to.view.transform = CGAffineTransform(scaleX: 1, y: 1)
			}) { (completed) in
				transitionContext.completeTransition(completed)
			}
		case .out:
			UIView.animate(withDuration: outDuration, delay: 0.0, options: [.curveEaseIn], animations: {
				self.from.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
				self.from.view.alpha = 0.0
			}) { (completed) in
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
			}
		}
	}
}

final internal class FadeTransition: MyAlertTransitionAnimator {
	
	init(direction: AnimationDirection) {
		super.init(inDuration: 0.22, outDuration: 0.2, direction: direction)
	}
	
	override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		super.animateTransition(using: transitionContext)
		
		switch direction {
		case .in:
			to.view.alpha = 0
			UIView.animate(withDuration: 0.6, delay: 0.0, options: [.curveEaseOut],
			               animations: {
							self.to.view.alpha = 1
			}) { (completed) in
				transitionContext.completeTransition(completed)
			}
		case .out:
			UIView.animate(withDuration: outDuration, delay: 0.0, options: [.curveEaseIn], animations: {
				self.from.view.alpha = 0.0
			}) { (completed) in
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
			}
		}
	}
}
