//
//  MyAlertControllerDefaultViewController.swift
//  MyAlertController
//
//  Created by Vitor Carrasco on 03/05/17.
//  Copyright © 2017 Empresinha. All rights reserved.
//

import UIKit

final public class MyAlertStandardViewController: UIViewController {
	
	// MARK: Properties
	
	// Root view of the controller
	public var defaultView: MyAlertStandardView {
		return view as! MyAlertStandardView
	}
	
	// Icon properties
	public var icon: UIImage? {
		get { return defaultView.iconView.image }
		set {
			defaultView.iconView.image = newValue
		}
	}
	
	internal var iconHeight : CGFloat {
		get {
			if let value = defaultView.imageHeightConstraint?.constant {
				return value
			}
			return 0.0
		}
		set { defaultView.imageHeightConstraint?.constant = defaultView.iconView.heightLimited(to: newValue) }
	}
	// Title Properties
	public var titleText: String? {
		get { return defaultView.titleLabel.text }
		set {
			defaultView.titleLabel.text = newValue
			defaultView.layoutIfNeededAnimated()
		}
	}
	
	public dynamic var titleFont: UIFont {
		get { return defaultView.titleFont }
		set {
			defaultView.titleFont = newValue
			defaultView.layoutIfNeededAnimated()
		}
	}
	
	public dynamic var titleColor: UIColor? {
		get { return defaultView.titleLabel.textColor }
		set {
			defaultView.titleColor = newValue
			defaultView.layoutIfNeededAnimated()
		}
	}
	
	public dynamic var titleTextAlignment: NSTextAlignment {
		get { return defaultView.titleTextAlignment }
		set {
			defaultView.titleTextAlignment = newValue
			defaultView.layoutIfNeededAnimated()
		}
	}
	
	// Message properties
	public var messageText: String? {
		get { return defaultView.messageLabel.text }
		set {
			defaultView.messageLabel.text = newValue
			defaultView.layoutIfNeededAnimated()
		}
	}
	
	public dynamic var messageFont: UIFont {
		get { return defaultView.messageFont}
		set {
			defaultView.messageFont = newValue
			defaultView.layoutIfNeededAnimated()
		}
	}
	
	public dynamic var messageColor: UIColor? {
		get { return defaultView.messageColor }
		set {
			defaultView.messageColor = newValue
			defaultView.layoutIfNeededAnimated()
		}
	}
	
	public dynamic var messageTextAlignment: NSTextAlignment {
		get { return defaultView.messageTextAlignment }
		set {
			defaultView.messageTextAlignment = newValue
			defaultView.layoutIfNeededAnimated()
		}
	}
	
	// MARK: Overrides methods
	public override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		defaultView.imageHeightConstraint?.constant = defaultView.iconView.heightWithRatio()
	}
	
	override public func loadView() {
		super.loadView()
		view = MyAlertStandardView(frame: .zero)
	}
}
