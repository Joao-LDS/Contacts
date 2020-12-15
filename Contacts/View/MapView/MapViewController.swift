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

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Properties
    
    var locationManager = CLLocationManager() // Busca a localização do device
    let viewModel: MapViewModel
    var uiview: MapView
    
    // MARK: - Init
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        uiview = MapView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLocationManager()
        getAddress()
    }
    
    override func loadView() {
        self.view = uiview
    }
    
    // MARK: - Functions
    
    // Localização do GPS do device
    func configureLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation // "nível" de precisão da localização
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func configureView() {
        uiview.mapView.delegate = self
        uiview.backButton.addTarget(self, action: #selector(self.tappedBack), for: .touchUpInside)
    }

    func getAddress() {
        let geoCoder = CLGeocoder()
        let address = viewModel.address
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location else {
                print("No location found!")
                return
            }
            self.mapThis(destinationCoordinate: location.coordinate)
        }
    }

    // Cria a rota entre origem e destino
    func mapThis(destinationCoordinate: CLLocationCoordinate2D) {
        
        // Coordenadas entre origem/destino
        guard let sourceCoordinate = locationManager.location?.coordinate else { return }

        let sourcePlaceMark = MKPlacemark(coordinate: sourceCoordinate)
        let destPlaceMark = MKPlacemark(coordinate: destinationCoordinate)

        let sourceItem = MKMapItem(placemark: sourcePlaceMark)
        let destItem = MKMapItem(placemark: destPlaceMark)

        // Calcula rota
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = destItem
        destinationRequest.transportType = .automobile

        let directions = MKDirections(request: destinationRequest)
        directions.calculate { response, _ in
            guard let response = response else { return }
            let route = response.routes[0]
            // Add a linha em cima da rota
            self.uiview.mapView.addOverlay(route.polyline)
            self.uiview.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
        
        pin(title: "Eu", coordinate: sourceCoordinate)
        pin(title: viewModel.address, coordinate: destinationCoordinate)
    }

    // Cria os pin do mapa
    func pin(title: String, coordinate: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.title = title
        pin.coordinate = coordinate
        uiview.mapView.showAnnotations([pin], animated: true)
    }
    
    // MARK: - Selectors
    
    @objc func tappedBack() {
        dismiss(animated: true)
    }

}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = Constants.Color.main
        render.lineWidth = 2.0
        return render
    }
}
