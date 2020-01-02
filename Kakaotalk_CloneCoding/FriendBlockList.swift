//
//  FriendBlockList.swift
//  Kakaotalk_CloneCoding
//
//  Created by DohyunKim on 2019/12/31.
//  Copyright © 2019 DohyunKim. All rights reserved.
//

import Foundation
import UIKit

var friendBlockListPhotoID: String = ""
var friendBlockListProfileImage : UIImage = UIImage(imageLiteralResourceName: "http://chicksoup.s3.ap-northeast-2.amazonaws.com//media/image/user/profile/\(friendBlockListPhotoID).png")

class friendBlockListCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var friendBlockListImageOutlet: UIImageView!
    @IBOutlet weak var friendBlockListNickNameOutlet: UILabel!
    @IBOutlet weak var friendBlockListStatusMessageOutlet: UILabel!
    
    var friendBlockListID: String = ""
    var friendBlockListNickName: String = ""
    var friendBlockListStatusMessage: String = ""
    var friendBlockListMute: String = ""
    var friendBlockListHidden: String = ""
    var friendBlockListBookMark: String = ""
    
    var friendblockList: friendBlockList = friendBlockList()
    
    
}

class friendBlockList: friendBlockListCell {
    
    var friendBlockCell: UITableViewCell {
        
        friendBlockListImageOutlet.image = UIImage()
        friendBlockListNickNameOutlet.text = friendBlockListNickName
        friendBlockListStatusMessageOutlet.text = friendBlockListStatusMessage
        return UITableViewCell()
    }
    
}
