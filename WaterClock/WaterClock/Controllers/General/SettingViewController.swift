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
            
            UserDefaults.standard.set(false, forKey: "isUserSignedIn")
            self?.handleSignOut()
            self?.navigationController?.popViewController(animated: true)
        }
        
        headerAfter?.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(150)
        }
    
        headerAfter?.backgroundColor = .blue
    }
    
    func handleSignOut() {
        NotificationCenter.default.post(name: Notification.Name("UserDidSignIn"), object: false)
        UserDefaults.standard.set(false, forKey: "isUserSignedIn")
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier) as! SettingTableViewCell
        if indexPath.row == 0 {
            cell.configure(
                with: UIImage(systemName: "inset.filled.rectangle.and.person.filled") ?? UIImage(),
                titleLabel: NSLocalizedString("ACCOUNT_SETTINGS", comment: "Account settings title"),
                detailLabel: NSLocalizedString("ACCOUNT_MANAGEMENT_DESCRIPTION", comment: "Account management description")
            )
        } else if indexPath.row == 1 {
            cell.configure(
                with: UIImage(systemName: "list.bullet.rectangle.portrait.fill") ?? UIImage(),
                titleLabel: NSLocalizedString("LINK_PE_CODE", comment: "PE Code link title"),
                detailLabel: NSLocalizedString("WATER_POINTS_CUSTOMER_CODE", comment: "Description of water points and customer code")
            )
        } else if indexPath.row == 2 {
            cell.configure(
                with: UIImage(systemName: "person") ?? UIImage(),
                titleLabel: NSLocalizedString("OTHER_USER_ACCOUNTS", comment: "Other user accounts title"),
                detailLabel: NSLocalizedString("MANAGE_ACCOUNT_ACCESS", comment: "Manage linked user accounts description")
            )
        } else if indexPath.row == 3 {
            cell.configure(
                with: UIImage(systemName: "iphone.gen1.circle") ?? UIImage(),
                titleLabel: NSLocalizedString("PHONE_SETTINGS", comment: "Phone settings title"),
                detailLabel: NSLocalizedString("NOTIFICATIONS_LOCATION_SETTINGS", comment: "Notification and location settings description")
            )
        } else if indexPath.row == 4 {
            cell.configure(
                with: UIImage(systemName: "globe") ?? UIImage(),
                titleLabel: NSLocalizedString("LANGUAGE_SUPPORT", comment: "Language support title"),
                detailLabel: NSLocalizedString("VIETNAMESE", comment: "Vietnamese language detail")
            )
        } else if indexPath.row == 5 {
            cell.configure(
                with: UIImage(systemName: "square.and.arrow.up") ?? UIImage(),
                titleLabel: NSLocalizedString("SHARE_APP", comment: "Share app title"),
                detailLabel: NSLocalizedString("COPY_LINK_QR", comment: "Description for copying link or QR code to share")
            )
        } else {
            cell.configure(
                with: UIImage(systemName: "book") ?? UIImage(),
                titleLabel: NSLocalizedString("USER_GUIDE", comment: "User guide title"),
                detailLabel: NSLocalizedString("NEW_USER_INSTRUCTIONS", comment: "Instructions for new users")
            )
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5 {
            let destinationVC = ShareViewController()
            destinationVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(destinationVC, animated: true)
        } else if indexPath.row == 4 {
            showLanguageSelectiom()
        }
    }
    
    func showLanguageSelectiom() {
        let alertController = UIAlertController(title: NSLocalizedString("CHOOSE_LANGUAGE", comment: "Title for language selection"),
                                                message: NSLocalizedString("SELECT_LANGUAGE_MESSAGE", comment: "Message asking the user to choose a language"),
                                                preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: NSLocalizedString("VIETNAMESE1", comment: "Title for Vietnamese option"), style: .default, handler: { _ in
            self.setLanguageToVietnamese()
        }))

        alertController.addAction(UIAlertAction(title: NSLocalizedString("ENGLISH1", comment: "Title for English option"), style: .default, handler: { _ in
            self.setLanguageToEnglish()
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func setLanguageToVietnamese() {
        UserDefaults.standard.set(["vi"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        Bundle.setLanguage("vi")
        let alert = UIAlertController(title: NSLocalizedString("CHANGE_LANGUAGE", comment: "Title for changing language"), message: NSLocalizedString("LANGUAGE_CHANGE_MESSAGE", comment: "Message explaining the app restart due to language change"),preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            exit(0)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func setLanguageToEnglish() {
        UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        Bundle.setLanguage("en")
        let alert = UIAlertController(title: NSLocalizedString("CHANGE_LANGUAGE", comment: "Title for changing language"), message: NSLocalizedString("LANGUAGE_CHANGE_MESSAGE", comment: "Message explaining the app restart due to language change"),preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            exit(0)
        }))
        present(alert, animated: true, completion: nil)
    }
}

