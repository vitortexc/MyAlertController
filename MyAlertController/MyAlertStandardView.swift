//
//  MyAlertControllerDefaultView.swift
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

final public class MyAlertStandardView: UIView {
	
	// MARK: Properties
	
	// View properties
	internal lazy var iconView: UIImageView = {
		let imageView = UIImageView(frame: .zero)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		return imageView
	}()
	
	internal lazy var titleLabel: UILabel = {
		let titleLabel = UILabel(frame: .zero)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.numberOfLines = 0
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor(white: 0.4, alpha: 1)
		titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
		return titleLabel
	}()
	
	internal lazy var messageLabel: UILabel = {
		let messageLabel = UILabel(frame: .zero)
		messageLabel.translatesAutoresizingMaskIntoConstraints = false
		messageLabel.numberOfLines = 0
		messageLabel.textAlignment = .center
		messageLabel.textColor = UIColor(white: 0.6, alpha: 1)
		messageLabel.font = UIFont.systemFont(ofSize: 14)
		return messageLabel
	}()
	
	
	// Title properties
	public dynamic var titleFont: UIFont {
		get { return titleLabel.font }
		set { titleLabel.font = newValue }
	}
	
	public dynamic var titleColor: UIColor? {
		get { return titleLabel.textColor }
		set { titleLabel.textColor = newValue }
	}
	
	public dynamic var titleTextAlignment: NSTextAlignment {
		get { return titleLabel.textAlignment }
		set { titleLabel.textAlignment = newValue }
	}
	
	// Message properties
	public dynamic var messageFont: UIFont {
		get { return messageLabel.font }
		set { messageLabel.font = newValue }
	}
	
	public dynamic var messageColor: UIColor? {
		get { return messageLabel.textColor }
		set { messageLabel.textColor = newValue}
	}
	
	public dynamic var messageTextAlignment: NSTextAlignment {
		get { return messageLabel.textAlignment }
		set { messageLabel.textAlignment = newValue }
	}
	
	// Height constraint of the icon
	internal var imageHeightConstraint: NSLayoutConstraint?
	
	internal override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	internal func setupViews() {
		
		// Self setup
		translatesAutoresizingMaskIntoConstraints = false
		
		// Add views
		addSubview(iconView)
		addSubview(titleLabel)
		addSubview(messageLabel)
		
		// Layout views
		let views = ["iconView": iconView, "titleLabel": titleLabel, "messageLabel": messageLabel] as [String : Any]
		var constraints = [NSLayoutConstraint]()
		
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[iconView]|", options: [], metrics: nil, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(==20@900)-[titleLabel]-(==20@900)-|", options: [], metrics: nil, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(==20@900)-[messageLabel]-(==20@900)-|", options: [], metrics: nil, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[iconView]-(==10@900)-[titleLabel]-(==8@900)-[messageLabel]|", options: [], metrics: nil, views: views)
		
		// ImageView height constraint
		imageHeightConstraint = NSLayoutConstraint(item: iconView, attribute: .height, relatedBy: .equal, toItem: iconView, attribute: .height, multiplier: 0, constant: 0)
		constraints.append(imageHeightConstraint!)
		
		// Activate constraints
		NSLayoutConstraint.activate(constraints)
	}
}
