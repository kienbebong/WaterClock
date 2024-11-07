//
//  ServicesViewController.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 5/11/24.
//

import UIKit

class ServicesViewController: UIViewController {
    
    var item: Int = 0
    var headerView: HeaderServicesView?
    private let redView: UIView = {
       let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRedView()
        setUpHeaderView()
    }
    
    func setUpRedView() {
        view.addSubview(redView)
        redView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    func setUpHeaderView() {
        headerView = HeaderServicesView(frame: .zero)
        redView.addSubview(headerView!)
        headerView?.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }
        
        headerView?.delegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {

    }
}


extension ServicesViewController: HeaderServicesViewDelegate {
    func collectionViewDidTappedHeader(_ cell: HeaderServicesView, item: Int) {
        self.item = item
    }
}
