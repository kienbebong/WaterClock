//
//  BookViewController.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 8/11/24.
//

import UIKit

class BookViewController: UIViewController {
    
    private var headerView: HeaderBookView?
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let redView: UIView = {
       let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpRedView()
        setUpHeaderView()
        setUpScrollView()
        setUpContentView()
        setUpTableView()

    }
    
    func setUpRedView() {
        view.addSubview(redView)
        redView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    func setUpHeaderView() {
        headerView = HeaderBookView(frame: .zero)
        redView.addSubview(headerView!)
        headerView?.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }
        
        
        headerView?.back = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
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
    
    func setUpTableView() {
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView!.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        
    }
}
extension BookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.identifier, for: indexPath) as! BookTableViewCell
        
        if indexPath.row == 0 {
            cell.configure(with: UIImage(systemName: "drop") ?? UIImage(),
                           titleLabel: NSLocalizedString("GUIDE_WATER_SAVING", comment: "Guide to saving water"))
        } else if indexPath.row == 1 {
            cell.configure(with: UIImage(systemName: "book") ?? UIImage(),
                           titleLabel: NSLocalizedString("GUIDE_CULTURE", comment: "Guide to VTB culture"))
        } else if indexPath.row == 2 {
            cell.configure(with: UIImage(systemName: "building") ?? UIImage(),
                           titleLabel: NSLocalizedString("GUIDE_OFFICE_WATER_SAVING", comment: "Guide to saving water in offices and factories"))
        } else if indexPath.row == 3 {
            cell.configure(with: UIImage(systemName: "house") ?? UIImage(),
                           titleLabel: NSLocalizedString("GUIDE_HOME_WATER_SAVING", comment: "Guide to saving water at home"))
        } else if indexPath.row == 4 {
            cell.configure(with: UIImage(systemName: "creditcard") ?? UIImage(),
                           titleLabel: NSLocalizedString("GUIDE_CASHLESS_PAYMENT", comment: "Guide to cashless payment"))
        } else if indexPath.row == 5 {
            cell.configure(with: UIImage(systemName: "exclamationmark.triangle") ?? UIImage(),
                           titleLabel: NSLocalizedString("GUIDE_LEAK_PREVENTION", comment: "Guide to leak prevention measures"))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    
}
