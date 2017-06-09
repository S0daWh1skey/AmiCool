//
//  VideoReturnJson.swift
//  AmiCoolDemo
//
//  Created by Albert Sphepherd on 2017/6/5.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//
/*
 
 
 */


import Foundation
class VideoReturnJson: NSObject{
    var name:String?
    var thumb:String?
    var decs:String?
    var videopath:String?
    var kcmc:String?
    var author:String?
    var update_time:String?
    static let videoUrlPre = "http://amicool.neusoft.edu.cn/Uploads/video/video/"
    class func VideoReturnJsonWithDict(_ dict:NSDictionary?)->VideoReturnJson?{
        if dict == nil {
            return nil
        }
        
        let model:VideoReturnJson? = VideoReturnJson()
        if model != nil{
            model?.name = dict!["name"] as? String
            model?.thumb = dict!["thumb"] as? String
            model?.decs = dict!["description"] as? String
            model?.videopath = videoUrlPre + (dict!["videopath"] as? String)!
            model?.kcmc = dict!["kcmc"] as? String
            model?.author = dict!["author"] as? String
            model?.update_time = dict!["update_time"] as? String
        }
        
        return model
    }
    
}
