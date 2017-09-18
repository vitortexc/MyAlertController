//
//  MyAlertTransitionManager.swift
//  MyAlertController
//
//  Created by Vitor Carrasco on 03/05/17.
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

final internal class MyAlertTransitionManager: NSObject, UIViewControllerTransitioningDelegate {
	
	var transitionStyle: MyAlertTransitionStyle
	
	init(transitionStyle: MyAlertTransitionStyle) {
		self.transitionStyle = transitionStyle
		super.init()
	}
	
	func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
		let presentationController = MyAlertViewController(presentedViewController: presented, presenting: source)
		return presentationController
	}
	
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		
		var transition: MyAlertTransitionAnimator
		switch transitionStyle {
		case .bounceUp:
			transition = BounceUpTransition(direction: .in)
		case .bounceDown:
			transition = BounceDownTransition(direction: .in)
		case .zoomIn:
			transition = ZoomTransition(direction: .in)
		case .fadeIn:
			transition = FadeTransition(direction: .in)
		}
		
		return transition
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		var transition: MyAlertTransitionAnimator
		switch transitionStyle {
		case .bounceUp:
			transition = BounceUpTransition(direction: .out)
		case .bounceDown:
			transition = BounceDownTransition(direction: .out)
		case .zoomIn:
			transition = ZoomTransition(direction: .out)
		case .fadeIn:
			transition = FadeTransition(direction: .out)
		}
		
		return transition
	}
}

final internal class MyAlertViewController: UIPresentationController {
	
	fileprivate lazy var overlay: MyAlertOverlayView = {
		return MyAlertOverlayView(frame: .zero)
	}()
	
	override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
		super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
		overlay.blurView.underlyingView = presentingViewController?.view
		overlay.frame = (presentingViewController?.view.bounds)!
	}
	
	override func presentationTransitionWillBegin() {
		overlay.frame = containerView!.bounds
		containerView!.insertSubview(overlay, at: 0)
		
		presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (coordinatorContext) -> Void in
			self.overlay.alpha = 1.0
		}, completion: nil)
	}
	
	override func dismissalTransitionWillBegin() {
		presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (coordinatorContext) -> Void in
			self.overlay.alpha = 0.0
		}, completion: nil)
	}
	
	override func containerViewWillLayoutSubviews() {
		presentedView!.frame = frameOfPresentedViewInContainerView
		overlay.blurView.setNeedsDisplay()
	}
}
