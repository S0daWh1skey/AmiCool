//
//  CoursewareDetailController.swift
//  AmiCoolDemo
//
//  Created by Albert Sphepherd on 2017/6/9.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class CoursewareDetailController: UIViewController,UIScrollViewDelegate {
    
    var coursewareModel:CoursewareReturnJson!
    
    var scrollView:pdfScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "课件详情"
        //self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        pdfConfiguration()
        
        let bt = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        bt.setImage(UIImage(named:"images/back.png"), for: .normal)
        bt.addTarget(self, action: #selector(CoursewareDetailController.back), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: bt)
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
    }
    
    func navback(){
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pdfConfiguration(){
        self.view.backgroundColor = UIColor(red: 248/255, green: 250/255, blue: 254/255, alpha: 1)
        self.automaticallyAdjustsScrollViewInsets = false
        
        //let pdfUrlPre = "http://amicool.neusoft.edu.cn/Uploads/"
        let url = URL(string: coursewareModel.pdfattach!)
        
        let pdf = CGPDFDocument.init(url! as CFURL)
        
        scrollView = pdfScrollView(frame: view.frame)
        scrollView.backgroundColor = UIColor.lightGray
        scrollView.PDF = pdf!
        scrollView.initialize()
        //scrollView.pdfScrollviewDelegate = self
        view.addSubview(scrollView)
        }
    
    func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        for subView in scrollView.subviews{
            return subView
        }
        return nil
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if velocity.y > 0{
            self.navigationController?.navigationBar.isHidden = true
        }
        else{
            self.navigationController?.navigationBar.isHidden = false
        }
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
