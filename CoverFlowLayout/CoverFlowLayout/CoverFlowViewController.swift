//
//  CoverFlowViewController.swift
//  SwiftScrollBanner
//
//  Created by xcode on 2024/11/8.
//

import UIKit

class CoverFlowViewController: UIViewController {

    private let cellID = "baseCellID"
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setUpView() {
        // 初始化 flowlayout
        self.view.backgroundColor = .white
        
        let layout = CoverFlowLayout()
        let margin: CGFloat = 10
        let collH: CGFloat = 91
        layout.itemSize = CGSize(width: 74, height: collH)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        layout.scrollDirection = .horizontal
        
        // 初始化 collectionview
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 180, width: view.bounds.width, height: collH), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.decelerationRate = .fast  // 增强居中的效果

        // 注册 Cell
        collectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        view.addSubview(collectionView)
    }
}

extension CoverFlowViewController: UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }
}

extension CoverFlowViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! BaseCollectionViewCell
        cell.cellIndex = indexPath.item
        cell.contentContainer.backgroundColor = indexPath.item % 2 == 0 ? .purple : .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! BaseCollectionViewCell
        print("点击第\(indexPath.item + 1)张图片")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pointInView = view.convert(collectionView.center, to: collectionView)
        let indexPathNow = collectionView.indexPathForItem(at: pointInView)
        let index = (indexPathNow?.row ?? 0) % 15
        let curIndexStr = String(format: "滚动至第%d张", index + 1)
        print(curIndexStr)
    }
    
}

