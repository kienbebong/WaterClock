//
//  ServicesViewController.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 5/11/24.
//

import UIKit
import SnapKit

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
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRedView()
        setUpHeaderView()
        setUpView()
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
        
        headerView?.back = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        headerView?.delegate = self
        
    }
    
    func setUpView() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(headerView!.snp.bottom).offset(10)
            make.leading.width.bottom.equalToSuperview()
        }
    }
    
    func switchController(for item: Int) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        switch item {
        case 0:
            let vc = MeterDataInDayViewController()
            addChild(vc)
            stackView.addArrangedSubview(vc.view)
            vc.didMove(toParent: self)
        case 1:
            let vc = CheckQualityWaterViewController()
            addChild(vc)
            stackView.addArrangedSubview(vc.view)
            vc.didMove(toParent: self)
        case 2:
            let vc = WaterUpViewController()
            addChild(vc)
            stackView.addArrangedSubview(vc.view)
            vc.didMove(toParent: self)
        case 3:
            let vc = ParameterViewController()
            addChild(vc)
            stackView.addArrangedSubview(vc.view)
            vc.didMove(toParent: self)
        case 4:
            let vc = InstantByDateViewController()
            addChild(vc)
            stackView.addArrangedSubview(vc.view)
            vc.didMove(toParent: self)
        case 5:
            let vc = RecordCalenderViewController()
            addChild(vc)
            stackView.addArrangedSubview(vc.view)
            vc.didMove(toParent: self)
        case 6:
            let vc = PayHistoryViewController()
            addChild(vc)
            stackView.addArrangedSubview(vc.view)
            vc.didMove(toParent: self)
        case 7:
            let vc = ServiceProgressViewController()
            addChild(vc)
            stackView.addArrangedSubview(vc.view)
            vc.didMove(toParent: self)
        case 8:
            let vc = CollectionLocationViewController()
            addChild(vc)
            stackView.addArrangedSubview(vc.view)
            vc.didMove(toParent: self)
        case 9:
            let vc = ContractWaterConsumeViewController()
            addChild(vc)
            stackView.addArrangedSubview(vc.view)
            vc.didMove(toParent: self)
        case 10:
            let vc = PriceViewController()
            addChild(vc)
            stackView.addArrangedSubview(vc.view)
            vc.didMove(toParent: self)
        case 11:
            let vc = ContactLocationViewController()
            addChild(vc)
            stackView.addArrangedSubview(vc.view)
            vc.didMove(toParent: self)
        default:
            break
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {

    }
}


extension ServicesViewController: HeaderServicesViewDelegate {
    func collectionViewDidTappedHeader(_ cell: HeaderServicesView, item: Int) {
        self.item = item
        
        switchController(for: item)
        
    }
}
