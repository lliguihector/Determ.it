//
//  LocationVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 9/4/22.
//

import Foundation
import UIKit
import CoreLocation
import MapKit


class LocationVC: UIViewController{
   
    @IBOutlet weak var MapView: MKMapView!
    
    @IBOutlet weak var recenterBtn: UIButton!
    
    @IBOutlet weak var searchBtn: UIButton!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 100
    var previousLocation: CLLocation?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//    MapView.delegate = self
        
        ///Checki If  Location Services is enabled
        checkLocationServices()
        
        
        styleMapViewUIButtons(recenterBtn, .systemBlue, "location.fill")
        styleMapViewUIButtons(searchBtn, .systemRed, "magnifyingglass")
    }
    
    ///A Function to individualty style MapView UI Buttons
    func styleMapViewUIButtons(_ btnName: UIButton,  _ btnColor:UIColor, _ systemImageString: String ){
        let image = UIImage(systemName: systemImageString, withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .heavy))
        
        btnName.backgroundColor = btnColor
        btnName.setImage(image, for: .normal)
        btnName.tintColor = .white
        btnName.setTitleColor(.white, for: .normal)
        btnName.layer.shadowRadius = 10
        btnName.layer.shadowOpacity = 1
        btnName.layer.masksToBounds = true
        btnName.layer.cornerRadius = 30
    }
    
    
    //Check if location Services are enabled if not prompt user to turn on location services
    func checkLocationServices(){
        
        if CLLocationManager.locationServicesEnabled(){
            setUpLocationManager()
            checkLocationAuthorization()
        }else{
            //Show an alert to the user leting them know they have to turn this on.
            Alert.showBasicAlert(on: self, with: "Location Services", message: "In order to use this app Location Services must be enabled")
        }
        
    }
        
        
        ///Set up location manager to use CLLocationManagerDelegate helper methods
        func setUpLocationManager(){
            locationManager.delegate = self

            locationManager.desiredAccuracy = kCLLocationAccuracyBest
    //        locationManager.requestLocation()
            
        }
    
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
    
        case .authorizedWhenInUse:
    //DO Map Stuff
            ///Shows users current location on a map as a blue point
            startTrackingUserLocation()
          
        case .denied:
            //Show alert instructing them how to turn on permisions
//            Alert.showBasicAlert(on: self, with: "Location Services Desabeled", message: "Please turn on Location services in setting to keep using the App")
    ///Naviagtes the user to setting in orther for them to turn on location services
            navigateTheUserToLocationSetting()
            break
        case.notDetermined:
            locationManager.requestWhenInUseAuthorization()
        break
        case .restricted:
            //Show an alert letting thme know what's up
        break
        case .authorizedAlways:
        break
        
        @unknown default:
            fatalError()
        }}

    

    
    func startTrackingUserLocation(){
        MapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: MapView)
    }
    
    
        func getCenterLocation(for mapView: MKMapView) -> CLLocation{
            let latitude = MapView.centerCoordinate.latitude
            let longitude = MapView.centerCoordinate.longitude
            return CLLocation(latitude: latitude, longitude: longitude)
        }
        

        
        func navigateTheUserToLocationSetting(){
            let alertController = UIAlertController(title: "Alert", message: "Determit needs your exact location to start navigation", preferredStyle: .alert)
               let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                   guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                       return
                   }
                   if UIApplication.shared.canOpenURL(settingsUrl) {
                       UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                           // Successfully navigated to settings
                       })
                   }
               }
            
               let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
               alertController.addAction(okAction)
               alertController.addAction(cancelAction)
               self.present(alertController, animated: true, completion: nil)
        }
    
    
    @IBAction func recenterLocationBtn(){
        
        centerViewOnUserLocation()
    }
    
   
    ///Center the user location
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            MapView.setRegion(region, animated: true)
        }
    }
    
        
    }

    

//MARK: - CCLocationManagerDelegate
extension LocationVC: CLLocationManagerDelegate{

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

