//
//  ProfileChangeViewController.swift
//  Kakaotalk_CloneCoding
//
//  Created by DohyunKim on 28/11/2019.
//  Copyright © 2019 DohyunKim. All rights reserved.
//

import UIKit


class ProfileChangeViewController: UIViewController {
    
    @IBOutlet weak var txtNickname: UITextField!
    
    @IBOutlet weak var txtStatusMessage: UITextField!
    
    @IBOutlet weak var backgroundImageOutlet: UIButton!
    
    @IBOutlet weak var profileImageOutlet: UIButton!
    
    let profileUrl = URL(string: "https://chicksoup.s3.ap-northeast-2.amazonaws.com/users/my/profile")
    
    let refreshUrl = URL(string: "https://chicksoup.s3.ap-northeast-2.amazonaws.com/refresh")
    
    let picker = UIImagePickerController()
    
    
    var selectedImage : UIImage = UIImage(named: "ProfileBackground")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
    }
    
    
    @IBAction func btnSetBackGroundImage(_ sender: Any) {
        setPhoto()
        backgroundImageChanger()
    }
    
    @IBAction func btnSetProfileImage(_ sender: Any) {
        setPhoto()
        profileImageChanger()
    }
    
    @IBAction func btnSetProfile(_ sender: Any) {
        
    }
    
    func setProfile() {
        
        let profileImage : UIImage = profileImageOutlet!.image(for: .normal)!
        
        
        
        let backgroundImage : UIImage = backgroundImageOutlet!.image(for: .normal)!
        
        
        
        var request = URLRequest(url: profileUrl!)
        
        let parameters = ["nickname": txtNickname.text!, "status_message": txtStatusMessage.text!, "where": "mobile", "profile": profileImage , "background": backgroundImage
            ] as [String : Any]
        
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "access_token")
        request.addValue("application/json", forHTTPHeaderField: "multipart/form-data")
        
        
        request.addValue("Authorization", forHTTPHeaderField: String(UserDefaults.standard.string(forKey :"access_token")!))
        
        request.httpMethod = "PUT"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: request){
            [weak self] data, res, err in
            guard self != nil else { return }
            if let err = err { print(err.localizedDescription); return }
            print((res as! HTTPURLResponse).statusCode)
            switch (res as! HTTPURLResponse).statusCode{
            case 200:
                let jsonSerialization = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                print(jsonSerialization)
                
                print("해당 회원의 프로필 정보 번경 성공")
                
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
    
    func setPhoto() {
        let alart = UIAlertController(title: "배경 사진", message: "사진 선택", preferredStyle: .actionSheet)
        
        let library = UIAlertAction(title: "사진엘범",style: .default) { (action) in self.openLibrary()
        }
        
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alart.addAction(library)
        alart.addAction(camera)
        alart.addAction(cancel)
        
        present(alart, animated: true, completion: nil)
        
    }
    
    func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        } else {
            print("Camera not available")
        }
        
    }
    
}
extension ProfileChangeViewController : UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image :UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        
        
        print(info)
        
        selectedImage = image
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func backgroundImageChanger() {
        
        backgroundImageOutlet.setImage(selectedImage, for: UIControl.State.normal)
        
    }
    
    func profileImageChanger() {
        
        profileImageOutlet.setImage(selectedImage, for: UIControl.State.normal)
        
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
                
                //            case 403:
                //                print("사용 가능 기간이 만료된 JWT")
                
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





