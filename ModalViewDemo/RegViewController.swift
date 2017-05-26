//
//  RegViewController.swift
//  ModalViewDemo
//
//  Created by Albert Sphepherd on 2017/5/26.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class RegViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var UserName: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    @IBOutlet weak var PasswordConfirm: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Password.isSecureTextEntry = true
        self.PasswordConfirm.isSecureTextEntry = true
        // Do any additional setup after loading the view.

    }
    
    
    @IBAction func Confirm(_ sender: UIBarButtonItem) {
        //验证用户名是否为空
        if self.UserName.text != ""{
            //验证密码是否为空
            if self.Password.text != ""{
                //验证密码是否一致
                if self.Password.text == PasswordConfirm.text{
                    //保存，用户名到登录用户文本框
                    //通知机制
                    let data = ["userName":UserName.text!] //字典
                    //使用通知中心的post方法，将data字典数据传递到通知中心中
                    NotificationCenter.default.post(name: Notification.Name(rawValue:"RegisterCompleteNotification"), object: nil, userInfo: data)
                    self.dismiss(animated: true, completion: nil)
                }else{
                    let alertView = UIAlertView(title: "标题", message: "两次输入的密码不一致", delegate: self, cancelButtonTitle: "确定")
                    alertView.show()
                }
            }
            else{
                let alertView = UIAlertView(title: "标题", message: "请输入密码", delegate: self, cancelButtonTitle: "确定")
                alertView.show()
            }
        }
        else{
            let alertView = UIAlertView(title: "标题", message: "请输入用户名", delegate: self, cancelButtonTitle: "确定")
            alertView.show()
        }
        
        //提交
    }
    
    @IBAction func Cancle(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK:文本框协议-按下键盘的回车键自动回调的方法
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        //通过撤销第一响应对象的方式 撤销键盘
        self.UserName.resignFirstResponder()
        self.Password.resignFirstResponder()
        self.PasswordConfirm.resignFirstResponder()
        return true
    }

}
