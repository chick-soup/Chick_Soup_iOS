//
//  FriendViewController.swift
//  Kakaotalk_CloneCoding
//
//  Created by DohyunKim on 27/11/2019.
//  Copyright © 2019 DohyunKim. All rights reserved.
//

import UIKit


class FriendViewController: UIViewController {
    let friendListUrl = URL(string: "http://chicksoup.s3.ap-northeast-2.amazonaws.com/users/my/friends")
    var friendListData = FriendListCell()
    var ListData: Any = [[String: [String: Any]]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bringFriendData()
        
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
    
    func bringFriendData() {
        
        
        
        var request = URLRequest(url: friendListUrl!)
        
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
                
                self!.ListData = [jsonSerialization]
                self!.FriendListIDIndexing()
                self!.FriendListMuteIndexing()
                self!.FriendListHiddenIndexing()
                self!.FriendListBookmarkIndexing()
                self!.FriendListNickNameIndexing()
                self!.FriendListStatusMessageIndexing()
                
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
    
    func FriendListIDIndexing() {
        let ListdataArray: Array = [ListData]
        for i in ListdataArray {
            friendListData.friendListID = String("\(i as! [String:Any]).values[\"id\"]")
            friendListPhotoID = String("\(i as! [String:Any]).values[\"id\"]")
            }
        }
    func FriendListNickNameIndexing() {
        let ListdataArray: Array = [ListData]
        for i in ListdataArray {
             friendListData.friendListNickName = String("\(i as! [String:Any]).values[\"nickname\"]")
        }
       
        
    }
    func FriendListStatusMessageIndexing() {
        let ListdataArray: Array = [ListData]
        for i in ListdataArray {
            friendListData.friendListStatusMessage = String("\(i as! [String:Any]).values[\"status_message\"]")
        }
    }
        func FriendListMuteIndexing() {
            let ListdataArray: Array = [ListData]
            for i in ListdataArray {
                friendListData.friendListMute = String("\(i as! [String:Any]).values[\"mute\"]")
            }
        }
    func FriendListHiddenIndexing() {
        let ListdataArray: Array = [ListData]
        for i in ListdataArray {
            friendListData.friendListHidden = String("\(i as! [String:Any]).values[\"hidden\"]")
        }
    }
    func FriendListBookmarkIndexing() {
           let ListdataArray: Array = [ListData]
           for i in ListdataArray {
               friendListData.friendListBookmark = String("\(i as! [String:Any]).values[\"bookmark\"]")
           }
    }


}
