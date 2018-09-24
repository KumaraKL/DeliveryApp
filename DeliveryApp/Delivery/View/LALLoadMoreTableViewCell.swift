//
//  LALLoadMoreTableViewCell.swift
//  Lalamove
//
//  Created by Kumar on 23/09/18.
//  Copyright © 2018 Kumar. All rights reserved.
//

import UIKit
import SnapKit

protocol LALTableViewCellLoadMoreDelegate: class {
    func loadMoreButtonSelected(cell: LALLoadMoreTableViewCell)
}


class LALLoadMoreTableViewCell: UITableViewCell {

    var activityIndicator: UIActivityIndicatorView!
    var btnLoadMore: UIButton!
    weak var delegate: LALTableViewCellLoadMoreDelegate?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.white
        self.accessoryType = .none
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.center = self.contentView.center
        activityIndicator.color = LALColors.navTintColor
        activityIndicator.hidesWhenStopped = true
        
        self.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        btnLoadMore = UIButton (type: .system)
        btnLoadMore.setTitle("Load More", for: .normal)
        btnLoadMore.setTitleColor(LALColors.navTintColor, for: .normal)
        btnLoadMore.addTarget(self, action: #selector(loadMorePressed), for: .touchUpInside)

        self.addSubview(btnLoadMore)
        
        btnLoadMore.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.showSpinner(show: false)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showSpinner(show: Bool)  {
        activityIndicator.isHidden = !show
        btnLoadMore.isHidden = show
        if show {
            activityIndicator.startAnimating()
        }else{
            activityIndicator.stopAnimating()
        }
    }
    
    
    @objc func loadMorePressed(){
        self.delegate?.loadMoreButtonSelected(cell: self)
    }
}
