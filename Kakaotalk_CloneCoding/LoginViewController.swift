//
//  ViewController.swift
//  Kakaotalk_CloneCoding
//
//  Created by DohyunKim on 27/11/2019.
//  Copyright © 2019 DohyunKim. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    let mainUrl =  URL(string: "http://chicksoup.s3.ap-northeast-2.amazonaws.com/")
    let loginUrl = URL(string: "http://chicksoup.s3.ap-northeast-2.amazonaws.com/login")
    let kakaoUrl = URL(string: "http://chicksoup.s3.ap-northeast-2.amazonaws.com/users/my/kakao-id")
    
    
    
    @IBOutlet weak var txtID: UITextField!
    
    @IBOutlet weak var txtPW: UITextField!
    
    @IBOutlet weak var idView: UIView!
    
    @IBOutlet weak var pwView: UIView!
    
    override func viewDidLoad() {
        idView.layer.cornerRadius = 15
        pwView.layer.cornerRadius = 15
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        login()
        bringKakaoId()
    }
    
    func login() {
        let parameters = ["email": txtID.text!, "password": txtPW.text!]
        var request = URLRequest(url: loginUrl!)
        
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: request) { [weak self] data, res, err in
            guard self != nil else { return }
            if let err = err { print(err.localizedDescription); return }
            print((res as! HTTPURLResponse).statusCode)
            switch (res as! HTTPURLResponse).statusCode{
                
                
                
            case 200:
                let jsonSerialization = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                print("\(jsonSerialization)")
                
                UserDefaults.standard.set(jsonSerialization["access_token"], forKey: "access_token")
                UserDefaults.standard.set(jsonSerialization["refresh_token"], forKey: "refresh_token")
                
                
            case 400:
                print("로그인 실패")
                
            case 470:
                print("해당 이메일의 계정이 존재하지 않음")
                
            case 471:
                print("비밀번호가 이메일과 매칭되지 않음")
                
            default:
                DispatchQueue.main.async {
                    print((res as! HTTPURLResponse).statusCode)
                }
                
            }
        }.resume()
        
        
        
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
    func bringKakaoId() {
        
        var request = URLRequest(url: kakaoUrl!)
        
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
                
                UserDefaults.standard.set(jsonSerialization["kakao_id"], forKey: "kakao_id")
                
                print("kakao_id 반환성공")
                
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
    
}
