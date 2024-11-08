//
//  HomeViewController.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 28/10/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var handbookView: HandbookHomeView?
    private var signInView: SignInHomeView?
    private var headerView: HeaderView?
    private var newsView: NewsView?
    
    private let logoVTB: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "logoVTB")
        image.clipsToBounds = true
        return image
    }()
    
    private let homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 219.5, height: 80)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.backgroundColor = .gray
        return collectionView
    }()
    
    private let newsLabel: UILabel = {
        let label = UILabel()
        label.text = "THÔNG TIN MỚI"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private let callButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tổng đài CSKH miễn phí", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setImage(UIImage(systemName: "phone.fill"), for: .normal)
        button.tintColor = .blue
        button.layer.cornerRadius = 10
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 20), forImageIn: .normal)
        button.configuration = UIButton.Configuration.plain()
        button.configuration?.imagePadding = 20
        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.05)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(OpenTabContact), for: .touchUpInside)
        return button
    }()
    
    @objc func OpenTabContact() {
        let destinationVC = ContactViewController()
        destinationVC.modalPresentationStyle = .pageSheet
        if let sheet = destinationVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        self.present(destinationVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setUpLayOut()
    }
    
    func setUpLayOut() {
        setUpHeaderView()
        setUpScrollView()
        setUpContentView()
        setUpLogoVTB()
        setUpCollectionView()
        setUpSignInView()
        setUpHandbookView()
        setUpNewsView()
        setUpNewsLabel()
        setUpCallButotn()
    }
    
    func setUpHeaderView() {
        headerView = HeaderView(frame: .zero)
        
        headerView?.onSignInTapped = { [weak self] in
            let destinationVC = SignInViewController()
            destinationVC.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(destinationVC, animated: true)
            }
        
        headerView?.onContactTapped = { [weak self] in
            let destinationVC = ContactViewController()
            destinationVC.modalPresentationStyle = .pageSheet
            if let sheet = destinationVC.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            self?.present(destinationVC, animated: true, completion: nil)
        }
        
        headerView?.onSettingInTapped = { [weak self] in
            let destinationVC = SettingViewController()
            destinationVC.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(destinationVC, animated: true)
        }
        
        self.view.addSubview(headerView!)
        headerView?.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
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
    
    func setUpLogoVTB() {
        contentView.addSubview(logoVTB)
        logoVTB.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.leading.equalTo(contentView)
            make.width.equalTo(150)
            make.height.equalTo(70)
        }
    }
    
    func setUpCollectionView() {
        contentView.addSubview(homeCollectionView)
        homeCollectionView.isScrollEnabled = false
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        homeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(logoVTB.snp.bottom)
            make.leading.trailing.equalTo(contentView)
            make.width.equalTo(contentView)
            make.height.equalTo(160)
        }
    }
    
    func setUpSignInView() {
        signInView = SignInHomeView(frame: .zero)
        
        signInView?.onSignInTapped = { [weak self] in
            let vc = SignInViewController()
            vc.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        contentView.addSubview(signInView!)
        
        signInView?.snp.makeConstraints { make in
            make.top.equalTo(homeCollectionView.snp.bottom).offset(10)
            make.width.equalTo(contentView.snp.width)
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(500)
        }
        
    }
    
    func setUpHandbookView() {
        handbookView = HandbookHomeView(frame: .zero)
        contentView.addSubview(handbookView!)
        handbookView?.snp.makeConstraints { make in
            make.top.equalTo(signInView?.snp.bottom ?? view).offset(30)
            make.trailing.equalTo(contentView).offset(-20)
            make.leading.equalTo(contentView).offset(20)
            make.height.equalTo(100)
        }
    }
    
    func setUpNewsLabel() {
        contentView.addSubview(newsLabel)
        newsLabel.snp.makeConstraints { make in
            make.top.equalTo(handbookView?.snp.bottom ?? view).offset(30)
            make.height.equalTo(20)
            make.leading.equalTo(contentView).offset(35)
        }
    }
    
    func setUpNewsView() {
        newsView = NewsView(frame: .zero)
        contentView.addSubview(newsView!)
        newsView?.snp.makeConstraints { make in
            make.top.equalTo(handbookView?.snp.bottom ?? view).offset(55)
            make.trailing.equalTo(contentView).offset(-35)
            make.leading.equalTo(contentView).offset(35)
            make.height.equalTo(210)
        }
    }
    
    func setUpCallButotn() {
        contentView.addSubview(callButton)
        callButton.snp.makeConstraints { make in
            make.top.equalTo(newsView!.snp.bottom).offset(20)
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView.snp.bottom)
            make.width.equalTo(300)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        
        if indexPath.row == 0 {
            cell.configure(with: UIImage(systemName: "list.bullet.clipboard") ?? UIImage(), text: "Hoá đơn điện tử")
        } else if indexPath.row == 1 {
            cell.configure(with: UIImage(systemName: "calendar.badge.clock") ?? UIImage(), text: "Xem lịch cắt điện")
        } else if indexPath.row == 2 {
            cell.configure(with: UIImage(systemName: "checklist") ?? UIImage(), text: "Tiến độ dịch vụ")
        } else {
            cell.configure(with: UIImage(systemName: "iphone.gen1.radiowaves.left.and.right.circle") ?? UIImage(), text: "Thanh toán HĐ")
        }
        cell.backgroundColor = .white

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            DispatchQueue.main.async {
                let vc = ServicesViewController()
                vc.item = 0
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
                vc.switchController(for: vc.item)
            }
        } else if indexPath.item == 1 {
            DispatchQueue.main.async {
                let vc = ServicesViewController()
                vc.item = 4
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
                vc.switchController(for: vc.item)
            }
        } else if indexPath.item == 2 {
            DispatchQueue.main.async {
                let vc = ServicesViewController()
                vc.item = 7
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
                vc.switchController(for: vc.item)
            }
        } else {
            DispatchQueue.main.async {
                let vc = OnlineChargeViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}

