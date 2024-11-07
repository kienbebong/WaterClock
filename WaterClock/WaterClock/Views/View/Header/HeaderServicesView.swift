//
//  HeaderServicesView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 5/11/24.
//

import UIKit

protocol HeaderServicesViewDelegate: AnyObject {
    func collectionViewDidTappedHeader(_ cell: HeaderServicesView, item: Int)
}

class HeaderServicesView: UIView {
    
    weak var delegate: HeaderServicesViewDelegate?
    var back: (() -> Void)?

    
    private let backLogoImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "arrow.backward")
        img.tintColor = .gray
        img.isUserInteractionEnabled = true
        return img
    }()
    
    

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.minimumLineSpacing = 35
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ServicesCollectionViewCell.self, forCellWithReuseIdentifier: ServicesCollectionViewCell.identifier)
        collection.backgroundColor = .white
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        
        setUp()
    }
    
    func setUp() {

        setUpCollectionView()
        setUpBackLogo()
        
    }
    
    func setUpBackLogo() {
        self.addSubview(backLogoImage)
        backLogoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(28)
        }
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(backHome))
        backLogoImage.addGestureRecognizer(tapGesture1)
    }
    
    
    func setUpCollectionView() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(70)
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
extension HeaderServicesView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServicesCollectionViewCell.identifier, for: indexPath) as! ServicesCollectionViewCell
        
        if indexPath.item == 0 {
            cell.configure(with: UIImage(systemName: "list.bullet.clipboard") ?? UIImage())
        } else if indexPath.item == 1 {
            cell.configure(with: UIImage(systemName: "gauge.low") ?? UIImage())
        } else if indexPath.item == 2 {
            cell.configure(with: UIImage(systemName: "humidity") ?? UIImage())
        } else if indexPath.item == 3 {
            cell.configure(with: UIImage(systemName: "chart.line.uptrend.xyaxis") ?? UIImage())
        } else if indexPath.item == 4 {
            cell.configure(with: UIImage(systemName: "calendar.badge.clock") ?? UIImage())
        } else if indexPath.item == 5 {
            cell.configure(with: UIImage(systemName: "calendar.badge.checkmark") ?? UIImage())
        } else if indexPath.item == 6 {
            cell.configure(with: UIImage(systemName: "memories") ?? UIImage())
        } else if indexPath.item == 7 {
            cell.configure(with: UIImage(systemName: "checklist") ?? UIImage())
        } else if indexPath.item == 8 {
            cell.configure(with: UIImage(systemName: "house") ?? UIImage())
        } else if indexPath.item == 9 {
            cell.configure(with: UIImage(systemName: "book") ?? UIImage())
        } else if indexPath.item == 10 {
            cell.configure(with: UIImage(systemName: "bitcoinsign") ?? UIImage())
        } else {
            cell.configure(with: UIImage(systemName: "house.lodge") ?? UIImage())
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = indexPath.item
        self.delegate?.collectionViewDidTappedHeader(self, item: item)
    }
    
    @objc private func backHome() {
        back?()
    }
}
