//
//  NewsView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 31/10/24.
//

import UIKit

class NewsView: UIView {

    private let newsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: 350, height: 200)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
        collection.backgroundColor = .white
        return collection
    }()

    func setUpNews() {
        addSubview(newsCollectionView)
        newsCollectionView.dataSource = self
        newsCollectionView.delegate = self
        newsCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(210)
        }
    }
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           setUpNews()
       }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension NewsView: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as! NewsCollectionViewCell
        
        if indexPath.row == 0 {
            cell.configure(with: UIImage(named: "saveWater") ?? UIImage())
        } else if indexPath.row == 1 {
            cell.configure(with: UIImage(named: "plumber") ?? UIImage())
        } else if indexPath.row == 2 {
            cell.configure(with: UIImage(named: "payment") ?? UIImage())
        } else {
            cell.configure(with: UIImage(named: "calculateMoney") ?? UIImage())
        }
        
        return cell
    }
    
    
}

extension NewsView: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let width = scrollView.frame.width
        let contentOffsetX = scrollView.contentOffset.x
        
        let index = round(contentOffsetX / width)
        
        let targetOffsetX = index * width
        targetContentOffset.pointee = CGPoint(x: targetOffsetX, y: 0)
    }
}
