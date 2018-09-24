//
//  LALDeliveryListsTableViewCell.swift
//  Lalamove
//
//  Created by Kumar on 19/09/18.
//  Copyright © 2018 Kumar. All rights reserved.
//

import UIKit
import SnapKit

class LALDeliveryListsTableViewCell: UITableViewCell {

    var imageDeliveryIcon: UIImageView!
    var lblDescription: UILabel!
    
    var lblName: UILabel!
    var lblDeliverytype: UILabel!
    var lblAdress: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.white
        self.accessoryType = .disclosureIndicator
        self.tintColor = LALColors.navTintColor
        
        imageDeliveryIcon = {
            let imgView = UIImageView(image: UIImage(named: "delivery"))
            imgView.translatesAutoresizingMaskIntoConstraints = false
            imgView.contentMode = .scaleAspectFit
            imgView.layer.borderWidth = 2
            imgView.layer.borderColor = LALColors.navTintColor.cgColor
            return imgView
        }()
        
        lblDescription = {
            let lbl = UILabel()
            lbl.numberOfLines = 2
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        
        lblName = {
            let lbl = UILabel()
            lbl.font = LALFont.headerFontRegular
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        
        lblDeliverytype = {
            let lbl = UILabel()
            lbl.textColor = UIColor.darkGray
            lbl.font = LALFont.headerFontLight
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
       
        lblAdress = {
            let lbl = UILabel()
            lbl.textColor = UIColor.darkGray
            lbl.font = LALFont.headerFontLight
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        
        self.addSubview(imageDeliveryIcon)
        self.addSubview(lblDescription)
        self.addSubview(lblName)
        self.addSubview(lblDeliverytype)
        self.addSubview(lblAdress)
        
        imageDeliveryIcon.snp.makeConstraints({ (make) in
            make.leftMargin.equalTo(snp.leftMargin)
            make.bottomMargin.equalTo(snp.bottomMargin)
            make.topMargin.equalTo(snp.topMargin)
            make.width.equalTo(100)
        })

        lblDescription.snp.makeConstraints({ (make) in
            make.leftMargin.equalTo(self.imageDeliveryIcon.snp.rightMargin).offset(20)
            make.rightMargin.equalTo(snp.right)
            make.centerY.equalTo(self.imageDeliveryIcon)
        })
        
        lblName.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(self.imageDeliveryIcon.snp.rightMargin).offset(25)
            make.topMargin.equalTo(snp.topMargin)
            make.rightMargin.equalTo(snp.right)
            make.height.equalTo(30)
        }
        
        lblDeliverytype.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(lblName.snp.leftMargin)
            make.top.equalTo(lblName.snp.bottomMargin)
            make.rightMargin.equalTo(lblName.snp.right)
            make.height.equalTo(30)
        }
        
        lblAdress.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(lblName.snp.leftMargin)
            make.height.equalTo(20)
            make.rightMargin.equalTo(lblName.snp.right)
            make.bottomMargin.equalTo(snp.bottomMargin)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(deliveryItem: DeliveryDetails) {
        if let name = deliveryItem.name, let type = deliveryItem.deliveryType {
            lblDescription.isHidden = true
            lblName.text = name
            lblDeliverytype.text = type
            lblAdress.text = deliveryItem.location.address
        }else{
            lblDescription.isHidden = false
            lblName.isHidden = true
            lblAdress.isHidden = true
            lblDeliverytype.isHidden = true
            
            lblDescription.text = deliveryItem.description
        }
    }
    
}
