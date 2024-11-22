//
//  ContactLocationViewController.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 7/11/24.
//

import UIKit
import MapKit

class ContactLocationViewController: UIViewController {

    var mapView: LocationView?
        
    override func viewDidLoad() {
        super.viewDidLoad()
           
        setUpMap()
    }
    
    func setUpMap() {
        mapView = LocationView(frame: .zero)
        view.addSubview(mapView!)
        mapView?.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }

}
