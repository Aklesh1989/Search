//
//  User.swift
//  GitSearch
//
//  Created by Aklesh Rathaur on 12/05/20.
//  Copyright © 2020 Aklesh Rathaur. All rights reserved.
//

import UIKit

class User: NSObject {
	
	/*
	"avatar_url" = "https://avatars3.githubusercontent.com/u/145676?v=4";
	"events_url" = "https://api.github.com/users/tomayac/events{/privacy}";
	"followers_url" = "https://api.github.com/users/tomayac/followers";
	"following_url" = "https://api.github.com/users/tomayac/following{/other_user}";
	"gists_url" = "https://api.github.com/users/tomayac/gists{/gist_id}";
	"gravatar_id" = "";
	"html_url" = "https://github.com/tomayac";
	id = 145676;
	login = tomayac;
	"node_id" = "MDQ6VXNlcjE0NTY3Ng==";
	"organizations_url" = "https://api.github.com/users/tomayac/orgs";
	"received_events_url" = "https://api.github.com/users/tomayac/received_events";
	"repos_url" = "https://api.github.com/users/tomayac/repos";
	score = 1;
	"site_admin" = 0;
	"starred_url" = "https://api.github.com/users/tomayac/starred{/owner}{/repo}";
	"subscriptions_url" = "https://api.github.com/users/tomayac/subscriptions";
	type = User;
	url = "https://api.github.com/users/tomayac";
	**/
	struct Key
	{
		fileprivate static let userId  = "id"
		fileprivate static let login = "login"
		fileprivate static let imageUrl  = "avatar_url"
	}
	var name:String!
	var userID:String!
	var imageUrl:String!
	var repoCount:Int = 0
	var followersCount:Int = 0
	var followingCount:Int = 0
	var repos = [Repo]()

	//var followersUrl:String
	
	override init() {
		
	}
	
	init(fromDictionary dictionary: [String:Any]) {
		userID = dictionary[Key.userId] as? String
		name = dictionary[Key.login] as? String
		imageUrl = dictionary[Key.imageUrl] as? String
	}
	
	
	
	
	class func getUserList(query:String,completion: @escaping ([User]?, Error?) -> Void) {
		let urlPath = WebCallPath.GetUserList
		let method = WebCallType.get
		let queryParam = ["q":query]
		_ = sharedWebCallHelper.callWebService(withUrlStr: urlPath, httpMethod: method, queryParams: queryParam, bodyParams: nil, withCompletionHandler: { (response, error) in
			if let jsonObject = response {
				print("jsonObject is \(jsonObject)")
				if let array = jsonObject["items"] as? [[String:Any]], array.count > 0 {
					let data = array.map { (object) -> User in
						return User(fromDictionary: object)
					}
					completion(data, nil)
				} else {
					completion(nil, nil)
				}

			}else {
				completion(nil, error)
			}
			
		})
	}
	
	 func getUserRepoCount(completion: @escaping (Int?, Error?) -> Void) {
		let urlPath = WebCallPath.User + "/" + self.name + "/repos"
		let method = WebCallType.get
		_ = sharedWebCallHelper.callWebService(withUrlStr: urlPath, httpMethod: method, queryParams: nil, bodyParams: nil, withCompletionHandler: { (response, error) in
			if let jsonObject = response {
				print("getUserRepoCount jsonObject is \(jsonObject)")
				if let array = jsonObject["Data"] as? [[String:Any]] {
					self.repos = array.map({ (object) -> Repo in
						return Repo(fromDictionary: object)
					})
					self.repoCount = array.count
					completion(array.count, nil)
				} else {
					completion(0, nil)
				}
				
			}else {
				completion(nil, error)
			}
			
		})
	}
	
	func getFollowersCount(completion: @escaping (Int?, Error?) -> Void) {
		let urlPath = WebCallPath.User + "/" + self.name + "/followers"
		let method = WebCallType.get
		_ = sharedWebCallHelper.callWebService(withUrlStr: urlPath, httpMethod: method, queryParams: nil, bodyParams: nil, withCompletionHandler: { (response, error) in
			if let jsonObject = response {
				print("getUserRepoCount jsonObject is \(jsonObject)")
				if let array = jsonObject["Data"] as? [[String:Any]] {
					self.followersCount = array.count
					completion(array.count, nil)
					
				} else {
					completion(0, nil)
				}
				
			}else {
				completion(nil, error)
			}
			
		})
	}
	
	func getFollowingCount(completion: @escaping (Int?, Error?) -> Void) {
		let urlPath = WebCallPath.User + "/" + self.name + "/following"
		let method = WebCallType.get
		_ = sharedWebCallHelper.callWebService(withUrlStr: urlPath, httpMethod: method, queryParams: nil, bodyParams: nil, withCompletionHandler: { (response, error) in
			if let jsonObject = response {
				print("getUserRepoCount jsonObject is \(jsonObject)")
				if let array = jsonObject["Data"] as? [[String:Any]] {
					self.followingCount = array.count
					completion(array.count, nil)
				} else {
					completion(0, nil)
				}
				
			}else {
				completion(nil, error)
			}
			
		})
	}

}
