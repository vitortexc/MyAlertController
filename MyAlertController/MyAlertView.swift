//
//  MyAlertContainerView.swift
//  MyAlertController
//
//  Created by Vitor Carrasco on 02/05/17.
//  Copyright © 2017 Empresinha. All rights reserved.
//

import UIKit

final public class MyAlertView: UIScrollView {

	internal let auxView : UIView
	
	lazy var contentView: UIView = {
		let container = UIView(frame: .zero)
		container.translatesAutoresizingMaskIntoConstraints = false
		container.backgroundColor = UIColor.white
		container.clipsToBounds = true
		container.layer.cornerRadius = 10
		return container
	}()
	
	lazy var actionView: UIView = {
		let buttonStackView = UIStackView()
		buttonStackView.translatesAutoresizingMaskIntoConstraints = false
		buttonStackView.alignment = .fill
		buttonStackView.distribution = .fillProportionally
		buttonStackView.spacing = 0
		return buttonStackView
	}()
	
	lazy var viewsView: UIView = {
		let views = UIStackView()
		views.translatesAutoresizingMaskIntoConstraints = false
		views.axis = .vertical
		views.alignment = .center
		views.distribution = .fillProportionally
		views.spacing = 8
		return views
	}()
	
	lazy var stackView: UIView = {
		let stackView = UIStackView(arrangedSubviews: [self.viewsView, self.actionView])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = 10
		return stackView
	}()
	
	override public dynamic var backgroundColor: UIColor? {
		get {
			return self.contentView.backgroundColor
		}
		set {
			self.contentView.backgroundColor = newValue
		}
	}
	
	public dynamic var cornerRadius : Float {
		get {
			return Float(self.contentView.layer.cornerRadius)
		}
		set {
			self.contentView.layer.cornerRadius = CGFloat(newValue)
		}
	}
	
//	internal var auxViewHeightConstraint: NSLayoutConstraint? = nil
	
	internal var distanceMoved : CGFloat = 0
	
	// MARK: Inital setup methods
	
	internal override init(frame: CGRect) {
		
		self.auxView = UIView()
		
		super.init(frame: frame)
		self.isScrollEnabled = true
		
		setupViews()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Our Methods
	
	internal func setupViews() {
		auxView.translatesAutoresizingMaskIntoConstraints = false
		
		self.addSubview(auxView)
		auxView.addSubview(contentView)
		contentView.addSubview(stackView)
		
		
		let views = ["self": self,"auxView": auxView, "content": contentView, "stackView": stackView]
		var constraints = [NSLayoutConstraint]()
		
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[auxView]|", options: [], metrics: nil, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[auxView]", options: [], metrics: nil, views: views)
		constraints += [NSLayoutConstraint(item: auxView, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1, constant: 60)]
//		self.auxViewHeightConstraint = NSLayoutConstraint(item: auxView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: self.contentView, attribute: .height, multiplier: 1, constant: 0)
//		constraints.append(self.auxViewHeightConstraint!)
		
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=10,==20@900)-[content(<=340,>=300)]-(>=10,==20@900)-|", options: [], metrics: nil, views: views)
		constraints += [NSLayoutConstraint(item: contentView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)]
		constraints += [NSLayoutConstraint(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: auxView, attribute: .centerY, multiplier: 1, constant: 0)]
		
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackView]|", options: [], metrics: nil, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]|", options: [], metrics: nil, views: views)
		
		NSLayoutConstraint.activate(constraints)
	}
}
