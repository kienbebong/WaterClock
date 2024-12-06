//
//  SearchViewController.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 22/11/24.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var headerView: HeaderSearchView?
    
    private let nameLabel = [
        NSLocalizedString("WATER_DATA_DAILY", comment: "Water data daily"),
        NSLocalizedString("REPORT_DATA", comment: "Report data"),
        NSLocalizedString("URBAN_WATER_SUPPLY", comment: "Urban water supply"),
        NSLocalizedString("RURAL_WATER_SUPPLY", comment: "Rural water supply"),
        NSLocalizedString("WATER_RECONNECT_AFTER_SUSPEND", comment: "Water reconnect after suspension"),
        NSLocalizedString("METER_CHECK_DEVICE", comment: "Meter and device check"),
        NSLocalizedString("CHANGE_DEVICE_POSITION", comment: "Change device position"),
        NSLocalizedString("CHANGE_WATER_CONSUMPTION", comment: "Change water consumption capacity"),
        NSLocalizedString("ONLINE_CONTRACT_SIGNING", comment: "Online contract signing"),
        NSLocalizedString("CHANGE_CONTRACT_TYPE", comment: "Change contract type"),
        NSLocalizedString("CONTRACT_EXTENSION", comment: "Contract extension"),
        NSLocalizedString("CONTRACT_TERMINATION", comment: "Contract termination"),
        NSLocalizedString("CHANGE_PERSONAL_INFO", comment: "Change personal information"),
        NSLocalizedString("CHANGE_USAGE_PURPOSE", comment: "Change usage purpose"),
        NSLocalizedString("CHANGE_QUOTA", comment: "Change quota"),
        NSLocalizedString("CHANGE_PAYMENT_METHOD", comment: "Change payment method"),
        NSLocalizedString("OTHER_REQUEST", comment: "Other requests"),
        NSLocalizedString("CUSTOMER_FEEDBACK", comment: "Customer feedback response"),
        NSLocalizedString("ONLINE_CONSTRUCTION", comment: "Online construction"),
        NSLocalizedString("WATER_PRESSURE_TEST", comment: "Water pressure testing")
    ]

    
    private let img = ["list.bullet.clipboard", "calendar.badge.clock", "humidity.fill", "humidity.fill", "drop.circle", "gauge.with.dots.needle.bottom.0percent", "location.magnifyingglass", "water.waves", "square.and.pencil", "book.closed.circle", "calendar.badge.clock.rtl", "xmark", "person.crop.circle.badge.checkmark", "repeat.1.circle", "chart.xyaxis.line", "creditcard", "pencil.and.list.clipboard", "exclamationmark.bubble", "phone", "gauge.with.dots.needle.bottom.50percent"]
    
    public var data: [String: String] {
        Dictionary(uniqueKeysWithValues: zip(nameLabel, img))
    }
    
    public var filteredData: [String: String] = [:]
    
    public var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredData = data
        view.backgroundColor = .white

        view.backgroundColor = .white
        setUpHeader()
        setUpTableview()
    }
    
     func setUpHeader() {
        headerView = HeaderSearchView(frame: .zero)
        view.addSubview(headerView!)
        
        headerView?.back = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        headerView?.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
         headerView?.delegate = self
    }
    
    func setUpTableview() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor =  .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView!.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell

        let key = Array(filteredData.keys)[indexPath.row]
        let value = filteredData[key]!

        cell.configure(with: UIImage(systemName: value)!, name: key)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
    }
}

extension SearchViewController: HeaderSearchViewDelegate {
    func didUpdateSearchText(_ searchText: String) {
        if searchText.isEmpty {
            filteredData = data
        } else {
            filteredData = data.filter { (key, value) in
                key.lowercased().contains(searchText.lowercased()) || value.lowercased().contains(searchText.lowercased())
            }
        }
        
        tableView.reloadData()
    }
}
