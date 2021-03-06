//
//  pdfScrollView.swift
//  Amicool
//
//  Created by 褚娜 on 2017/6/8.
//  Copyright © 2017年 chuna. All rights reserved.
//

import UIKit

class pdfScrollView: UIScrollView ,UIScrollViewDelegate{

    var PDF:CGPDFDocument!
    var initialScale:CGFloat!
    var pdfScale = CGFloat()
    var PDFview:PdfView!
    var backView:PdfView!
    var pdfRect:CGRect!
    //var pdfScrollviewDelegate:pdfScrollviewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func initialize(){
        if let page = PDF.page(at: 1){
            let Rect = page.getBoxRect(.cropBox)
            let num = CGFloat(PDF.numberOfPages)
            pdfScale = bounds.width/Rect.width
            initialScale = pdfScale
            pdfRect = CGRect(x: 0, y: 0, width: Rect.width*pdfScale, height: Rect.height*pdfScale)
            PDFview = PdfView(frame: CGRect(x: 0, y: 0, width: pdfRect.width, height: pdfRect.height*num+num*10*pdfScale), scale: pdfScale)
            PDFview.PDF = PDF
            backView = PdfView(frame: PDFview.frame, scale: pdfScale)
            
            contentSize = PDFview.frame.size
            maximumZoomScale = 4
            delegate = self
            addSubview(PDFview)
        }
    }
    
    func replacePdfView(frame: CGRect){
        let newPdfView = PdfView(frame: frame, scale: pdfScale)
        newPdfView.PDF = PDF
        PDFview = newPdfView
        addSubview(newPdfView)
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        backView.removeFromSuperview()
        backView = PDFview
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        pdfScale *= scale
        if bounds.origin.x <= 0 || bounds.origin.y <= 0{
            pdfScale = initialScale
            let num = CGFloat(PDF.numberOfPages)
            let old_HEIGHT = PDFview.frame.height
            let new_HEIGHT = pdfRect.height*num+num*10*pdfScale
            PDFview.frame = CGRect(origin: .zero, size: CGSize(width: pdfRect.width, height: new_HEIGHT))
            backView.frame = PDFview.frame
            contentSize = PDFview.frame.size
            minimumZoomScale = 1
            contentOffset.y *= (new_HEIGHT/old_HEIGHT)
        }else{
            minimumZoomScale = 0.25
        }
        replacePdfView(frame: backView.frame)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return PDFview
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        pdfScrollviewDelegate.showBarview()
//    }
//    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        pdfScrollviewDelegate.showBarview()
//    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
