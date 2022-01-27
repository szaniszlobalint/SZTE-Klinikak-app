//
//  MapViewController.swift
//  SZTE Klinikai Tajekoztato app
//
//  Created by Bálint on 2022. 01. 19..
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    	
    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    var coordinates: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        map.delegate = self
        
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse){
            mapThis(destination: calculate())
        }
    }
    
    func calculate() -> CLLocationCoordinate2D {
        let latlong = coordinates.components(separatedBy: ",")
                let lat = Double(latlong[0].trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0.0
        let long = Double(latlong[1].trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0.0
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
        
    }
    
    internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == CLAuthorizationStatus.authorizedWhenInUse {
                mapThis(destination: calculate())
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func mapThis(destination: CLLocationCoordinate2D) {
        print(destination)
        
        let sourceCordinate = (locationManager.location?.coordinate)!
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceCordinate)
        let destPlaceMark = MKPlacemark(coordinate: destination)
        
        let sourceItem = MKMapItem(placemark: sourcePlaceMark)
        let destItem = MKMapItem(placemark: destPlaceMark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceItem
        directionRequest.destination = destItem
        directionRequest.transportType = .automobile
        directionRequest.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate {(response, error ) in
            guard let response = response else {
                if let error = error {
                    print("Something went wrong!")
                }
                return
            }
            
            let route = response.routes[0]
            self.map.addOverlay(route.polyline)
            self.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
    }
        
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
    
}
