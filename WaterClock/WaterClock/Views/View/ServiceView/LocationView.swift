//
//  LocationView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 19/11/24.
//

import UIKit
import MapKit
import CoreLocation

class LocationView: UIView, MKMapViewDelegate, CLLocationManagerDelegate {
    private var didSetInitialRegion = false
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        return map
    }()
    
    private let locationUser: CLLocationManager = {
        let location = CLLocationManager()
        return location
    }()
    
    private let zoomInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        return button
    }()
        
    private let zoomOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        seteUpMap()
        markLocation()
        markLocation2()
        markLocation3()
        markLocation4()
        setUpButton()
        setupActions()
        
    }
    
    private func setupActions() {
        zoomInButton.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
        zoomOutButton.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
    }
    
    @objc private func zoomIn() {
        var region = mapView.region
        region.span.latitudeDelta = max(region.span.latitudeDelta / 2.0, 0.001)
        region.span.longitudeDelta = max(region.span.longitudeDelta / 2.0, 0.001)
        mapView.setRegion(region, animated: true)
    }
        
    @objc private func zoomOut() {
        var region = mapView.region
        region.span.latitudeDelta = min(region.span.latitudeDelta * 2.0, 180.0)
        region.span.longitudeDelta = min(region.span.longitudeDelta * 2.0, 180.0)
        mapView.setRegion(region, animated: true)
    }
    
    func setUpButton() {
        
        addSubview(zoomOutButton)
        zoomOutButton.snp.makeConstraints { make in
            make.bottom.equalTo(mapView.snp.bottom).offset(-50)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(40)
        }
        
        addSubview(zoomInButton)
        zoomInButton.snp.makeConstraints { make in
            make.bottom.equalTo(zoomOutButton.snp.top).offset(-20)
            make.trailing.width.height.equalTo(zoomOutButton)
        }
    }
    
    func seteUpMap() {
        addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        mapView.mapType = .mutedStandard
        mapView.delegate = self
        
        locationUser.delegate = self
        locationUser.desiredAccuracy = kCLLocationAccuracyBest
        locationUser.requestWhenInUseAuthorization()
        locationUser.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            
            if !didSetInitialRegion {
                let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                self.mapView.setRegion(region, animated: true)
                didSetInitialRegion = true
            }
        }
    
    private func markLocation() {
        let latitude: CLLocationDegrees = 10.813644
        let longitude: CLLocationDegrees = 106.698350
            
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = "VTB Shop"
        annotation.subtitle = "TP. Hồ Chí Minh"
            
        mapView.addAnnotation(annotation)
            
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    private func markLocation2() {
        let latitude: CLLocationDegrees = 10.799421
        let longitude: CLLocationDegrees = 106.665151
            
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = "Trung tâm bảo hành"
        annotation.subtitle = "TP. Hồ Chí Minh"
            
        mapView.addAnnotation(annotation)
            
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    private func markLocation3() {
        let latitude: CLLocationDegrees = 10.824663
        let longitude: CLLocationDegrees = 106.585950
            
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = "Nhà máy điện lạnh"
        annotation.subtitle = "TP. Hồ Chí Minh"
            
        mapView.addAnnotation(annotation)
            
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    private func markLocation4() {
        let latitude: CLLocationDegrees = 10.760118
        let longitude: CLLocationDegrees = 106.768267
            
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = "Nhà máy điện tử"
        annotation.subtitle = "TP. Hồ Chí Minh"
            
        mapView.addAnnotation(annotation)
            
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }

        let alert = UIAlertController(title: annotation.title ?? "Vị trí đã chọn",
                                       message: "Bạn có muốn dẫn đường từ vị trí hiện tại đến đây không?",
                                       preferredStyle: .alert)
        
        let navigateAction = UIAlertAction(title: "Dẫn đường", style: .default) { _ in
            self.showDirections(to: annotation.coordinate)
        }
        let cancelAction = UIAlertAction(title: "Hủy", style: .cancel, handler: nil)
        
        alert.addAction(navigateAction)
        alert.addAction(cancelAction)
        
        if let controller = mapView.window?.rootViewController {
            controller.present(alert, animated: true, completion: nil)
        }
    }
    
    private func showDirections(to destination: CLLocationCoordinate2D) {
        guard let currentLocation = locationUser.location?.coordinate else {
            print("Không lấy được vị trí hiện tại")
            return
        }
        
        let sourcePlacemark = MKPlacemark(coordinate: currentLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceItem
        directionRequest.destination = destinationItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { response, error in
            guard let route = response?.routes.first, error == nil else {
                print("Lỗi tính toán lộ trình: \(error?.localizedDescription ?? "Không xác định")")
                return
            }
            
            self.mapView.removeOverlays(self.mapView.overlays)
            
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 4.0
            return renderer
        }
        return MKOverlayRenderer()
    }


}


