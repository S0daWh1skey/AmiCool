//
//  CaseDetailController.swift
//  AmiCoolDemo
//
//  Created by Albert Sphepherd on 2017/6/15.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class CaseDetailController: UIViewController {
    
    var CaseModel:CaseReturnJson!
    
    var textView:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "详情"
        
        // Do any additional setup after loading the view.
        textConfiguration()
        
        let bt = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        bt.setImage(UIImage(named:"images/back.png"), for: .normal)
        bt.addTarget(self, action: #selector(VideoDetailController.back), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: bt)
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textConfiguration(){
        self.view.backgroundColor = UIColor(red: 248/255, green: 250/255, blue: 254/255, alpha: 1)
        self.automaticallyAdjustsScrollViewInsets = false
        
        //let pdfUrlPre = "http://amicool.neusoft.edu.cn/Uploads/"
        //let url = URL(string: coursewareModel.pdfattach!)
        
        //let pdf = CGPDFDocument.init(url! as CFURL)
        
        //scrollView = pdfScrollView(frame: view.frame)
        //scrollView.backgroundColor = UIColor.lightGray
        //scrollView.PDF = pdf!
        //scrollView.initialize()
        //scrollView.pdfScrollviewDelegate = self
        textView = UITextView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        textView.backgroundColor = UIColor.white
        
        let htmlStr = "<head><style>img{max-width:\(view.bounds.width)px !important;}</style></head>" + (CaseModel?.content)!
        let data = htmlStr.data(using: String.Encoding.unicode)
        let attrstr = try? NSAttributedString(data: data!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
        textView.attributedText = attrstr
        
        view.addSubview(textView)
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
