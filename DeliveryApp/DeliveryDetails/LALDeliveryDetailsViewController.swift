//
//  LALDeliveryDetailsViewController.swift
//  Lalamove
//
//  Created by Kumar on 22/09/18.
//  Copyright © 2018 Kumar. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

class LALDeliveryDetailsViewController: UIViewController,  CLLocationManagerDelegate {

    var deliveryDetails: DeliveryDetails!

    var mapView:  MKMapView!
    
    //Details View
    var bgView: LALDeleiveryInfoView!
    var locationManager = CLLocationManager()

    init(deliveryDetails: DeliveryDetails) {
        self.deliveryDetails = deliveryDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        self.mapView = {
            let _mapView = MKMapView()
            _mapView.mapType = MKMapType.standard
            _mapView.isZoomEnabled = true
            _mapView.isScrollEnabled = true
            _mapView.center = self.view.center
            return _mapView
        }()
        self.view.addSubview(self.mapView)
        
        self.bgView = {
            let _view = LALDeleiveryInfoView()
            _view.backgroundColor = UIColor.white
            _view.alpha = 0.9
            return _view
        }()
        self.view.addSubview(self.bgView)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Delivery Details"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.bgView.imgDelivery.loadImageUsingCache(withUrl: self.deliveryDetails.imageURL) { (done) in
        }
        self.bgView.lblDeliveryDescription.text = self.deliveryDetails.description
        
      /*  locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        mapView.showsUserLocation = true
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        */
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addAnnotation()
        
        //TODO: Add direction from current loaction to Destination
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewDidLayoutSubviews() {
        self.mapView.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(self.view.snp.left)
            make.bottomMargin.equalTo(self.view.snp.bottomMargin)
            make.topMargin.equalTo(self.view.snp.topMargin)
            make.rightMargin.equalTo(self.view.snp.right)
        }
        
        self.bgView.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(self.view.snp.leftMargin).offset(30)
            make.rightMargin.equalTo(self.view.snp.rightMargin).offset(-30)
            make.bottomMargin.equalTo(self.view.snp.bottomMargin).offset(-5)
            make.height.equalTo(70)
        }
        
        super.viewDidLayoutSubviews()
    }
    
    func addAnnotation() {

        let annotation = MKPointAnnotation()
        let location = self.deliveryDetails.location
        let coordinates = CLLocationCoordinate2D(latitude: location.lat, longitude: location.lng)
        annotation.coordinate = coordinates
        annotation.title = location.address
        self.mapView.addAnnotation(annotation)
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        self.mapView.setRegion(region, animated: true)
        self.mapView.showsPointsOfInterest = false
        self.mapView.showsUserLocation = true
        
    }
   
    /*
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    
   */


}
