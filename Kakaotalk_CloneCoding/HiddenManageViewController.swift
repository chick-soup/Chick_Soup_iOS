//
//  HiddenManageViewController.swift
//  Kakaotalk_CloneCoding
//
//  Created by DohyunKim on 2020/01/02.
//  Copyright © 2020 DohyunKim. All rights reserved.
//

import UIKit

class HiddenManageViewController: UIViewController {
    
    let friendHiddenListUrl = URL(string: "http://chicksoup.s3.ap-northeast-2.amazonaws.com/users/my/friends/hidden")
    var friendHiddenData = friendHiddenListCell()
    var HiddenListData: Any = [[String: [String: Any]]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        bringHiddenData()
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
    
    func bringHiddenData() {
        
        
        
        var request = URLRequest(url: friendHiddenListUrl!)
        
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
                
                self!.HiddenListData = [jsonSerialization]
                self!.FriendHiddenListBookmarkIndexing()
                self!.FriendHiddenListHiddenIndexing()
                self!.FriendHiddenListIDIndexing()
                self!.FriendHiddenListMuteIndexing()
                self!.FriendHiddenListNickNameIndexing()
                self!.FriendHiddenListStatusMessageIndexing()
                print("친구 숨김 정보 반환 성공")
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
    
    func FriendHiddenListIDIndexing() {
        let ListdataArray: Array = [HiddenListData]
        for i in ListdataArray {
            friendHiddenData.friendHiddenListID = String("\(i as! [String:Any]).values[\"id\"]")
            friendHiddenListPhotoID = String("\(i as! [String:Any]).values[\"id\"]")
        }
    }
    
    func FriendHiddenListNickNameIndexing() {
        let ListdataArray: Array = [HiddenListData]
        for i in ListdataArray {
            friendHiddenData.friendHiddenListNickName = String("\(i as! [String:Any]).values[\"nickname\"]")
        }
    }
    func FriendHiddenListStatusMessageIndexing() {
        let ListdataArray: Array = [HiddenListData]
        for i in ListdataArray {
            friendHiddenData.friendHiddenListStatusMessage = String("\(i as! [String:Any]).values[\"status_message\"]")
        }
    }
    func FriendHiddenListMuteIndexing() {
        let ListdataArray: Array = [HiddenListData]
        for i in ListdataArray {
            friendHiddenData.friendHiddenListMute = String("\(i as! [String:Any]).values[\"mute\"]")
        }
    }
    func FriendHiddenListHiddenIndexing() {
        let ListdataArray: Array = [HiddenListData]
        for i in ListdataArray {
            friendHiddenData.friendHiddenListHidden = String("\(i as! [String:Any]).values[\"hidden\"]")
        }
    }
    func FriendHiddenListBookmarkIndexing() {
        let ListdataArray: Array = [HiddenListData]
        for i in ListdataArray {
            friendHiddenData.friendHiddenListBookMark = String("\(i as! [String:Any]).values[\"bookmark\"]")
        }
    }
}

