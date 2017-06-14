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

let AM_LOGINOUT = "http://amicool.neusoft.edu.cn/api.php/logout"


typealias NetworkBlock = (_ flag:String)->Void
typealias NetworkVideoListkBlock = (_ VideoList:NSArray?)->Void
typealias NetworkListBlock = (_ List:NSArray?)->Void
class AMNetworkMngTool:NSObject{
    
    static var shared = AMNetworkMngTool() //单例
    
    //static var loginoutReturnModel:LoginoutReturnJson?
    
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
    
    func AMNetwork_GetVideoList(_ parameters:NSDictionary,block:@escaping NetworkVideoListkBlock){
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

    func AMNetwork_GetList(_ parameters:NSDictionary,block:@escaping NetworkListBlock){
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
        let dataTask = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if data != nil{
                let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                if json != nil{
                    block(json as? NSArray)
                    //返回给调用者
                }
                else{
                    block(nil)
                }
            }
            else{
                block(nil)
            }
        }
        dataTask.resume() // 使用resume方法启动任务
    }
    func AMNetwork_Loginout(_ parameters:NSDictionary,block:NetworkBlock?){
        let paraArray = NSMutableArray()
        for (key,value) in parameters{
            let str = "\(key)=\(value)"
            paraArray.add(str)
        }
        let body = paraArray.componentsJoined(by: "&")
        let url = URL(string: AM_LOGINOUT)
        var request = URLRequest(url: url!)
        request.httpMethod = "post"
        request.httpBody = body.data(using: String.Encoding.utf8)
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            //对返回数据进行处理
            if data != nil{ //返回的数据不是nil
                let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                if json != nil{ //解析出来的数据不是nil 说明 是存在error
                    block!("0")
                }
                if json == nil{ //说明不是标准json 解析失败
                    block!("1")     //退出成功
                }
                
            }
            if data == nil{ //网络错误
                block!("2")
            }
        })
        dataTask.resume() //启动任务
        
    }
    



}





