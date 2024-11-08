//
//  NotificationCollectionViewCell.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 8/11/24.
//

import UIKit

class NotificationCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NotificationCollectionViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUpLabel() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(-10)
            make.height.equalTo(50)
            make.width.equalTo(110)
            make.width.greaterThanOrEqualTo(50)
        }
    }
    
    func configure(with text: String) {
        label.text = text
    }
}
