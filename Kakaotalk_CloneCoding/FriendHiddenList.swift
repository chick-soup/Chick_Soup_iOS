//
//  FriendHideList.swift
//  Kakaotalk_CloneCoding
//
//  Created by DohyunKim on 2020/01/02.
//  Copyright © 2020 DohyunKim. All rights reserved.
//

import Foundation
import UIKit

var friendHiddenListPhotoID: String = ""
var friendHiddenListProfileImage : UIImage = UIImage(imageLiteralResourceName: "http://chicksoup.s3.ap-northeast-2.amazonaws.com//media/image/user/profile/\(friendHiddenListPhotoID).png")

class friendHiddenListCell: UITableViewCell {
    
    @IBOutlet weak var friendHiddenListImageOutlet: UIImageView!
    @IBOutlet weak var friendHiddenListNickNameOutlet: UILabel!
    @IBOutlet weak var friendHiddenListStatusMessageOutlet: UILabel!
    
    var friendHiddenListID: String = ""
    var friendHiddenListNickName: String = ""
    var friendHiddenListStatusMessage: String = ""
    var friendHiddenListMute: String = ""
    var friendHiddenListHidden: String = ""
    var friendHiddenListBookMark: String = ""
    
    var friendblockList: friendBlockList = friendBlockList()
    
}

class friendHiddenList: friendHiddenListCell {
    
    var friendHiddenCell: UITableViewCell {
        
        friendHiddenListImageOutlet.image = friendHiddenListProfileImage
        friendHiddenListNickNameOutlet.text = friendHiddenListNickName
        friendHiddenListStatusMessageOutlet.text = friendHiddenListStatusMessage
        return UITableViewCell()
        
    }
}
