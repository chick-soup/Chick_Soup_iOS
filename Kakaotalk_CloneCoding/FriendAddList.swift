//
//  FriendAddList.swift
//  Kakaotalk_CloneCoding
//
//  Created by DohyunKim on 2019/12/26.
//  Copyright © 2019 DohyunKim. All rights reserved.
//

import UIKit

var friendAddId : String = ""
var friendAddNickName : String = ""
var friendAddRelate : String = ""

class FriendAddListCell: UITableViewCell {
    
    
    var friendaddlist: FriendAddList = FriendAddList()
    
    
    
    
}

func relateConvertor() -> String {
    <#function body#>
}


class FriendAddList: FriendListCell {

    @IBOutlet weak var friendAddImage: UIImageView!
    @IBOutlet weak var friendAddNickname: UILabel!
    @IBOutlet weak var friendAddStatusMessage: UILabel!
    @IBOutlet weak var btnRelate: UIButton!
    
    var friendaddCell: UITableViewCell {
        friendAddImage.image = UIImage()
        friendAddNickname.text = friendAddNickName
        btnRelate.setTitle("", for: .normal)
        return UITableViewCell()
    }

}

