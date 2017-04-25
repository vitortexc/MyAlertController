//
//  MyAlertController.swift
//  MyAlertController
//
//  Created by Fernanda de Lima on 05/04/17.
//  Copyright © 2017 Empresinha. All rights reserved.
//

import UIKit

public class MyAlertController: UIViewController {
	
	public enum MyAlertControllerLayoutStyle {
		case vertical
		case horizontal
	}
	
	@IBOutlet private(set) weak var alertView: MyAlertView!
	@IBOutlet private weak var scrollView: UIScrollView!
	
	// Properties
	public private(set) var actions : [MyAlertAction]
	private var contents : [UIView]
	public private(set) var textFields : [UITextField]?
	public private(set) var tableViews : [UITableView]?
    public private(set) var label : [UILabel]?
	private var layoutStyle : MyAlertControllerLayoutStyle = .horizontal
	
	private let actionHeight : CGFloat = 40
	
	// Text Field properties
	fileprivate var activeField: UITextField?
	fileprivate var distanceMoved : CGFloat!
	
	public convenience init(title: String?, layoutStyle: MyAlertControllerLayoutStyle) {
		self.init()
		
		self.title = title
		self.layoutStyle = layoutStyle
	}
	
	private init() {
		actions = []
		contents = []
		
        super.init(nibName: "MyAlertController", bundle: Bundle(for: MyAlertController.self))
		
        self.modalPresentationStyle = .overFullScreen
		self.modalTransitionStyle = .crossDissolve
		self.providesPresentationContextTransitionStyle = true
		self.definesPresentationContext = true
    }
	
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
    override public func viewDidLoad() {
        super.viewDidLoad()
		
		self.alertView.titleLabel.text = self.title
		
		self.addObservers()
        // Do any additional setup after loading the view.
    }

	public override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		let alertHeightConstraint = self.alertView.constraint(withIdentifier: "AlertViewHeight")
		
		var actionsViewHeight : CGFloat = 40
		var contentHeight : CGFloat = 40
		
		for content in contents {
			switch content {
			case is UITextField:
				contentHeight += 40
				break
                
            case is UITableView:
                contentHeight += 130
                break
                
            case is UILabel:
                
                if let content = content as? UILabel {
                    let s = content.text?.widthOfString(usingFont: UIFont.systemFont(ofSize: UIFont.systemFontSize - 2))

                    content.numberOfLines = Int(s! / (self.alertView.frame.width * 0.85)) + 1
                    contentHeight += CGFloat(30 * content.numberOfLines + 10)
                    
                }

                break
                
			default:
				contentHeight += content.frame.height
				break
			}
		}
		
		if self.layoutStyle == .vertical {
			let actionHeightConstraint = self.alertView.actionsView.constraint(withIdentifier: "ActionsViewHeight")
			
			actionsViewHeight = actionHeight * CGFloat(self.actions.count)
			
			let count = CGFloat(self.actions.count)
			
			actionHeightConstraint?.constant = actionHeight * count + (count == 0 ? 0 : 0.5 * count)
			
		}
		
		let totalHeight = contentHeight + actionsViewHeight
		alertHeightConstraint?.constant = totalHeight
		
		self.alertView.setNeedsLayout()
		self.alertView.layoutIfNeeded()
	}
	
	override public func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		self.alertView.layer.cornerRadius = max(self.alertView.frame.size.height,self.alertView.frame.size.width)*CGFloat(0.03)
		
		// Remove views if there is any (probably not)
		for i in self.alertView.contentView.subviews.dropFirst() {
			i.removeFromSuperview()
		}
		
		for i in self.alertView.actionsView.subviews {
			i.removeFromSuperview()
		}
		// ----------------------- //
		
		// For each content in contents list
		// add it to the contentView ans set it depending on the type
		var contentY : CGFloat = 30
		
		for content in contents {
			switch content {
			case is UITextField:
				content.frame = CGRect(x: 0, y: 0, width: self.alertView.frame.width * 0.9, height: 30)
				break
                
            case is UITableView:
                content.frame = CGRect(x: 0, y: 0, width: self.alertView.frame.width * 0.9, height: 120)
                break
                
            case is UILabel:
                if let content = content as? UILabel {
                    let s = content.text?.widthOfString(usingFont: UIFont.systemFont(ofSize: UIFont.systemFontSize - 2))
                    let h = (content.text?.heightOfString(usingFont: UIFont.systemFont(ofSize: UIFont.systemFontSize)))! + 5
              
                    content.numberOfLines = Int(s! / (self.alertView.frame.width * 0.85)) + 1
                    content.textAlignment = .center
                    content.frame = CGRect(x: 0, y: 0, width: (self.alertView.frame.width * 0.9), height: h * CGFloat(content.numberOfLines))
                }

                
                break
                
			default:
				break
			}
            
            content.center = CGPoint(x: self.alertView.frame.size.width/2, y: CGFloat(contentY) + (content.frame.size.height/2))
            contentY += content.frame.size.height + 10
            self.alertView.contentView.addSubview(content)
		}
		
		let actionHeightConstraint = self.alertView.actionsView.constraint(withIdentifier: "ActionsViewHeight")
		
		self.alertView.actionsView.frame = CGRect(x: self.alertView.actionsView.frame.minX, y: self.alertView.actionsView.frame.minY, width: self.alertView.frame.size.width, height: actionHeightConstraint!.constant)
		
		for action in actions {
			let index = CGFloat(actions.index(of: action)!)
			let count = CGFloat(actions.count)
			
			let actionWidth = (self.layoutStyle == .horizontal ? self.alertView.actionsView.frame.size.width / count - 0.5 : self.alertView.actionsView.frame.size.width + 2)
			let actionHeight = (self.actionHeight)
			let actionX = (self.layoutStyle == .horizontal ? actionWidth * index + (0.5 * (index + 1)) : -0.5)
			let actionY = (self.layoutStyle == .horizontal ? 0.5 : index * actionHeight + (0.5 * (index + 1)))
			
			let button = UIButton(frame: CGRect(x: actionX, y: actionY, width: actionWidth, height: actionHeight))
			
			button.addTarget(action, action: #selector(action.executeAction), for: .touchUpInside)
			button.addTarget(nil, action: #selector(MyAlertController.close), for: .touchUpInside)
			
			button.setTitle(action.title, for: .normal)
			button.setTitleColor(.darkGray, for: .normal)
			
			button.clipsToBounds = true
			
			button.backgroundColor = UIColor.white
			
			self.alertView.actionsView.addSubview(button)
		}
	}

	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	public override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	public override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		removeObservers()
	}
	
	public override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
	}
	
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		dismissKeyboard()
		self.view.endEditing(true)
	}
	
	// MARK: Alert config methods
	public func addAction(_ action: MyAlertAction) {
		self.actions.append(action)
	}
	
	public func addTextField(configurationHandler: ((UITextField) -> Void)? = {textField in textField.borderStyle = .roundedRect}) {
		if textFields == nil {
			textFields = []
		}

		let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
		textField.delegate = self
		
		configurationHandler?(textField)
		
		self.contents.append(textField)
		self.textFields?.append(textField)
	}
	
	public func addTableView(_ tableView : UITableView) {
		if tableViews == nil {
			self.tableViews = []
		}

		self.contents.append(tableView)
		self.tableViews?.append(tableView)
	}
    
    public func addMessage(msg: String){
   
        let message = UILabel(frame: CGRect.zero)
        message.text = msg
        message.lineBreakMode = .byWordWrapping
        message.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 2)
        
        self.contents.append(message)
        self.label?.append(message)
       
    }
	
	// MARK: Internal methods
	private func addObservers() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: view.window)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: view.window)
	}
	
	private func removeObservers() {
		NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: view.window)
		NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: view.window)
	}
	
	@objc private func keyboardWillHide(_ notification: Notification) {
		var info = notification.userInfo!
		let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
		let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
		self.scrollView.contentInset = contentInsets
		self.scrollView.scrollIndicatorInsets = contentInsets
		self.view.endEditing(true)
		self.scrollView.isScrollEnabled = false
	}
	
	@objc private func keyboardWillShow(_ notification: Notification) {
		self.scrollView.isScrollEnabled = true
		var info = notification.userInfo!
		let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
		let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
		
		self.scrollView.contentInset = contentInsets
		self.scrollView.scrollIndicatorInsets = contentInsets
		
		var aRect : CGRect = self.view.frame
		aRect.size.height -= keyboardSize!.height
		if let activeField = self.activeField {
			if (!aRect.contains(activeField.frame.origin)){
				self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
			}
		}
	}
	
	func dismissKeyboard () {
		self.view.endEditing(true)
	}
	
	@objc private func close() {
		self.activeField?.resignFirstResponder()
		self.dismiss(animated: true, completion: nil)
	}
}

extension MyAlertController: UITextFieldDelegate {
	
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
	
	public func textFieldDidBeginEditing(_ textField: UITextField) {
		self.activeField = textField
	}
	
	public func textFieldDidEndEditing(_ textField: UITextField) {
		self.activeField = nil
	}
}

extension MyAlertController : UITextViewDelegate {
	
}

extension CGFloat {
	static func random() -> CGFloat {
		return CGFloat(arc4random()) / CGFloat(UInt32.max)
	}
}

extension UIColor {
	static func random() -> UIColor {
		return UIColor(red:   .random(),
		               green: .random(),
		               blue:  .random(),
		               alpha: .random())
	}
}

extension UIView {
	func constraint(withIdentifier id: String) -> NSLayoutConstraint? {
		let constraint = self.constraints.filter {$0.identifier == id}.first
		
		if constraint == nil {
			print("No constraint found with \'\(id)\' identifier.")
		}
		
		return constraint
	}
}

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.height
    }
}
