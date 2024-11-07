//
//  LookUpViewController.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 28/10/24.
//

import UIKit

class LookUpViewController: UIViewController {
    var headerView: HeaderLookUpView?
    var collectionView: CollectionLookUpView?
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let imageChart: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "chart")
        img.contentMode = .scaleAspectFit
        return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        setUpHeaderView()
        setUpScrollView()
        setUpContentView()
        setUpChart()
        setUpCollection()
    }
    
    func setUpHeaderView() {
        self.headerView?.removeFromSuperview()
        headerView = HeaderLookUpView()
        view.addSubview(headerView!)
        
        headerView?.onSignInTapped = { [weak self] in
            let destinationVC = SignInViewController()
            destinationVC.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(destinationVC, animated: true)
            }
        
        headerView?.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
    }
    
    
    func setUpScrollView() {
        self.view.addSubview(scrollView)
        
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
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(scrollView.snp.width)
            make.height.greaterThanOrEqualTo(scrollView.snp.height)
        }
    }
    
    func setUpChart() {
        contentView.addSubview(imageChart)
        imageChart.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.centerX.equalTo(contentView)
            make.width.height.equalTo(250)
        }
    }
    
    func setUpCollection() {
        collectionView = CollectionLookUpView(frame: .zero)
        contentView.addSubview(collectionView!)
        collectionView?.snp.makeConstraints { make in
            make.top.equalTo(imageChart.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        collectionView?.delegate = self
    }
}
extension LookUpViewController: CollectionLookUpViewDelegate {
    func collectionViewDidTapped(_ cell: CollectionLookUpView, item: Int) {
        DispatchQueue.main.async { [weak self] in
            let vc = ServicesViewController()
            vc.item = item
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
