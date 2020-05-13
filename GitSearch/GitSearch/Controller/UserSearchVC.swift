//
//  UserSearchVC.swift
//  GitSearch
//
//  Created by Aklesh Rathaur on 12/05/20.
//  Copyright © 2020 Aklesh Rathaur. All rights reserved.
//

import UIKit

class UserSearchVC: UIViewController {
	
	@IBOutlet weak var tblUsers: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!

	var arrayUser = [User]()
	var debouncedUpdateUser: Debouncer!
	var currentSelectedIndex = 0
	
    override func viewDidLoad() {
        super.viewDidLoad()
			debouncedUpdateUser = Debouncer(delay: 0.3) {
				self.getUserList()
			}
			prepareView()

    }

	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "ListToDetail" {
			let user = arrayUser[currentSelectedIndex]
			let detailVC = segue.destination as! UserDetailVC
			detailVC.user = user
		}
	}
	
	func prepareView() {
		tblUsers.tableFooterView = UIView()
	}

}
//MARK:- Web services
extension UserSearchVC {
	func getUserList() {
		if let query = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
			User.getUserList(query: query) { (users, error) in
				if let array = users, array.count > 0 {
					self.arrayUser.removeAll()
					self.arrayUser.append(contentsOf: array)
					self.tblUsers.reloadData()
				} else if let errorMsg = error?.localizedDescription {
					self.showAlert(message: errorMsg)
				}
			}
		}
		
	}
	
}

//MARK:- SearchBar Delegate
extension UserSearchVC:UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if let _ = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
			debouncedUpdateUser.call()
		}
		print("searchText \(searchText)")
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		print("searchText \(String(describing: searchBar.text))")
	}
	
}

//MARK:- TableView Delegate And DataSource

extension UserSearchVC:UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return arrayUser.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as! UserListCell
		let user = arrayUser[indexPath.row]
		cell.user = user
		//cell.configureDisplay()
		cell.selectionStyle = .none
		return cell

	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.view.endEditing(true)
		currentSelectedIndex = indexPath.row
		self.performSegue(withIdentifier: "ListToDetail", sender: nil)
	}
	
	
}
