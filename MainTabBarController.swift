//
//  MainTabBarController.swift
//  AmiCoolDemo
//
//  Created by Albert Sphepherd on 2017/6/5.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //let video = VideoController()
        let videoStoryboard = UIStoryboard(name: "Video", bundle: nil)
        let videoNavController = videoStoryboard.instantiateViewController(withIdentifier: "videoNav")
        let me = MeController()
        let courseware = CoursewareController()
        self.viewControllers = [videoNavController,courseware, me]
        // Set tabBar
        let tabBar = self.tabBar
        self.tabBar.frame = CGRect(x: tabBar.frame.minX, y: tabBar.frame.minY, width: tabBar.frame.width, height: 40)
        
        let tabBarItemTitles:[String] = ["视频","课程","我"]
        let tabBarItemImages:[String] = ["video","tware","me"]
        var index = 0
        for item in self.tabBar.items!{
            //设置标题
            item.title = tabBarItemTitles[index]
            //Set Icon
            let selectedImage = UIImage(named: String(format: "images/%@.png", tabBarItemImages[index]))?.scaleImageToSize(CGSize(width: 30, height: 30))
            
            let unselsectedImage = UIImage(named: String(format: "images/%@-2.png", tabBarItemImages[index]))?.scaleImageToSize(CGSize(width: 30, height: 30))
            item.image = selectedImage
            item.selectedImage = unselsectedImage
            index += 1
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
