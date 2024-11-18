//
//  SettingViewController.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 1/11/24.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    
    var headerView: HeaderSettingView?
    var headerAfter: HeaderSettingAfterLoginView?
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleSignInNotification(_:)), name: Notification.Name("UserDidSignIn"), object: nil)
        
        setUpLayout()
        
        if SessionManager.shared.isUserSignedIn() {
            headerView?.isHidden = true
            setUpHeaderAfter()
        }
    }
    
    @objc func handleSignInNotification(_ notification: Notification) {
        if let check = notification.object as? Bool, check == true {
            headerView?.isHidden = true
            setUpHeaderAfter()
            view.setNeedsLayout()
        }
    }
    
    func setUpLayout() {
        setUpHeaderView()
        setUpScrollView()
        setUpContentView()
        setUpTableView()
    }
    
    func setUpHeaderView() {
        headerView = HeaderSettingView(frame: .zero)
        view.addSubview(headerView!)
        
        headerView?.onSignInTapped = { [weak self] in
            let vc = SignInViewController()
            vc.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        headerView?.back = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        headerView?.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(150)
        }
    
        headerView?.backgroundColor = .blue

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
            make.trailing.equalTo(scrollView.snp.trailing)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(scrollView.snp.width)
            make.height.greaterThanOrEqualTo(scrollView.snp.height)
        }
    }
    
    func setUpTableView() {
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(-20)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none

    }
    
    func setUpHeaderAfter() {
        headerAfter = HeaderSettingAfterLoginView(frame: .zero)
        view.addSubview(headerAfter!)
        
        headerAfter?.back = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        headerAfter?.onSignOutTapped = { [weak self] in
            DataPersistenceManager.shared.deleteAllAccounts { deleteResult in
                switch deleteResult {
                case .success():
                    print("Deleted Account")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        headerAfter?.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(150)
        }
    
        headerAfter?.backgroundColor = .blue
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier) as! SettingTableViewCell
        if indexPath.row == 0 {
            cell.configure(with: UIImage(systemName: "inset.filled.rectangle.and.person.filled") ?? UIImage(), titleLabel: "Cài dặt tài khoản", detailLabel: "Quản lí thông tin tài khoản, mật khẩu, dăng nhập bằng sinh trắc học")
        } else if indexPath.row == 1 {
            cell.configure(with: UIImage(systemName: "list.bullet.rectangle.portrait.fill") ?? UIImage(), titleLabel: "Liên kết mã PE", detailLabel: "Điểm dùng nước, mã khách hàng")
        } else if indexPath.row == 2 {
            cell.configure(with: UIImage(systemName: "person") ?? UIImage(), titleLabel: "Tài khoản người dùng khác", detailLabel: "Khoá/mở khoá các tài khoản đã liên kết với mã PE của bạn")
        } else if indexPath.row == 3 {
            cell.configure(with: UIImage(systemName: "iphone.gen1.circle") ?? UIImage(), titleLabel: "Cài đặt điện thoại", detailLabel: "Cài đặt thông báo, định vị...")
        } else if indexPath.row == 4 {
            cell.configure(with: UIImage(systemName: "globe") ?? UIImage(), titleLabel: "Ngôn ngữ hỗ trợ", detailLabel: "Tiếng Việt")
        } else if indexPath.row == 5 {
            cell.configure(with: UIImage(systemName: "square.and.arrow.up") ?? UIImage(), titleLabel: "Chia sẻ ứng dụng", detailLabel: "Cho phép sao chép đường dẫn, mã QR để gửi đến bạn bè")
        } else  {
            cell.configure(with: UIImage(systemName: "book") ?? UIImage(), titleLabel: "Hướng dẫn sử dụng", detailLabel: "Hướng dẫn dành cho ngừoi mới")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
