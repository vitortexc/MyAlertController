//
//  MyAlertAction.swift
//  MyAlertController
//
//  Created by Vitor Carrasco on 11/04/17.
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

public enum MyAlertPadding : Int {
	case top
	case bottom
	case left
	case right
}

public class MyAlertAction: UIButton {
	
	// Defining an easy way to get the '(MyAlertAction) -> Void' block struct
	public typealias MyAlertActionCompletion = (MyAlertAction) -> Void
	public typealias MyAlertActionConfiguration = (MyAlertAction) -> Void
	
	// MARK: Properties
	public var paddingView : UIView = {
		let newView = UIView(frame: .zero)
		
		newView.translatesAutoresizingMaskIntoConstraints = false
		newView.clipsToBounds = true
		
		return newView
	}()
	
	@objc internal dynamic var configuration : MyAlertActionConfiguration?
	open var dismissOnTap = true
	
	open override var isHighlighted: Bool {
		didSet { isHighlighted ? fadeWith(.out, 0.5) : fadeWith(.in, 1.0) }
	}
	
	open var defaultTitleFont = UIFont.systemFont(ofSize: 14)
	open var defaultTitleColor = UIColor(red: 0.25, green: 0.53, blue: 0.91, alpha: 1)
	open var defaultButtonColor = UIColor.white
	open var defaultSeparatorColor = UIColor(white: 0.9, alpha: 1)
	open var defaultCornerRadius : CGFloat = 10
	open var defaultBorderWidth : CGFloat = 1
	open var defaultBorderColor = UIColor(white: 0.9, alpha: 1)
	
	private let defaultConfiguration : MyAlertActionConfiguration = {(action) in
        action.setTitleColor(action.defaultTitleColor, for: UIControl.State())
		action.titleLabel?.font = action.defaultTitleFont
		action.backgroundColor = action.defaultButtonColor
		action.separator.backgroundColor = action.defaultSeparatorColor
		action.leftSeparator.backgroundColor = action.defaultSeparatorColor
		
		if !action.needsTopSeparator && !action.needsLeftSeparator {
			action.layer.cornerRadius = action.defaultCornerRadius
			action.layer.borderWidth = action.defaultBorderWidth
			action.layer.borderColor = action.defaultBorderColor.cgColor
		}
	}
	
	// Block to be executed on action tapped
	open fileprivate(set) var actionBlock: MyAlertActionCompletion?
	
	// Title properties
	@objc open dynamic var title : String? {
		get { return self.titleLabel?.text }
		set { self.titleLabel?.text = newValue }
	}
	
	@objc open dynamic var titleFont: UIFont? {
		get { return titleLabel?.font }
		set { titleLabel?.font = newValue }
	}
	
	@objc open dynamic var titleColor: UIColor? {
        get { return self.titleColor(for: UIControl.State()) }
        set { setTitleColor(newValue, for: UIControl.State()) }
	}
	
	// Action properties
	@objc open dynamic var action : ((MyAlertAction) -> Void)?
	
	@objc open dynamic var actionHeight : Int
	
	@objc open dynamic var bgColor: UIColor? {
		get { return backgroundColor }
		set { backgroundColor = newValue }
	}
	
	// Separator properties
	@objc open dynamic var separatorColor: UIColor? {
		get { return separator.backgroundColor }
		set {
			separator.backgroundColor = newValue
			leftSeparator.backgroundColor = newValue
		}
	}
	
	fileprivate lazy var separator: UIView = {
		let line = UIView(frame: .zero)
		line.translatesAutoresizingMaskIntoConstraints = false
		return line
	}()
	
	fileprivate lazy var leftSeparator: UIView = {
		let line = UIView(frame: .zero)
		line.translatesAutoresizingMaskIntoConstraints = false
		line.alpha = 0
		return line
	}()
	
	internal var needsLeftSeparator: Bool = false {
		didSet { leftSeparator.alpha = needsLeftSeparator ? 1.0 : 0.0 }
	}
	
	internal var needsTopSeparator: Bool = false {
		didSet { separator.alpha = needsTopSeparator ? 1.0 : 0.0 }
	}

	// MARK: Init methods
	public init(title: String, height: Int = 40, dismissOnTap: Bool, action: MyAlertActionCompletion?, withConfiguration configurationHandler: MyAlertActionConfiguration? = nil) {
		
		self.actionHeight = height
		
		self.configuration = configurationHandler
		
		super.init(frame: .zero)
		
		self.configuration = configurationHandler
		
        self.setTitle(title, for: UIControl.State())
		self.actionBlock = action
		
		self.dismissOnTap = dismissOnTap
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Our funcs
	open func setupView(withPadding padding: (top: Int, bottom: Int, left: Int, right: Int)) {		
		self.translatesAutoresizingMaskIntoConstraints = false
		
		self.paddingView.backgroundColor = .clear
		self.paddingView.addSubview(self)
		
		self.paddingView.addSubview(separator)
		self.paddingView.addSubview(leftSeparator)
		
		let views = ["paddingView": paddingView, "separator": separator, "leftSeparator": leftSeparator, "button": self]
		let metrics = ["actionHeight": actionHeight, "paddingTop": padding.top, "paddingBottom": padding.bottom, "paddingLeft": padding.left, "paddingRight": padding.right, "paddingSumV": actionHeight+padding.top+padding.bottom]
		
		var constraints = [NSLayoutConstraint]()
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[paddingView(paddingSumV)]", options: [], metrics: metrics, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-paddingTop-[button]-paddingBottom-|", options: [], metrics: metrics, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(paddingLeft@900)-[button]-(paddingRight@900)-|", options: [], metrics: metrics, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[separator]|", options: [], metrics: nil, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[separator(1)]", options: [], metrics: nil, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[leftSeparator(1)]", options: [], metrics: nil, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[leftSeparator]|", options: [], metrics: nil, views: views)
		
		NSLayoutConstraint.activate(constraints)
		
		self.defaultConfiguration(self)
		self.configuration?(self)
	}
}
