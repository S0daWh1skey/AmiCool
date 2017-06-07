//
//  VideoController.swift
//  AmiCoolDemo
//
//  Created by Albert Sphepherd on 2017/6/5.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

private let reuseIdentifier = "videoCell"

class VideoController: UICollectionViewController {

    var videoList:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 20/255.0, green: 155/255.0, blue: 1.0, alpha: 1.0)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes

        // Do any additional setup after loading the view.
        getVideoList()
        }
    func getVideoList(){
        let parameters:NSDictionary = ["SessionID":AMNetworkMngTool.loginReturnModel!.sessionid!,
                                       "mod":"video",
                                       "page":"1"
                                    ]
        AMNetworkMngTool.shared.AMNetwork_GetVideoList(parameters){(videoList) in
            if videoList != nil{
                DispatchQueue.main.async {
                    self.videoList = videoList
                    self.collectionView?.reloadData()
                }
            }
            else{
                    //提示，获取视频列表失败
                
            }
            
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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if self.videoList != nil{
            return videoList.count
        }
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! VideoCell
        
        // Configure the cell
        if self.videoList != nil{
            let model = self.videoList[indexPath.row] as! VideoReturnJson
            
            cell.title.text = model.name
            cell.author.text = model.author
            
            if model.thumb != nil{
                let imgUrlPre = "http://amicool.neusoft.edu.cn/Uploads/"
                let imgUrl = URL(string: imgUrlPre + model.thumb!)
                let imgData = try! Data(contentsOf: imgUrl!)
                cell.img.image = UIImage(data: imgData)?.scaleImageToSize(CGSize(width: 80, height: 60))
            }
            else{
                cell.img.image = UIImage(named: "images/placeholder.png")
            }
        }
        
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
