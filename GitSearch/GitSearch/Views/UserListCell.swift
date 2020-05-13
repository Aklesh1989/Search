//
//  UserListCell.swift
//  GitSearch
//
//  Created by Aklesh Rathaur on 12/05/20.
//  Copyright © 2020 Aklesh Rathaur. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {
	
	@IBOutlet weak var imgUserPic: UIImageView!
	@IBOutlet weak var lblName: UILabel!
	@IBOutlet weak var lblRepoCount: UILabel!
	var user:User! {
		didSet {
			configureDisplay()
		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	func configureDisplay() {
		if let userObject = user {
			lblName.text = userObject.name
			downloadUserImage()
			getRepoCount()
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
	
	func getRepoCount()  {
		if let text = lblRepoCount.text, !text.isEmpty {
			return
		}
		user.getUserRepoCount { (value, error) in
			DispatchQueue.main.async {
				if let count = value {
					self.lblRepoCount.text = "Repo:\(count)"
				} else {
					self.lblRepoCount.text = "Repo:0"
				}
			}
		}
		
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
