//
//  IDCheckViewController.swift
//  Kakaotalk_CloneCoding
//
//  Created by DohyunKim on 28/11/2019.
//  Copyright © 2019 DohyunKim. All rights reserved.
//

import UIKit


class IDCheckViewController: UIViewController {
    
    @IBOutlet weak var IDCheckView: UIView!
    
    @IBOutlet weak var txtIdCheck: UILabel!
    
    override func viewDidLoad() {
        IDCheckView.layer.cornerRadius = 7
        txtIdCheck.text! = UserDefaults.standard.string(forKey: "kakao_id")!
        
        //kakao-id 안들어오면 UserDefaults에 추가했는지 확인하기!
        
        super.viewDidLoad()
    }
}
