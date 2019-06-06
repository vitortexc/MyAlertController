//
//  UIView+Animations.swift
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

internal enum AnimationDirection {
	case `in`
	case out
}

internal extension UIView {
	
    var fadeKey: String {return "fade"}
	
    func fadeWith(_ direction: AnimationDirection, _ value: Float, duration: CFTimeInterval = 0.08) {
		self.layer.removeAnimation(forKey: fadeKey)
		
		let animation = CABasicAnimation(keyPath: "opacity")
		
		animation.duration = duration
		animation.fromValue = layer.presentation()?.opacity
		layer.opacity = value
        animation.fillMode = CAMediaTimingFillMode.forwards
		layer.add(animation, forKey: fadeKey)
	}
	
    func layoutIfNeededAnimated(duration: CFTimeInterval = 0.08, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(), animations: {
			self.layoutIfNeeded()
		}, completion: completion)
	}
}
