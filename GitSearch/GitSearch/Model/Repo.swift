//
//  Repo.swift
//  GitSearch
//
//  Created by Aklesh Rathaur on 13/05/20.
//  Copyright © 2020 Aklesh Rathaur. All rights reserved.
//

import UIKit

class Repo: NSObject {
	
/*	"stargazers_count": 0,
	"watchers_count": 0,
	"name": "11ty-website",
	"language": null,
	"has_issues": false,
	"has_projects": true,
	"has_downloads": true,
	"has_wiki": false,
	"has_pages": false,
	"forks_count": 0,*/
	
	struct Key
	{
		fileprivate static let name  = "name"
		fileprivate static let forksCount = "forks_count"
		fileprivate static let stargazersCount  = "stargazers_count"
	}
	var name:String!
	var forksCount:Int!
	var stargazersCount:Int!
	
	override init(){}
	
	init(fromDictionary dictionary: [String:Any]) {
		forksCount = dictionary[Key.forksCount] as? Int ?? 0
		name = dictionary[Key.name] as? String
		stargazersCount = dictionary[Key.stargazersCount] as? Int ?? 0
	}

}
