//
//  LoginReturnJson.swift
//  AmiCoolDemo
//
//  Created by Albert Sphepherd on 2017/6/1.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import Foundation
/*{
 "id": "7",
 "username": "zhengjunsheng",
 "realname": "郑俊生",
 "sessionid": "k17vmm42ui9al6clh0lo3de2t7",
 "rolename": "教师",
 "sex": "男"
 }*/
class LoginReturnJson: NSObject{
    var id:String?
    var username:String?
    var realname:String?
    var sessionid:String?
    var rolename:String?
    var sex:String?
    var error:String?
    
    class func LoginReturnJsonWithDict(_ dict:NSDictionary?)->LoginReturnJson?{
        if dict == nil {
            return nil
        }
        
        let model:LoginReturnJson? = LoginReturnJson()
        if dict?.count == 6 {
            if model != nil{
                model?.id = dict!["id"] as? String
                model?.username = dict!["username"] as? String
                model?.realname = dict!["realname"] as? String
                model?.sessionid = dict!["sessionid"] as? String
                model?.rolename = dict!["rolename"] as? String
                if dict!["sex"] is NSNull {
                    model?.sex = ""
                }
                else{
                    model?.sex = dict!["sex"] as? String
                }
            }
        }
        else{
                model?.error = dict!["error"] as? String
        }
        
        return model
    }
    
}
