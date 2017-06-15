//
//  MeController.swift
//  AmiCoolDemo
//
//  Created by Albert Sphepherd on 2017/6/15.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class MeController: UIViewController {
    let parameters = ["SessionID":AMNetworkMngTool.loginReturnModel?.sessionid]
    @IBOutlet weak var loginout: UIButton!
    @IBOutlet weak var Navbar: UINavigationBar!
    
    @IBOutlet weak var rolename: UILabel!
    @IBOutlet weak var realname: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBAction func Login_out(_ sender: Any) {
        //request
        AMNetworkMngTool.shared.AMNetwork_Loginout(parameters as NSDictionary , block: { (flag) in
            if flag == "1"{
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5, execute:
                    {  //self.pompAlert(message: "登录成功")
                        //UIApplication.shared.keyWindow?.rootViewController = MainTabBarController()
                        let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let loginNav = loginStoryboard.instantiateViewController(withIdentifier: "LoginNav")
                        UIApplication.shared.keyWindow?.rootViewController = loginNav
                })
            }
            else {
                self.pompAlert(message: "退出不成功")
            }
            
        })
        

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.Navbar.barTintColor = UIColor(colorLiteralRed: 20/255.0, green: 155/255.0, blue: 1.0, alpha: 1.0)
        self.Navbar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        self.title = "我"
        loginout.backgroundColor = UIColor.blue
        self.loginout.layer.cornerRadius = 8.0
        self.rolename.text = AMNetworkMngTool.loginReturnModel?.rolename
        self.realname.text = AMNetworkMngTool.loginReturnModel?.realname
        self.username.text = AMNetworkMngTool.loginReturnModel?.username
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pompAlert(message:String){
        let alert = UIAlertController(title: "提示", message:  message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
