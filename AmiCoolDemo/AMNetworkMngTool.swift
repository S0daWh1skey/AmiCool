//
//  AMNetworkMngTool.swift
//  AmiCoolDemo
//
//  Created by Albert Sphepherd on 2017/6/1.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import Foundation

//API
let str = "http://amicool.neusoft.edu.cn/api.php/login"

typealias NetworkBlock = (_ flag:String)->Void

class AMNetworkMngTool:NSObject{

    static var shared = AMNetworkMngTool() //单例
    
    func AMNetwork_Login(_ parameters:NSDictionary,block:NetworkBlock?){
        let paraArray = NSMutableArray()
        for (key,value) in parameters{
            let str = "\(key)=\(value)"
            paraArray.add(str)
        }
        let body = paraArray.componentsJoined(by: "&")
        let url = URL(string: str)
        var request = URLRequest(url: url!)
        request.httpMethod = "post"
        request.httpBody = body.data(using: String.Encoding.utf8)
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            //对返回数据进行处理
            if data != nil{
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    //将返回的数据封装成模型对象
                    let model = LoginReturnJson.LoginReturnJsonWithDict(json as? NSDictionary)
                    if model?.error == nil{
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
    
}
