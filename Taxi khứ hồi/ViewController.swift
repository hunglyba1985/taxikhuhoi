//
//  ViewController.swift
//  Taxi khứ hồi
//
//  Created by Macbook Pro on 6/27/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire




class ViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate {

    @IBOutlet weak var googleMap: GMSMapView!
    
    var locationManager = CLLocationManager()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.configureLocationAuthority()
    }
    
    
    
    func configureLocationAuthority(){
        
        print("get location ------------  ")
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    
    func setupGoogleMap(){
        self.googleMap.delegate = self
        self.googleMap?.isMyLocationEnabled = true
        self.googleMap.settings.myLocationButton = true
        self.googleMap.settings.compassButton = true
        self.googleMap.settings.zoomGestures = true
    }
    
    
    // MARK: function for create a marker pin on map
    func createMarker(titleMarker: String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.icon = iconMarker
        marker.map = googleMap
    }
    
    
    //MARK: - Location Manager delegates
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get location : \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        self.googleMap?.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        
    }
    
    // MARK: - GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        googleMap.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        googleMap.isMyLocationEnabled = true
        
        if (gesture) {
            mapView.selectedMarker = nil
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        googleMap.isMyLocationEnabled = true
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("COORDINATE \(coordinate)") // when you tapped coordinate
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        googleMap.isMyLocationEnabled = true
        googleMap.selectedMarker = nil
        return false
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

