//
//  MyAlertCheckBox.swift
//  MyAlertController
//
//  Created by Vitor Carrasco on 10/05/17.
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

public enum MyAlertCheckBoxStyle {
	case custom
	case rounded
	case sphere
	case square
}

public class MyAlertCheckBox: UIView {
	
	public typealias MyAlertCheckBoxConfiguration = (MyAlertCheckBox) -> Void
	
	// MARK: Properties
	public var identifier : String?
	
	internal dynamic var configuration : MyAlertCheckBoxConfiguration?
	internal var isChecked : Bool {
		get { return !self.checkBoxTick.isHidden}
		set {
			checkBoxTick.isHidden = newValue ? false : true
		}
	}
	internal final let checkBoxStyle : MyAlertCheckBoxStyle
	
	private let textLabel : UILabel = {
		let newLabel = UILabel(frame: .zero)
		
		newLabel.numberOfLines = 0
		newLabel.translatesAutoresizingMaskIntoConstraints = false
		newLabel.textAlignment = .left
		
		return newLabel
	}()
	
	private let checkBox : UIImageView = {
		let newImageView = UIImageView(frame: .zero)
		newImageView.layer.borderWidth = 2
		newImageView.layer.borderColor = UIColor(white: 0.8, alpha: 1).cgColor
		newImageView.contentMode = .scaleAspectFit
		
		newImageView.translatesAutoresizingMaskIntoConstraints = false
		
		return newImageView
	}()
	
	private let checkBoxTick : UIImageView = {
		let newImageView = UIImageView(frame: .zero)

		newImageView.backgroundColor = UIColor(white: 0.7, alpha: 1)
		newImageView.contentMode = .scaleAspectFill
		
		newImageView.translatesAutoresizingMaskIntoConstraints = false
		
		return newImageView
	}()
	
	open var defaultTextFont = UIFont.systemFont(ofSize: 14)
	open var defaultTextColor = UIColor(white: 0.6, alpha: 1)
	open var defaultCheckedColor = UIColor(white: 0.7, alpha: 1)
	open var defaultButtonColor = UIColor.clear
	
	private let defaultConfiguration : MyAlertCheckBoxConfiguration = {(checkBox) in
		checkBox.textColor = checkBox.defaultTextColor
		checkBox.textFont = checkBox.defaultTextFont
		checkBox.backgroundColor = checkBox.defaultButtonColor
	}
	
	// Title properties
	open dynamic var text : String? {
		get { return self.textLabel.text }
		set { self.textLabel.text = newValue }
	}
	
	open dynamic var textFont: UIFont? {
		get { return textLabel.font }
		set { textLabel.font = newValue }
	}
	
	open dynamic var textColor: UIColor? {
		get { return self.textColor }
		set { self.textLabel.textColor = newValue }
	}
	
	open dynamic var bgColor: UIColor? {
		get { return backgroundColor }
		set { backgroundColor = newValue }
	}
	
	// MARK: Init methods
	internal init(text: String, style: MyAlertCheckBoxStyle = .rounded, withConfiguration configurationHandler: MyAlertCheckBoxConfiguration? = nil) {
		
		self.checkBoxStyle = style
		switch style {
		case .rounded,.sphere:
//			self.checkBox.clipsToBounds = true
			self.checkBox.layer.cornerRadius = style == .rounded ? 4 : 10
			self.checkBoxTick.layer.cornerRadius = style == .rounded ? 2.5 : 8.5
			break
		default:
			self.checkBox.clipsToBounds = false
		}
		
		super.init(frame: .zero)
		
		self.isChecked = false
		self.text = text
		self.configuration = configurationHandler
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Our methods
	open override func setupView() {
		self.translatesAutoresizingMaskIntoConstraints = false
		
		let auxView = UIView(frame: .zero)
		auxView.translatesAutoresizingMaskIntoConstraints = false
		
		self.checkBox.addSubview(self.checkBoxTick)
		auxView.addSubview(self.checkBox)
		
		self.addSubview(textLabel)
		self.addSubview(auxView)
		
		let views = ["text": textLabel, "checkBox": checkBox, "checkedBox": checkBoxTick, "auxView": auxView]
		let metrics = ["checkWidth": self.checkBox.frame.size.height]
		
		var constraints = [NSLayoutConstraint]()
		
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[auxView(40)]-[text]|", options: [], metrics: metrics, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[text]|", options: [], metrics: metrics, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[auxView(==text)]|", options: [], metrics: metrics, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:[checkBox(20)]", options: [], metrics: metrics, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[checkBox(20)]", options: [], metrics: metrics, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:[checkedBox(12)]", options: [], metrics: metrics, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[checkedBox(12)]", options: [], metrics: metrics, views: views)
		constraints += [
			NSLayoutConstraint(item: self.checkBox, attribute: .centerX, relatedBy: .equal, toItem: auxView, attribute: .centerX, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: self.checkBox, attribute: .centerY, relatedBy: .equal, toItem: auxView, attribute: .centerY, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: self.checkBoxTick, attribute: .centerX, relatedBy: .equal, toItem: auxView, attribute: .centerX, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: self.checkBoxTick, attribute: .centerY, relatedBy: .equal, toItem: auxView, attribute: .centerY, multiplier: 1, constant: 0)
		]
		
		NSLayoutConstraint.activate(constraints)
		
		self.defaultConfiguration(self)
		self.configuration?(self)
	}
	
	public func setCheckBox(_ boxImage : UIImage?, checkImage : UIImage?) {
		if self.checkBoxStyle == .custom {
			self.checkBox.image = boxImage
			(self.checkBoxTick).image = checkImage
			if boxImage != nil {
				setLayerOfView(self.checkBox)
			} else {
				setLayerOfView(self.checkBox, 6, self.defaultTextColor.cgColor, 4)
			}
		}
	}
	
	private func setLayerOfView(_ view : UIView, _ borderWidth : CGFloat = 0, _ borderColor: CGColor = UIColor.clear.cgColor, _ cornerRadius : CGFloat = 0) {
		self.checkBox.layer.borderWidth = borderWidth
		self.checkBox.layer.borderColor = borderColor
		self.checkBox.layer.cornerRadius = cornerRadius
	}
	
	override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.isChecked = !self.isChecked
		self.checkBoxTick.backgroundColor = self.isChecked ? defaultCheckedColor : .clear
	}
}
