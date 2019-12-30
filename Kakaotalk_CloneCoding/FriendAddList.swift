//
//  FriendAddList.swift
//  Kakaotalk_CloneCoding
//
//  Created by DohyunKim on 2019/12/26.
//  Copyright © 2019 DohyunKim. All rights reserved.
//

import UIKit

class FriendAddListCell: UITableViewCell {
    
    
    var friendaddlist: FriendAddList = FriendAddList()
    
    
    
    
}



class FriendAddList: FriendListCell {

    @IBOutlet weak var friendAddImage: UIImageView!
    @IBOutlet weak var friendAddNickname: UILabel!
    @IBOutlet weak var friendAddStatusMessage: UILabel!
    
    var friendaddCell: UITableViewCell {
        friendAddImage.image = UIImage()
        friendAddNickname.text = ""
        friendAddStatusMessage.text = ""
        return UITableViewCell()
    }

}

