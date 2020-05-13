//
//  UserDetailVC.swift
//  GitSearch
//
//  Created by Aklesh Rathaur on 13/05/20.
//  Copyright © 2020 Aklesh Rathaur. All rights reserved.
//

import UIKit

class UserDetailVC: UIViewController {
	
	@IBOutlet weak var tblRepos: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var lblUserName: UILabel!
	@IBOutlet weak var lblUserFollowers: UILabel!
	@IBOutlet weak var lblUserFollowing: UILabel!
	@IBOutlet weak var imgUserPic: UIImageView!

	
	var arrayRepo = [Repo]()
	var user:User!

    override func viewDidLoad() {
        super.viewDidLoad()
			prepareView()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		displayUserDetails()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		self.view.endEditing(true)
	}
	
	func prepareView() {
		tblRepos.tableFooterView = UIView()
	}
	
	func displayUserDetails() {
		lblUserName.text = user.name
		downloadUserImage()
		getFollowerCount()
		getFollowingCount()
	}
	
	func getFollowerCount()  {
		user.getFollowersCount { (value, error) in
			DispatchQueue.main.async {
				self.lblUserFollowers.text = "\(self.user.followersCount) Followers"
				if let count = value {
					self.lblUserFollowers.text = "\(count) Followers"
				} else {
					self.lblUserFollowers.text = "0 Followers"
				}
			}
		}
	}
	
	func getFollowingCount()  {
		user.getFollowingCount { (value, error) in
			DispatchQueue.main.async {
				if let count = value {
					self.lblUserFollowing.text = "Following \(count)"
				} else {
					self.lblUserFollowing.text = "Following 0"
				}
			}
		}
	}
	
	func downloadUserImage()  {
		if let imgUrl = user.imageUrl, !imgUrl.isEmpty {
			print("image url is \(imgUrl)")
			downloadImage(from: imgUrl) { (image) in
				print("downloadImage done")
				if let imageFound = image {
					DispatchQueue.main.async {
						self.imgUserPic.image = imageFound
					}
				}
			}
		}
	}
	
	func filterRepoBasedOnSearch(query:String) {
		arrayRepo.removeAll()
		arrayRepo = user.repos.filter({ (repo) -> Bool in
			print("repo name is \(repo.name)")
			return repo.name.contains(query)
		})
		tblRepos.reloadData()
	}
	
    

}


//MARK:- SearchBar Delegate
extension UserDetailVC:UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		/*if let _ = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
			debouncedUpdateUser.call()
		}*/
		filterRepoBasedOnSearch(query: searchText)
		print("searchText \(searchText)")
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		print("searchText \(String(describing: searchBar.text))")
	}
	
}

//MARK:- TableView Delegate And DataSource

extension UserDetailVC:UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return arrayRepo.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "UserRepoCell", for: indexPath) as! UserRepoCell
		let repo = arrayRepo[indexPath.row]
		cell.repo = repo
		cell.selectionStyle = .none
		return cell
		
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
	
	
}
