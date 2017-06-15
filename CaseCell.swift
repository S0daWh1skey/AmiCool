//
//  CaseCell.swift
//  AmiCoolDemo
//
//  Created by Albert Sphepherd on 2017/6/15.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//


import UIKit

let CaseTITLEFONT = UIFont.systemFont(ofSize: 16.0)

class CaseCell: UITableViewCell {
    
    
    var title:UILabel = UILabel()
    var autor:UILabel = UILabel()
    var desc:UILabel = UILabel()
    var img:UIImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initialize(){
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.actions = ["position":NSNull(),"bounds":NSNull(),"path":NSNull()]
        shapeLayer.shadowColor = UIColor.darkGray.cgColor
        shapeLayer.shadowOpacity = 0.6
        shapeLayer.shadowRadius = 4
        shapeLayer.shadowOffset = CGSize(width: 0, height: 3)
        shapeLayer.shadowPath = UIBezierPath(roundedRect: CGRect(x: MARGIN,
                                                                 y: CELLHEIGHT/4,
                                                                 width: WHRatio*CELLHEIGHT,
                                                                 height: 80),
                                             cornerRadius: 4).cgPath
        
        let imgShadow = CAShapeLayer()
        
        imgShadow.path = UIBezierPath(roundedRect: CGRect(x:MARGIN,
                                                          y: CELLHEIGHT/4,
                                                          width: WHRatio*CELLHEIGHT,
                                                          height: 80),
                                      cornerRadius: 2).cgPath
        imgShadow.fillColor = UIColor.darkGray.cgColor
        imgShadow.shadowRadius = 4
        imgShadow.shadowOffset = CGSize(width: 0, height: 2)
        imgShadow.shadowOpacity = 0.6
        shapeLayer.addSublayer(imgShadow)
        
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 14.0)
        title.backgroundColor = UIColor.clear
        title.textColor = UIColor.black
        
        
        autor.textAlignment = .left
        autor.font = TITLEFONT
        autor.backgroundColor = UIColor.clear
        autor.textColor = UIColor(red: 175/255,
                                  green: 186/255,
                                  blue: 202/255,
                                  alpha: 1)
        
        
        desc.textAlignment = .left
        desc.font = UIFont.systemFont(ofSize: 13)
        desc.backgroundColor = UIColor.clear
        desc.textColor = UIColor(red: 175/255,
                                 green: 186/255,
                                 blue: 202/255,
                                 alpha: 1)
        
        img.layer.cornerRadius = 2
        img.layer.masksToBounds = true
        
        self.contentView.addSubview(title)
        self.contentView.addSubview(autor)
        self.contentView.addSubview(desc)
        self.contentView.addSubview(img)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //2.设置子控件的位置
    let screenWidth = UIScreen.main.bounds.width
    let ScreenHeight = UIScreen.main.bounds.height
    let CELLHEIGHT = CGFloat(100.0)
    let MARGIN = CGFloat(8.0)
    let WHRatio = CGFloat(4.0/3.0)   //宽高比
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView?.frame = CGRect(x: MARGIN, y: CELLHEIGHT/4, width: WHRatio*CELLHEIGHT, height: 80)
        self.imageView?.layer.cornerRadius = 2
        self.imageView?.layer.masksToBounds = true
        
        self.img.frame = CGRect(x: MARGIN, y:CELLHEIGHT/4, width: 80, height: 80)
        self.title.frame = CGRect(x: 80+MARGIN*2, y: CELLHEIGHT/4, width: ScreenHeight-WHRatio*CELLHEIGHT+MARGIN-20, height: 20.0)
        self.autor.frame = CGRect(x: 80+MARGIN*2, y: CELLHEIGHT*2/4, width: ScreenHeight-WHRatio*CELLHEIGHT+MARGIN-20, height: 20.0)
        self.desc.frame = CGRect(x: 80+MARGIN*2, y: CELLHEIGHT*3/4, width: ScreenHeight-WHRatio*CELLHEIGHT+MARGIN-20, height: 20.0)
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
