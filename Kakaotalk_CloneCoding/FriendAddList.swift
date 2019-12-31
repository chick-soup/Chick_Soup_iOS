//
//  FriendAddList.swift
//  Kakaotalk_CloneCoding
//
//  Created by DohyunKim on 2019/12/26.
//  Copyright © 2019 DohyunKim. All rights reserved.
//

import UIKit

var friendAddId: String = ""
var friendAddNickName: String = ""
var friendAddRelate: String = ""

var friendAddProfileImage : UIImage = UIImage(imageLiteralResourceName: "http://chicksoup.s3.ap-northeast-2.amazonaws.com//media/image/user/profile/\(String(friendAddId)).png")

class FriendAddListCell: UITableViewCell {
    
    
    var friendaddlist: FriendAddList = FriendAddList()
    
    
    
    
}

func relateConvertor() -> String {
    switch friendAddRelate {
    case "0":
        return String("추가")
    case "1":
        return String("수락대기")
    case "2":
        return String("수락")
    case "3":
        return String("친구")
    default:
        return String("오류")
    }
}


class FriendAddList: FriendListCell {
    
    @IBOutlet weak var friendAddImage: UIImageView!
    @IBOutlet weak var friendAddNickname: UILabel!
    @IBOutlet weak var friendAddStatusMessage: UILabel!
    @IBOutlet weak var btnRelate: UIButton!
    
    var friendaddCell: UITableViewCell {
        friendAddImage.image = friendAddProfileImage
        friendAddNickname.text = friendAddNickName
        btnRelate.setTitle(relateConvertor(), for: .normal)
        return UITableViewCell()
    }
    
}

