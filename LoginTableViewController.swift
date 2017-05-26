//
//  LoginTableViewController.swift
//  ModalViewDemo
//
//  Created by Albert Sphepherd on 2017/5/26.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class LoginTableViewController: UITableViewController,UITextFieldDelegate {

    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITableViewCell!
    @IBOutlet weak var LoginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let BackImageView = UIImageView(image: UIImage(named: "background.png"))
        BackImageView.frame = self.view.frame
        self.tableView.backgroundView = BackImageView
        self.tableView.backgroundColor = UIColor.clear
        //在通知中心注册通知，通知名为RegisterCompleteNotification,同时指定了自动回调方法regComplete(自定义)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginTableViewController.regComplete(_:)), name: Notification.Name(rawValue:"RegisterCompleteNotification"), object: nil)
    }
    //MARK:处理通知的方法，通知名为“RegisterCompleteNotification”
    func regComplete(_ notification:Notification){
        let data = notification.userInfo as NSDictionary?
        self.Username.text = data?["userName"] as? String
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
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
        self.Username.resignFirstResponder()
        return true
    }


}
