//
//  LoginRegTableViewCell.swift
//  AmiCoolDemo
//
//  Created by Albert Sphepherd on 2017/6/1.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class LoginRegTableViewCell: UITableViewCell {

    
    @IBOutlet weak var loginBt: UIButton!
    @IBOutlet weak var regBt: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
        self.loginBt.layer.cornerRadius = 15.0
        self.regBt.layer.cornerRadius = 15.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
