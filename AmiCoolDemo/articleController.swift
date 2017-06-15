//
//  articleController.swift
//  AmiCoolDemo
//
//  Created by Albert Sphepherd on 2017/6/12.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//


import UIKit

class articleController: UITableViewController {
    
    
    var articleList:[AnyObject]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor(red: 248/255, green: 250/255, blue: 254/255, alpha: 1)
        
        //修改导航条背景色以及标题颜色
        self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 20/255.0, green: 155/255.0, blue: 1.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        self.title = "文章"
        
        self.tableView.register(ArticleCell.self, forCellReuseIdentifier: "articleCell")
        
        getArticleList()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getArticleList(){
        let paremeters:NSDictionary = ["SessionID":AMNetworkMngTool.loginReturnModel!.sessionid!,
                                       "mod":"article",
                                       "page":"1"]
        AMNetworkMngTool.shared.AMNetwork_GetList(paremeters){ (list) in
            DispatchQueue.main.async {
                if list != nil{
                    //self.courseList = [AnyObject]()
                    self.articleList = [AnyObject]()
                    for article in list!{
                        //let model =  CoursewareReturnJson.coursewareListModelWithDict(dict: article as? NSDictionary)
                        let model = ArticleReturnJson.articelListModelWithDict(dict: article as? NSDictionary)
                       // self.courseList.append(model!)
                        self.articleList.append(model!)
                    }
                    self.tableView.reloadData()
                }
                else{
                    //提示错误
                }
            }
            
        }
        
        
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        if self.courseList != nil{
//            return self.courseList.count
//        }
        if self.articleList != nil{
                return self.articleList.count
        }
        
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        
        // Configure the cell...
        cell.selectionStyle = .none
        
//        if self.courseList != nil{
//            let model = self.courseList[indexPath.row] as! CoursewareReturnJson
        if self.articleList != nil{
            let model = self.articleList[indexPath.row] as! ArticleReturnJson
        
            //cell.img.image = model
            if model.thumb == nil {
                cell.img.image = UIImage(named: "images/Placeholder.png")
            }
            else {
                let imgUrlPre = "http://amicool.neusoft.edu.cn/UPloads/"
                let imgUrl = URL(string: (imgUrlPre + model.thumb!))
                let imgData = try! Data(contentsOf: imgUrl!)
                cell.img.image = UIImage(data: imgData)?.scaleImageToSize(CGSize(width: 80, height: 60))
                
            }
            cell.title.text = model.name
            cell.autor.text = model.author
            cell.desc.text = model.desc
            
            
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = ArticleDetailController()
        detailController.articleModel = self.articleList[indexPath.row] as!ArticleReturnJson
        //let model = self.courseList[indexPath.row] as! CoursewareReturnJson
        self.hidesBottomBarWhenPushed = true
        _ = navigationController?.pushViewController(detailController, animated: true)
        self.hidesBottomBarWhenPushed = false
        
        
        
        //        vd.videoModle = self.videoList[indexPath.row] as?
        //        VideoReturnJson
        //        self.hidesBottomBarWhenPushed = true
        //        self.navigationController?.pushViewController(vd, animated: true)
        //        self.hidesBottomBarWhenPushed = false
        
    }
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
