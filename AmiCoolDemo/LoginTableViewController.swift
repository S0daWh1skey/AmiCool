//
//  LoginTableViewController.swift
//  AmiCoolDemo
//
//  Created by Albert Sphepherd on 2017/6/1.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class LoginTableViewController: UITableViewController,UITextFieldDelegate{
    
    @IBOutlet weak var username: UITextField!

    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(_ sender: UIButton) {
        if self.username.text?.characters.count == 0{
            pompAlert(message: "没有输入用户名")
        }
        else if  self.password.text?.characters.count == 0{
            pompAlert(message: "没有输入密码")
        }
        
        else {
            let parameters = ["username":self.username.text!,
                               "password":self.password.text!]
            
            //request
            
            AMNetworkMngTool.shared.AMNetwork_Login(parameters as NSDictionary , block: { (flag) in
                if flag == "1"{
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5, execute:
                        {  self.pompAlert(message: "登录成功")
                            
                    })
                }
                else{
                    self.pompAlert(message: "登录不成功")
                }
                
            })
            
                    }
    }
    
    
    func pompAlert(message:String){
        let alert = UIAlertController(title: "提示", message:  message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.username.resignFirstResponder()
        self.password.resignFirstResponder()
        return true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            return self.view.frame.size.height / 10
        }
        else{
            return 60
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

   
