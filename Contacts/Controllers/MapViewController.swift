//
//  MapViewController.swift
//  Contacts
//
//  Created by João Luis dos Santos on 13/04/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import MapKit
import UIKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var contact: Contact?
    var locationManager = CLLocationManager() // Objeto que busca a localização do GPS
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Localização do GPS do device
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        getAddress()
        mapView.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Device coordinates: \(locations)")
    }

    func getAddress() {
        let geoCoder = CLGeocoder()
        guard let address = contact?.address else { return }
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location else {
                print("No location found!")
                return
            }
            //print("Localização do contato: \(location)")
            self.mapThis(destinationCoordinate: location.coordinate)
        }
    }

    func mapThis(destinationCoordinate: CLLocationCoordinate2D) {
        guard let sourceCoordinate = locationManager.location?.coordinate else { return }

        let sourcePlaceMark = MKPlacemark(coordinate: sourceCoordinate)
        let destPlaceMark = MKPlacemark(coordinate: destinationCoordinate)

        let sourceItem = MKMapItem(placemark: sourcePlaceMark)
        let destItem = MKMapItem(placemark: destPlaceMark)

        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = destItem
        destinationRequest.transportType = .automobile
        destinationRequest.requestsAlternateRoutes = true

        let directions = MKDirections(request: destinationRequest)
        directions.calculate { (response, error) in
            guard let response = response else {
                if error != nil {
                    print("Something is wrong")
                }
                return
            }
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
        pin(title: "I'm here", coordinate: sourceCoordinate)
        pin(title: contact!.name!, coordinate: destinationCoordinate)
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = UIColor(named: "second")
        render.lineWidth = 2.0
        return render
    }
    
    func pin(title: String, coordinate: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.title = title
        pin.coordinate = coordinate
        self.mapView.showAnnotations([pin], animated: true)
    }

}
