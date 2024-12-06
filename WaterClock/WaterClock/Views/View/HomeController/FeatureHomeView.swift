//
//  FeatureHomeView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 30/10/24.
//

import UIKit

class FeatureHomeView: UIView {

        private let logoImageView1: UIImageView = {
           let imageView = UIImageView()
           imageView.image = UIImage(systemName: "checkmark.seal.fill")
            imageView.tintColor = .blue
           imageView.contentMode = .scaleAspectFit
           return imageView
       }()
       
       private let logoImageView2: UIImageView = {
           let imageView = UIImageView()
           imageView.image = UIImage(systemName: "checkmark.seal.fill")
           imageView.tintColor = .blue
           imageView.contentMode = .scaleAspectFit
           return imageView
       }()
       
       private let logoImageView3: UIImageView = {
           let imageView = UIImageView()
           imageView.image = UIImage(systemName: "checkmark.seal.fill")
           imageView.tintColor = .blue
           imageView.contentMode = .scaleAspectFit
           return imageView
       }()
       
       private let logoImageView4: UIImageView = {
           let imageView = UIImageView()
           imageView.image = UIImage(systemName: "checkmark.seal.fill")
           imageView.tintColor = .blue
           imageView.contentMode = .scaleAspectFit
           return imageView
       }()
       
    private let label1: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("EFFECTIVE_WATER_CONTROL", comment: "Effective water source control")
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    private let label2: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("DAILY_WATER_REPORT", comment: "Daily water index report")
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    private let label3: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("BILL_REPORT_ON_DUE", comment: "Bill report for due payments")
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    private let label4: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("MANAGE_PE_CODES", comment: "Manage multiple PE codes simultaneously")
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           setup()
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let stackView = UIStackView(arrangedSubviews: [
            createStackItem(logo: logoImageView1, label: label1),
            createStackItem(logo: logoImageView2, label: label2),
            createStackItem(logo: logoImageView3, label: label3),
            createStackItem(logo: logoImageView4, label: label4)
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.alignment = .leading
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
    }
    
    private func createStackItem(logo: UIImageView, label: UILabel) -> UIView {
        let itemStackView = UIStackView(arrangedSubviews: [logo, label])
        itemStackView.axis = .horizontal
        itemStackView.spacing = 10
        itemStackView.alignment = .leading
        logo.translatesAutoresizingMaskIntoConstraints = false
        return itemStackView
    }
}
