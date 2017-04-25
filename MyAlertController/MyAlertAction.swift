//
//  MyAlertAction.swift
//  MyAlertController
//
//  Created by Vitor Carrasco on 11/04/17.
//  Copyright © 2017 Empresinha. All rights reserved.
//

import UIKit

public class MyAlertAction: NSObject {
	
	public enum MyAlertActionStyle : Int {
		case `default` = 0
		case cancel = 1
		case destructive = 2
	}
	
	public private(set) var title : String?
	public private(set) var style : MyAlertActionStyle = .default
	var isEnabled : Bool = true
	var action : ((MyAlertAction) -> Void)?
	
	public init(title: String?, style: MyAlertActionStyle, handler: ((MyAlertAction) -> Void)?) {
		super.init()
		self.title = title
		self.style = style
		self.action = handler
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func executeAction() {
		guard  let action = self.action else {return}
		action(self)
	}
}
