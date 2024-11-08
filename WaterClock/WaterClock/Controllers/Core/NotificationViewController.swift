//
//  NotificartionViewController.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 28/10/24.
//

import UIKit

class NotificationViewController: UIViewController {
    
    var headerView: HeaderNotiView?
    
    private let redView: UIView = {
       let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

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
        headerView = HeaderNotiView(frame: .zero)
        
        redView.addSubview(headerView!)
        headerView?.snp.makeConstraints({ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        })
    }
}
