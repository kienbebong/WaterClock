//
//  PaymentViewController.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 7/11/24.
//

import UIKit

class MeterDataInDayViewController: UIViewController {
    var chooseDateView: ChooseDateView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpChoosDateView()
        
    }
    
    func setUpChoosDateView() {
        chooseDateView = ChooseDateView(frame: .zero)
        view.addSubview(chooseDateView!)
        chooseDateView?.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
    }

}
