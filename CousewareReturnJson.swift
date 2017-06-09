//
//  CousewareReturnJson.swift
//  AmiCoolDemo
//
//  Created by Albert Sphepherd on 2017/6/9.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class CoursewareReturnJson: NSObject {
    var name:String?  //课件标题
    var thumb:String?      //课件图标
    var desc:String?       //课件描述
    var kcmc:String?  //课程名称
    var author:String?    //作者
    var pdfattach:String?  //课件地址
    var update_time:String?  //更新时间

    static let pdfUrlPre = "http//amicool.neusoft.edu.cn/Uploads/"
    
    class func coursewareListModelWithDict(dict:NSDictionary?)->CoursewareReturnJson?{
        if(dict == nil){
            return nil
        }
        
        let model:CoursewareReturnJson? = CoursewareReturnJson()
        if model != nil{
            model?.name = dict!["name"] as? String
            model?.thumb = dict!["thumb"] as? String
            model?.desc = dict!["desc"] as? String
            model?.kcmc = dict!["kcmc"] as? String
            model?.author = dict!["author"] as? String
            model?.pdfattach = pdfUrlPre + (dict!["pdfattach"] as! String)
            model?.update_time = dict!["update_time"] as? String
            
            
        }
    
    return model
    
    }
    
    
}
