//
//  LALDeliveryListsTableViewController.swift
//  Lalamove
//
//  Created by Kumar on 19/09/18.
//  Copyright © 2018 Kumar. All rights reserved.
//

import UIKit

let pageItems = 5

class LALDeliveryListsTableViewController: UITableViewController, LALTableViewCellLoadMoreDelegate{

    var deliveryListsModelController = LALDeliveryListsModelController()
    var networkRequestingView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customiseTableView()
      
        self.title = "Things To Deliver"
        deliveryListsModelController.delgeate = self
        
        self.getDeliveryItems()
        networkRequestingView = UIViewController.displaySpinner(onView: self.view)

    }
    
    func customiseTableView()  {
        tableView.register(LALDeliveryListsTableViewCell.self, forCellReuseIdentifier: "CellDelivery")
        tableView.register(LALLoadMoreTableViewCell.self, forCellReuseIdentifier: "CellLoadMore")
        
        // tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 70
        
        //tableView.rowHeight = 80
        
        tableView.refreshControl = UIRefreshControl()
        if let _refreshControl = tableView.refreshControl{
            _refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            _refreshControl.addTarget(self, action: #selector(getDeliveryItems), for: .valueChanged)
            _refreshControl.tintColor = LALColors.navTintColor
            self.tableView.addSubview(_refreshControl)
        }
        tableView.separatorColor = LALColors.navTintColor
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return deliveryListsModelController.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var noOfRows = deliveryListsModelController.numberOfRows()
        
        if deliveryListsModelController.canLoadMore() && noOfRows != 0{
            noOfRows += 1
        }
        return noOfRows
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let isLastCell = indexPath.row == deliveryListsModelController.numberOfRows()
        let canLoadMore = (deliveryListsModelController.canLoadMore() && isLastCell)
        if canLoadMore {
            return 50
        }
        return 80
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let isLastCell = indexPath.row == deliveryListsModelController.numberOfRows()
        let canLoadMore = (deliveryListsModelController.canLoadMore() && isLastCell)
        
        if canLoadMore {
            let cell =  LALLoadMoreTableViewCell()
           // cell = tableView.dequeueReusableCell(withIdentifier: "CellLoadMore", for: indexPath) as! LALLoadMoreTableViewCell
            cell.delegate = self
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellDelivery", for: indexPath) as! LALDeliveryListsTableViewCell
        let deliveryItem = deliveryListsModelController.getDeliveryitem(atIndex: indexPath.row)
        
        cell.setupUI(deliveryItem: deliveryItem)
        cell.imageDeliveryIcon.loadImageUsingCache(withUrl: deliveryItem.imageURL, completionHandelr: { (isSuccessful) in
            if (isSuccessful){
                cell.setNeedsLayout()
                cell.layoutIfNeeded()
            }
        })
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = self.tableView.cellForRow(at: indexPath)
            else{return}
        
        if cell.isKind(of: LALDeliveryListsTableViewCell.self){
            let deliveryItem = deliveryListsModelController.getDeliveryitem(atIndex: indexPath.row)
            
            let deliveryDetailsCtl = LALDeliveryDetailsViewController(deliveryDetails: deliveryItem)
            self.navigationController?.pushViewController(deliveryDetailsCtl, animated: true)
        }
    }
    
    //MARK: Fetch Delivery Items
    @objc func getDeliveryItems(){
        deliveryListsModelController.fetchDeliveryListItems(isFirstFetch: true)
    }
    
    //MARK: LALTableViewCellLoadMore Delegate
    func loadMoreButtonSelected(cell: LALLoadMoreTableViewCell) {
        cell.showSpinner(show: true)
       deliveryListsModelController.fetchDeliveryListItems(isFirstFetch: false)
    }
}


extension LALDeliveryListsTableViewController: DeliveryListsResponseDelegate{
    func deliveryItemsLoaded(isFirstFetch: Bool, range: NSRange) {
        self.tableView.reloadData()
        if isFirstFetch {
            self.stopRefreshing()
        }
    }
    
    func error(_ errror: String) {
        UIViewController.removeSpinner(spinner: networkRequestingView)

        let alert = UIAlertController(title: errror, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] (action) in
            self.tableView.reloadData() //Reset the Load more cell
            self.stopRefreshing() //Stop if Any
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func stopRefreshing() {
        if let refreshControl = tableView.refreshControl{
            if refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }else{
                UIViewController.removeSpinner(spinner: networkRequestingView)
            }
        }
    }
}

extension UIViewController {
    
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.color = LALColors.navTintColor
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
