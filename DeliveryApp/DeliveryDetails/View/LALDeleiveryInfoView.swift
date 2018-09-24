//
//  LALDeleiveryInfoView.swift
//  Lalamove
//
//  Created by Kumar on 23/09/18.
//  Copyright © 2018 Kumar. All rights reserved.
//

import UIKit
import SnapKit

class LALDeleiveryInfoView: UIView {

    var imgDelivery: UIImageView!
    var lblDeliveryDescription: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imgDelivery = {
            let _imgDelivery = UIImageView()
            _imgDelivery.contentMode = .scaleAspectFill
            _imgDelivery.image = UIImage(named: "delivery")
            _imgDelivery.roundedImage()
            return _imgDelivery
        }()
        self.addSubview(self.imgDelivery)
        
        self.lblDeliveryDescription = {
           let _lblDeliveryDescription = UILabel()
            _lblDeliveryDescription.numberOfLines = 0
            _lblDeliveryDescription.backgroundColor = UIColor.clear
            return _lblDeliveryDescription
        }()
        self.addSubview(self.lblDeliveryDescription)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if let _superView = self.imgDelivery.superview{
            let marginInsect = _superView.frame.size.height - 10
            self.imgDelivery.snp.makeConstraints { (make) in
                make.leftMargin.equalTo(_superView.snp.leftMargin).offset(8)
                make.height.width.equalTo(marginInsect)
                make.centerY.equalTo(_superView)
            }
            self.imgDelivery.roundedImage()
            
            self.lblDeliveryDescription.snp.makeConstraints { (make) in
                make.leftMargin.equalTo(self.imgDelivery.snp.rightMargin).offset(20)
                make.rightMargin.equalTo(snp.right)
                make.centerY.equalTo(self.imgDelivery)
            }
        }

    }
    
}
