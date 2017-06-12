//
//  VideoCell.swift
//  AmiCoolDemo
//
//  Created by Albert Sphepherd on 2017/6/5.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //let gradientLayer = CAGradientLayer()
       // gradientLayer.frame = CGRect(x: 5, y: (UIScreen.main.bounds.width-40)/2*0.618-15, width: self.bounds.width, height: 30)
       // gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
       // self.layer.addSublayer(gradientLayer)
        
    }
    
}
