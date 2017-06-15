//
//  CaseReturnJson.swift
//  AmiCoolDemo
//
//  Created by Albert Sphepherd on 2017/6/15.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class CaseReturnJson: NSObject{
    var name:String?  //课件标题
    var thumb:String?      //课件图标
    var desc:String?       //课件描述
    var kcmc:String?  //课程名称
    var author:String?    //作者
    var content:String?  //课件地址
    var update_time:String?  //更新时间
    
    class func CaselListModelWithDict(dict:NSDictionary?)->CaseReturnJson?{
        if(dict == nil){
            return nil
        }
        
        let model:CaseReturnJson? = CaseReturnJson()
        if model != nil{
            model?.name = dict!["name"] as? String
            model?.thumb = dict!["thumb"] as? String
            model?.desc = dict!["description"] as? String
            model?.kcmc = dict!["kcmc"] as? String
            model?.author = dict!["author"] as? String
            model?.content = dict!["content"] as? String
            model?.update_time = dict!["update_time"] as? String
            
            
        }
        
        return model
        
    }
    
    
    
    
    
    
}

