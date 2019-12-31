//
//  Friendlist.swift
//  Kakaotalk_CloneCoding
//
//  Created by DohyunKim on 2019/12/26.
//  Copyright © 2019 DohyunKim. All rights reserved.
//

import UIKit
class FriendListCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var statusMessage: UILabel!
    
    var friendlist: FriendList = FriendList()
    
    
    
    
}

class FriendList: FriendListCell {
    
    var friendCell: UITableViewCell {
        userImage.image = UIImage()
        nickName.text = ""
        statusMessage.text = ""
        return UITableViewCell()
    }
    
}


