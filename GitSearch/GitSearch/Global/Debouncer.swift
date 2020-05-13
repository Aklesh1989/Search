//
//  Debouncer.swift
//  GitSearch
//
//  Created by Aklesh Rathaur on 12/05/20.
//  Copyright © 2020 Aklesh Rathaur. All rights reserved.
//

import UIKit

class Debouncer: NSObject {
	var callback: (() -> ())
	var delay: Double
	weak var timer: Timer?
	
	init(delay: Double, callback: @escaping (() -> ())) {
		self.delay = delay
		self.callback = callback
	}
	
	func call() {
		timer?.invalidate()
		let nextTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(Debouncer.fireNow), userInfo: nil, repeats: false)
		timer = nextTimer
	}
	
	@objc func fireNow() {
		self.callback()
	}
}
