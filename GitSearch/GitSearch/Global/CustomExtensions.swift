//
//  CustomExtensions.swift
//  GitSearch
//
//  Created by Aklesh Rathaur on 13/05/20.
//  Copyright © 2020 Aklesh Rathaur. All rights reserved.
//

import UIKit



//MARK:- Alert
extension UIViewController {
	
	func showAlert(title: String? = nil, message:String, cancelButtonTitle: String = "OK", handler: ((UIAlertAction) -> Swift.Void)? = nil) {
		var strTitle: String? = title
		var strMessage: String? = message
		
		if strTitle == nil {
			strTitle = message
			strMessage = nil
		}
		
		let alert = UIAlertController(title: strTitle,
																	message: strMessage,
																	preferredStyle: .alert)
		
		let action = UIAlertAction(title: cancelButtonTitle, style: .default, handler: handler)
		if #available(iOS 13.0, *) {
			// Always adopt a light interface style.
			alert.overrideUserInterfaceStyle = .light
		}
		
		alert.addAction(action)
		
		self.present(alert, animated: true, completion: nil)
	}
}



extension UISearchBar{
	
	@IBInspectable var doneAccessory: Bool{
		get{
			return self.doneAccessory
		}
		set (hasDone) {
			if hasDone{
				addDoneButtonOnKeyboard()
			}
		}
	}
	
	func addDoneButtonOnKeyboard()
	{
		let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
		doneToolbar.barStyle = .default
		
		let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
		
		let items = [flexSpace, done]
		doneToolbar.items = items
		doneToolbar.sizeToFit()
		
		self.inputAccessoryView = doneToolbar
	}
	
	@objc func doneButtonAction()
	{
		self.resignFirstResponder()
	}
}
