//
//  ArticleReturnJson.swift
//  AmiCoolDemo
//
//  Created by Albert Sphepherd on 2017/6/12.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//



/*
 "id":"53",
 "name":"【转】android全屏／沉浸式状态栏下，各种键盘挡住输入框解决办法",
 "thumb":null,
 "thumbsize":null,
 "description":"在开发中，经常会遇到键盘挡住输入框的情况，比如登录界面或注册界面，弹出的软键盘把登录或注册按钮挡住了，用户必须把软键盘收起，才能点击相应按钮，这样的用户体验非常不好。像微信则直接把登录按钮做在输入框的上面，但有很多情况下，这经常满足不了需求。同时如果输入框特别多的情况下，点击输入时，当前输入框没被挡住，但是当前输入框下面的输入框却无法获取焦点，必须先把键盘收起，再去获取下面输入框焦点，这样用户体验也非常不好，那有什么办法呢？ ",
 "ressrcid":"2",
 "ressrcname":"转载",
 "attach":null,
 "attachsize":null,
 "technoid":"4",
 "technoname":"移动开发",
 "kcdm":"drandroid",
 "kcmc":"Android应用开发",
 "sectionid":"10",
 "sectionname":"05_控件及事件(2)-RecyclerView",
 "specialid":"36",
 "specialname":"Android布局与控件",
 "author":"潇潇凤儿",
 "content":"<p style=\"margin-top: 0px; margin-bottom: 1.1em; padding: 0px;*/


import UIKit

class ArticleReturnJson: NSObject{
    var name:String?  //课件标题
    var thumb:String?      //课件图标
    var desc:String?       //课件描述
    var kcmc:String?  //课程名称
    var author:String?    //作者
    var content:String?  //课件地址
    var update_time:String?  //更新时间
    
    class func articelListModelWithDict(dict:NSDictionary?)->ArticleReturnJson?{
        if(dict == nil){
            return nil
        }
        
        let model:ArticleReturnJson? = ArticleReturnJson()
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
