//
//  CollectionLookUpView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 5/11/24.
//

import UIKit

protocol CollectionLookUpViewDelegate: AnyObject {
    func collectionViewDidTapped(_ cell: CollectionLookUpView, item: Int)
}

class CollectionLookUpView: UIView {
    var delegate: CollectionLookUpViewDelegate?

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
            cell.configure(with: UIImage(systemName: "list.bullet.clipboard") ?? UIImage(), title: NSLocalizedString("ELECTRONIC_BILL", comment: "Electronic bill"))
        } else if indexPath.item == 1 {
            cell.configure(with: UIImage(systemName: "gauge.low") ?? UIImage(), title: NSLocalizedString("WATER_QUALITY_CHECK", comment: "Water quality check"))
        } else if indexPath.item == 2 {
            cell.configure(with: UIImage(systemName: "humidity") ?? UIImage(), title: NSLocalizedString("WATER_USAGE", comment: "Water usage"))
        } else if indexPath.item == 3 {
            cell.configure(with: UIImage(systemName: "chart.line.uptrend.xyaxis") ?? UIImage(), title: NSLocalizedString("OPERATIONAL_PARAMETERS", comment: "Operational parameters"))
        } else if indexPath.item == 4 {
            cell.configure(with: UIImage(systemName: "calendar.badge.clock") ?? UIImage(), title: NSLocalizedString("WATER_CUT_SCHEDULE", comment: "Water cut schedule"))
        } else if indexPath.item == 5 {
            cell.configure(with: UIImage(systemName: "calendar.badge.checkmark") ?? UIImage(), title: NSLocalizedString("WATER_READING_SCHEDULE", comment: "Water reading schedule"))
        } else if indexPath.item == 6 {
            cell.configure(with: UIImage(systemName: "memories") ?? UIImage(), title: NSLocalizedString("PAYMENT_HISTORY", comment: "Payment history"))
        } else if indexPath.item == 7 {
            cell.configure(with: UIImage(systemName: "checklist") ?? UIImage(), title: NSLocalizedString("SERVICE_PROGRESS", comment: "Service progress"))
        } else if indexPath.item == 8 {
            cell.configure(with: UIImage(systemName: "house") ?? UIImage(), title: NSLocalizedString("COLLECTION_POINTS", comment: "Collection points"))
        } else if indexPath.item == 9 {
            cell.configure(with: UIImage(systemName: "book") ?? UIImage(), title: NSLocalizedString("WATER_CONTRACT", comment: "Water contract"))
        } else if indexPath.item == 10 {
            cell.configure(with: UIImage(systemName: "bitcoinsign") ?? UIImage(), title: NSLocalizedString("WATER_PRICE", comment: "Water price"))
        } else {
            cell.configure(with: UIImage(systemName: "house.lodge") ?? UIImage(), title: NSLocalizedString("ADDRESS", comment: "Address"))
        }

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = indexPath.item
        self.delegate?.collectionViewDidTapped(self, item: item)
        
    }
}
