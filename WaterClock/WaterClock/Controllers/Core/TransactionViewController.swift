//
//  TradeViewController.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 28/10/24.
//

import UIKit

class TransactionViewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var headerView: TransactionHeaderView?
    private var featureView: FeatureTransactionView?
    private var requestView: RequestTransactionView?
    private var deviceView: DeviceTransactionView?
    private var contractView: ContractTransactionView?
    private var changeInfoView: ChangeInfoTransactionView?
    private var moreView: MoreChangeTransactionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        setUpLayout()
            
    }
    
    func setUpLayout() {
        setUpHeaderView()
        setUpScrollView()
        setUpContentView()
        setUpfeatureView()
        setUpRequestView()
        setUpDeviceView()
        setUpContractView()
        setUpChangeInfoView()
        setUpMoreChangeView()
    }
    
    func setUpHeaderView() {
        headerView = TransactionHeaderView(frame: .zero)
        view.addSubview(headerView!)
        
        headerView?.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
    }
    
    func setUpScrollView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.width.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(headerView?.snp.bottom ?? view)
        }
    }
    
    func setUpContentView() {
        scrollView.addSubview(contentView)

        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(scrollView.snp.width)
            make.height.greaterThanOrEqualTo(scrollView.snp.height)
        }
    }
    
    func setUpfeatureView() {
        featureView = FeatureTransactionView()
        contentView.addSubview(featureView!)
        
        featureView?.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        featureView?.tappedPayment = { [weak self] in
            let vc = OnlineChargeViewController()
            vc.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setUpRequestView() {
        requestView = RequestTransactionView()
        contentView.addSubview(requestView!)
        
        requestView?.snp.makeConstraints { make in
            make.top.equalTo(featureView!.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    func setUpDeviceView() {
        deviceView = DeviceTransactionView()
        contentView.addSubview(deviceView!)
        
        deviceView?.snp.makeConstraints { make in
            make.top.equalTo(requestView!.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    func setUpContractView() {
        contractView = ContractTransactionView()
        contentView.addSubview(contractView!)
        
        contractView?.snp.makeConstraints { make in
            make.top.equalTo(deviceView!.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(370)
        }
    }
    
    func setUpChangeInfoView() {
        changeInfoView = ChangeInfoTransactionView()
        contentView.addSubview(changeInfoView!)
        
        changeInfoView?.snp.makeConstraints { make in
            make.top.equalTo(contractView!.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(420)
        }
    }
    
    func setUpMoreChangeView() {
        moreView = MoreChangeTransactionView()
        contentView.addSubview(moreView!)
        
        moreView?.snp.makeConstraints { make in
            make.top.equalTo(changeInfoView!.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
}
