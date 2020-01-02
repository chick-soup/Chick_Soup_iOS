//
//  BlockManageViewController.swift
//  Kakaotalk_CloneCoding
//
//  Created by DohyunKim on 28/11/2019.
//  Copyright © 2019 DohyunKim. All rights reserved.
//

import UIKit


class BlockManageViewController: UIViewController {
    
    let friendBlockListUrl = URL(string: "http://chicksoup.s3.ap-northeast-2.amazonaws.com/users/my/friends/mute")
    var friendBlockData = friendBlockListCell()
    var BlockListData: Any = [[String: [String: Any]]]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        bringBlockData()
    }
    
    func tokenRefresh() {
        
        var request = URLRequest(url: refreshUrl!)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "access_token")
        request.addValue("Authorization", forHTTPHeaderField: String(UserDefaults.standard.string(forKey :"refresh_token")!))
        
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request){
            [weak self] data, res, err in
            guard self != nil else { return }
            if let err = err { print(err.localizedDescription); return }
            print((res as! HTTPURLResponse).statusCode)
            switch (res as! HTTPURLResponse).statusCode{
            case 200:
                let jsonSerialization = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                print(jsonSerialization)
                
                UserDefaults.standard.set(jsonSerialization["access_token"], forKey: "access_token")
                
            case 401:
                print("request의 header에 Authorization으로 JWT를 포함하지 않았거나 빈 문자열을 줌")
                
                
                
            case 404:
                print("JWT로 인증된 사용자가 실제로는 존재하지 않음")
                
            case 422:
                print("서버에서 해석할 수 없는 잘못된 형식의 JWT or 다른 타입의 토큰을 넘겨 줌")
                
            default:
                print("error")
            }
        }.resume()
    }
    
    func bringBlockData() {
        
        
        
        var request = URLRequest(url: friendBlockListUrl!)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "access_token")
        request.addValue("Authorization", forHTTPHeaderField: String(UserDefaults.standard.string(forKey :"access_token")!))
        
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request){
            [weak self] data, res, err in
            guard self != nil else { return }
            if let err = err { print(err.localizedDescription); return }
            print((res as! HTTPURLResponse).statusCode)
            switch (res as! HTTPURLResponse).statusCode{
            case 200:
                let jsonSerialization = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                print(jsonSerialization)
                
                self!.BlockListData = [jsonSerialization]
                self!.FriendBlockListBookmarkIndexing()
                self!.FriendBlockListHiddenIndexing()
                self!.FriendBlockListIDIndexing()
                self!.FriendBlockListMuteIndexing()
                self!.FriendBlockListNickNameIndexing()
                self!.FriendBlockListStatusMessageIndexing()
                print("내 친구 정보 반환 성공")
            case 401:
                print("request의 header에 Authorization으로 JWT를 포함하지 않았거나 빈 문자열을 줌")
                
            case 403:
                print("사용 가능 기간이 만료된 JWT")
                self!.tokenRefresh()
                
            case 404:
                print("JWT로 인증된 사용자가 실제로는 존재하지 않음")
                
            case 422:
                print("서버에서 해석할 수 없는 잘못된 형식의 JWT or 다른 타입의 토큰을 넘겨 줌")
                
            default:
                print("error")
            }
        }.resume()
        
    }
    
    func FriendBlockListIDIndexing() {
    let ListdataArray: Array = [BlockListData]
    for i in ListdataArray {
        friendBlockData.friendBlockListID = String("\(i as! [String:Any]).values[\"id\"]")
        friendBlockListPhotoID = String("\(i as! [String:Any]).values[\"id\"]")
        }
    }
    
    func FriendBlockListNickNameIndexing() {
    let ListdataArray: Array = [BlockListData]
    for i in ListdataArray {
         friendBlockData.friendBlockListNickName = String("\(i as! [String:Any]).values[\"nickname\"]")
    }
}
    func FriendBlockListStatusMessageIndexing() {
        let ListdataArray: Array = [BlockListData]
        for i in ListdataArray {
            friendBlockData.friendBlockListStatusMessage = String("\(i as! [String:Any]).values[\"status_message\"]")
        }
    }
    func FriendBlockListMuteIndexing() {
            let ListdataArray: Array = [BlockListData]
            for i in ListdataArray {
                friendBlockData.friendBlockListMute = String("\(i as! [String:Any]).values[\"mute\"]")
            }
        }
    func FriendBlockListHiddenIndexing() {
        let ListdataArray: Array = [BlockListData]
        for i in ListdataArray {
            friendBlockData.friendBlockListHidden = String("\(i as! [String:Any]).values[\"hidden\"]")
        }
    }
    func FriendBlockListBookmarkIndexing() {
           let ListdataArray: Array = [BlockListData]
           for i in ListdataArray {
               friendBlockData.friendBlockListBookMark = String("\(i as! [String:Any]).values[\"bookmark\"]")
           }
    }
}
