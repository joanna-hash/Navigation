//
//  ViewController.swift
//  Navigation
//
//  Created by 김가영 on 2021/01/08.
//  Copyright © 2021 김가영. All rights reserved.
//

import UIKit

//메인화면
class ViewController: UIViewController, EditDelegate {

    let imgOn = UIImage(named: "lamp_on.png")
    let imgOff = UIImage(named: "lamp_off.png")
    
    var isOn = true
    var isZoom = false
    var orgZoom = false
    
    @IBOutlet var txMessage: UITextField!
    @IBOutlet var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgView.image = imgOn

    }
    
    //세그웨이 통해 화면 전환
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //세그웨이의 도착 컨트롤러 정하기
        let editViewController = segue.destination as! EditViewController
        
        //버튼을 클릭한 경우
        if segue.identifier == "editButton"{
            
            editViewController.textWayValue = "segue : use button"
            
        }
       //바 버튼을 클릭한 경우
        else if segue.identifier == "editBarButton"{
            
             editViewController.textWayValue = "segue : use Bar button"
        }
        
        //메인화면에서의 텍스트가 수정화면으로 전달
        editViewController.textMessage = txMessage.text!
        
        editViewController.isOn = isOn
        editViewController.isZoom = orgZoom
        
        //default delegate
        editViewController.delegate = self
    }
    
    //수정화면 컨트롤러에서 메시지 인수로 받아서 메인화면에서 텍스트로 나타나기
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        
        txMessage.text = message
    }
    
    //수정화면의 스위치 값에 따라 전구 이미지 변경
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool) {
        
        if isOn{ //if true
            
            imgView.image = imgOn
            self.isOn = true
            
        } else { //if false
            
            imgView.image = imgOff
            self.isOn = false
        }
    }
    
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool) {
        
        let scale: CGFloat = 2.0
        var newWidth: CGFloat, newHeight: CGFloat
        
       print("orgZoom의 상태는",orgZoom)
        
        if isZoom{ //isZoom = true면 확대 이미지 나타남
        if orgZoom{ //orgZoom = true(조작안했을 시)
            
        print("확대 이미지 유지")
  
        }else{ //orgZoom = false(조작했을 시)
            print("확대된 상태의 orgZoom은",orgZoom)
            self.isZoom = false
            self.orgZoom = true
            newWidth = imgView.frame.width * scale
            newHeight = imgView.frame.height * scale
            imgView.frame.size = CGSize(width: newWidth, height: newHeight)
            print("바뀐 isZoom", self.isZoom)
            print("바뀐 orgZoom", self.orgZoom)
   
            }

        }else { //isZoom = false면 축소 이미지 나타남
        if orgZoom{ //orgZoom = true (조작했을 시)
            print("축소된 상태의 orgZoom은",orgZoom)
            self.isZoom = true
            self.orgZoom = false
                newWidth = imgView.frame.width / scale
                newHeight = imgView.frame.height / scale
                imgView.frame.size = CGSize(width: newWidth, height: newHeight)
            print("바뀐 isZoom", self.isZoom)
            print("바뀐 orgZoom", self.orgZoom)

    }else{ //orgZoom = false (조작안했을 시)
            
    print("축소 이미지 유지")
            
    }
    
}
}
}

