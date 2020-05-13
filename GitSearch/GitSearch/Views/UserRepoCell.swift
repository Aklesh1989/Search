//
//  UserRepoCell.swift
//  GitSearch
//
//  Created by Aklesh Rathaur on 13/05/20.
//  Copyright © 2020 Aklesh Rathaur. All rights reserved.
//

import UIKit

class UserRepoCell: UITableViewCell {
	@IBOutlet weak var lblName: UILabel!
	@IBOutlet weak var lblFork: UILabel!
	@IBOutlet weak var lblStar: UILabel!
	var repo:Repo! {
		didSet {
			configureDisplay()
		}
	}
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
	
	func configureDisplay() {
		if let currentRepo = repo {
			lblName.text = currentRepo.name
			lblFork.text = "\(currentRepo.forksCount!) Forks"
			lblStar.text = "\(currentRepo.stargazersCount!) Stars"
		}
	}

}
