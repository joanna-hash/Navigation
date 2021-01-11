//
//  EditViewController.swift
//  Navigation
//
//  Created by 김가영 on 2021/01/08.
//  Copyright © 2021 김가영. All rights reserved.
//

import UIKit

//프로토콜(수정화면의 데이터를 메인화면으로 전달)
protocol EditDelegate {
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOnOffDone(_ controller: EditViewController, isOn : Bool)
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool)
}

//수정화면
class EditViewController: UIViewController {
    
    var textWayValue:String = "" //레이블 디폴트용
    var textMessage: String = "" //텍스트 디폴트용
    var delegate : EditDelegate?
    var isOn = false
    var isZoom = false
    
    @IBOutlet var swIsOn: UISwitch!
    @IBOutlet var lblWay: UILabel!
    @IBOutlet var txMessage: UITextField!
    @IBOutlet var zoomBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblWay.text = textWayValue
        txMessage.text = textMessage
        swIsOn.isOn = isOn

        print("수정화면에서 isZoom은", isZoom)
        if isZoom { //if false
            zoomBtn.setTitle("확대", for: UIControl.State())
            
        } else { //if true
            zoomBtn.setTitle("축소", for: UIControl.State())
        }
        
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        
        //완료 버튼 클릭시 데이터를 메인화면으로 전달 (딜리게이트가 있다면)
        if delegate != nil {
            delegate?.didMessageEditDone(self, message: txMessage.text!)
            delegate?.didImageOnOffDone(self, isOn : isOn)
            delegate?.didImageZoomDone(self, isZoom: isZoom)
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    //전구 제어 위한 bool값 정리
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        
        if sender.isOn{ //if false
            isOn = true
        } else {
            isOn = false
        }
        
    }
    
    @IBAction func zoomInOut(_ sender: UIButton) {
        
        if isZoom {   //isZoom = false
            
            isZoom = false
            zoomBtn.setTitle("축소", for: UIControl.State())
            print("isZoom의 상태는",isZoom)
        }
        else {  //isZoom = true

            isZoom = true
            zoomBtn.setTitle("확대", for: UIControl.State())
            print("isZoom의 상태는",isZoom)
        }
        
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
