//
//  AMNetworkMngTool.swift
//  AmiCoolDemo
//
//  Created by Albert Sphepherd on 2017/6/1.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import Foundation

//API
let AM_LOGIN = "http://amicool.neusoft.edu.cn/api.php/login"


let AM_LIST = "http://amicool.neusoft.edu.cn/api.php/lists"


typealias NetworkBlock = (_ flag:String)->Void
typealias NetworVideoListkBlock = (_ VideoList:NSArray?)->Void

class AMNetworkMngTool:NSObject{
    
    static var shared = AMNetworkMngTool() //单例
    
    
    static var loginReturnModel:LoginReturnJson? = LoginReturnJson()
    
    func AMNetwork_Login(_ parameters:NSDictionary,block:NetworkBlock?){
        let paraArray = NSMutableArray()
        for (key,value) in parameters{
            let str = "\(key)=\(value)"
            paraArray.add(str)
        }
        let body = paraArray.componentsJoined(by: "&")
        let url = URL(string: AM_LOGIN)
        var request = URLRequest(url: url!)
        request.httpMethod = "post"
        request.httpBody = body.data(using: String.Encoding.utf8)
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            //对返回数据进行处理
            if data != nil{
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    //将返回的数据封装成模型对象
                    AMNetworkMngTool.loginReturnModel = LoginReturnJson.LoginReturnJsonWithDict(json as? NSDictionary)
                    if AMNetworkMngTool.loginReturnModel?.error == nil{
                        block!("1")
                    }
                    else{
                        block!("0")
                    }
                }
            }
        })
        dataTask.resume() //启动任务
        
    }
    
    func AMNetwork_GetVideoList(_ parameters:NSDictionary,block:@escaping NetworVideoListkBlock){
        let paraArray = NSMutableArray()
        for (key,value) in parameters{
            let str = "\(key)=\(value)"
            paraArray.add(str)
        }
        let body = paraArray.componentsJoined(by: "&")
        let url = URL(string: AM_LIST)
        var request = URLRequest(url: url!)
        request.httpMethod = "post"
        request.httpBody = body.data(using: String.Encoding.utf8)
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            //对返回数据进行处理
            if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers){
                var videoList = [AnyObject]()
                for video in (json as! NSArray){
                    let model = VideoReturnJson.VideoReturnJsonWithDict(video as? NSDictionary)
                    videoList.append(model!)
                }
                block(videoList as NSArray)
            }
            else{
                block(nil)
            }
            
        })
        dataTask.resume() //启动任务
    }
}
