//
//  ChangeInfoTransactionView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 4/11/24.
//

import UIKit

class ChangeInfoTransactionView: UIView {

    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.text.rectangle")
        imageView.tintColor = .black
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("request_change_info", comment: "Text for requesting to change information")
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
            make.width.equalTo(350)
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

extension ChangeInfoTransactionView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifier, for: indexPath) as! TransactionTableViewCell
        
        if indexPath.row == 0 {
            cell.configure(with: UIImage(systemName: "person.crop.circle.badge.checkmark") ?? UIImage(), titleLabel: NSLocalizedString("change_info", comment: ""))
        } else if indexPath.row == 1 {
            cell.configure(with: UIImage(systemName: "repeat.1.circle") ?? UIImage(), titleLabel: NSLocalizedString("change_purpose", comment: ""))
        } else if indexPath.row == 2 {
            cell.configure(with: UIImage(systemName: "chart.xyaxis.line") ?? UIImage(), titleLabel: NSLocalizedString("change_limit", comment: ""))
        } else if indexPath.row == 3 {
            cell.configure(with: UIImage(systemName: "creditcard") ?? UIImage(), titleLabel: NSLocalizedString("change_payment", comment: ""))
        } else {
            cell.configure(with: UIImage(systemName: "pencil.and.list.clipboard") ?? UIImage(), titleLabel: NSLocalizedString("other_requests", comment: ""))
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
