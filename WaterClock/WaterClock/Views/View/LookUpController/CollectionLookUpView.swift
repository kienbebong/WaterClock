//
//  CollectionLookUpView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 5/11/24.
//

import UIKit

class CollectionLookUpView: UIView {

    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
                
        let itemsPerRow: CGFloat = 4
        let padding: CGFloat = 10
        let totalPadding = padding * (itemsPerRow + 1)
        
        let collectionViewWidth = UIScreen.main.bounds.width - 40
        let itemWidth = (collectionViewWidth - totalPadding) / itemsPerRow
                
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = 45
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(LookUpCollectionViewCell.self, forCellWithReuseIdentifier: LookUpCollectionViewCell.identifier)
        collection.backgroundColor = .white
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
    }
    
    func setup() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(400)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
extension CollectionLookUpView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LookUpCollectionViewCell.identifier, for: indexPath) as! LookUpCollectionViewCell
        
        if indexPath.item == 0 {
            cell.configure(with: UIImage(systemName: "list.bullet.clipboard") ?? UIImage(), title: "Hoá đơn điện tử")
        } else if indexPath.item == 1 {
            cell.configure(with: UIImage(systemName: "gauge.low") ?? UIImage(), title: "Điện năng sử dụng")
        } else if indexPath.item == 2 {
            cell.configure(with: UIImage(systemName: "humidity") ?? UIImage(), title: "Điện năng phát lên")
        } else if indexPath.item == 3 {
            cell.configure(with: UIImage(systemName: "chart.line.uptrend.xyaxis") ?? UIImage(), title: "Thông số vận hành")
        } else if indexPath.item == 4 {
            cell.configure(with: UIImage(systemName: "calendar.badge.clock") ?? UIImage(), title: "Lịch cắt điện")
        } else if indexPath.item == 5 {
            cell.configure(with: UIImage(systemName: "calendar.badge.checkmark") ?? UIImage(), title: "Lịch ghi điện")
        } else if indexPath.item == 6 {
            cell.configure(with: UIImage(systemName: "memories") ?? UIImage(), title: "Lịch sử thanh toán")
        } else if indexPath.item == 7 {
            cell.configure(with: UIImage(systemName: "checklist") ?? UIImage(), title: "Tiến độ dịch vụ")
        } else if indexPath.item == 8 {
            cell.configure(with: UIImage(systemName: "house") ?? UIImage(), title: "Điểm thu hộ")
        } else if indexPath.item == 9 {
            cell.configure(with: UIImage(systemName: "book") ?? UIImage(), title: "Hợp đồng sử dụng điện")
        } else if indexPath.item == 10 {
            cell.configure(with: UIImage(systemName: "bitcoinsign") ?? UIImage(), title: "Giá bán điện")
        } else {
            cell.configure(with: UIImage(systemName: "house.lodge") ?? UIImage(), title: "Địa chỉ ")
        }
        
        return cell
    }
    
    
}
