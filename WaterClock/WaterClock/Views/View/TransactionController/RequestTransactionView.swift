//
//  RequestTransactionView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 4/11/24.
//

import UIKit

class RequestTransactionView: UIView {
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "drop.fill")
        imageView.tintColor = .black
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("water_supply_request", comment: "Yêu cầu cấp nước")
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()

    private let tableView: UITableView = {
        var table = UITableView()
        table.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.identifier)
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLogo()
        setUpTitleLabel()
        setUpTableView()
    }
    
    func setUpLogo() {
        addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(30)
        }
    }
    
    func setUpTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage).offset(5)
            make.leading.equalTo(logoImage.snp.trailing).offset(15)
            make.width.equalTo(300)
        }
    }
    
    func setUpTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension RequestTransactionView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifier, for: indexPath) as! TransactionTableViewCell
        
        if indexPath.row == 0 {
            cell.configure(with: UIImage(systemName: "humidity.fill") ?? UIImage(), titleLabel: NSLocalizedString("urban_water_supply", comment: "Cấp nước khu đô thị"))
        } else if indexPath.row == 1 {
            cell.configure(with: UIImage(systemName: "humidity.fill") ?? UIImage(), titleLabel: NSLocalizedString("rural_water_supply", comment: "Cấp nước khu nông thôn"))
        } else {
            cell.configure(with: UIImage(systemName: "drop.circle") ?? UIImage(), titleLabel: NSLocalizedString("water_supply_after_suspend", comment: "Cấp nước trở lại khi đã tạm ngưng sử dụng nước"))
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}

