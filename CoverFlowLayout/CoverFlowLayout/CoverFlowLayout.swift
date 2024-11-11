//
//  CoverFlowLayout.swift
//  SwiftScrollBanner
//
//  Created by xcode on 2024/11/8.
//

import UIKit

class CustomLayoutAttributes: UICollectionViewLayoutAttributes {
    var scale: CGFloat = 1.0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! CustomLayoutAttributes
        copy.scale = scale
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? CustomLayoutAttributes else { return false }
        return super.isEqual(object) && other.scale == scale
    }
}



class CoverFlowLayout: UICollectionViewFlowLayout {

    //最小缩小比例
    @IBInspectable open var sideItemScale: CGFloat = 0.7

    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        let inset = (collectionView.bounds.width - itemSize.width) / 2
        self.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    override class var layoutAttributesClass: AnyClass {
          return CustomLayoutAttributes.self
      }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 1.获取该范围内的布局数组
        let attributes = super.layoutAttributesForElements(in: rect) as? [CustomLayoutAttributes]
        // 2.计算出整体中心点的 x 坐标
        let centerX = collectionView!.contentOffset.x + collectionView!.bounds.width / 2
        
        // 3.根据当前的滚动，对每个 cell 进行相应的缩放
        attributes?.forEach({ (attr) in
            // 获取每个 cell 的中心点，并计算这俩个中心点的偏移值
            let space = abs(centerX - attr.center.x)
            let maxDistance = self.itemSize.width + self.minimumLineSpacing
            let distance = min(space, maxDistance)
            let ratio = (maxDistance - distance)/maxDistance
            let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
            attr.scale = scale

            //attr.transform = CGAffineTransform(scaleX: scale, y:scale)
        })
        // 4.返回修改后的 attributes 数组
        return attributes
    }
        
    // 滚动时停下的偏移量
    // - Parameters:
    //   - proposedContentOffset: 将要停止的点
    //   - velocity: 滚动速度
    // - Returns: 滚动停止的点
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var targetPoint = proposedContentOffset
        // 1.计算中心点的 x 值
        let centerX = proposedContentOffset.x + collectionView!.bounds.width / 2
        // 2.获取这个点可视范围内的布局属性
        let attrs = self.layoutAttributesForElements(in: CGRect(x: proposedContentOffset.x, y: proposedContentOffset.y, width: collectionView!.bounds.size.width, height: collectionView!.bounds.size.height))
        
        // 3. 需要移动的最小距离
        var moveDistance: CGFloat = CGFloat(MAXFLOAT)
        // 4.遍历数组找出最小距离
        attrs!.forEach { (attr) in
            if abs(attr.center.x - centerX) < abs(moveDistance) {
                moveDistance = attr.center.x - centerX
            }
        }
        // 5.返回一个新的偏移点
        if targetPoint.x > 0 && targetPoint.x < collectionViewContentSize.width - collectionView!.bounds.width {
            targetPoint.x += moveDistance
        }
        
        return targetPoint
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}



class CoverCellFlowLayout: UICollectionViewFlowLayout {

    //最小缩小比例
    @IBInspectable open var sideItemScale: CGFloat = 0.7

    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        let inset = (collectionView.bounds.width - itemSize.width) / 2
        self.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 1.获取该范围内的布局数组
        let attributes = super.layoutAttributesForElements(in: rect)
        // 2.计算出整体中心点的 x 坐标
        let centerX = collectionView!.contentOffset.x + collectionView!.bounds.width / 2
        
        // 3.根据当前的滚动，对每个 cell 进行相应的缩放
        attributes?.forEach({ (attr) in
            // 获取每个 cell 的中心点，并计算这俩个中心点的偏移值
            let space = abs(centerX - attr.center.x)
            let maxDistance = self.itemSize.width + self.minimumLineSpacing
            let distance = min(space, maxDistance)
            let ratio = (maxDistance - distance)/maxDistance
            let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
            attr.transform = CGAffineTransform(scaleX: scale, y:scale)
        })
        // 4.返回修改后的 attributes 数组
        return attributes
    }
        
    // 滚动时停下的偏移量
    // - Parameters:
    //   - proposedContentOffset: 将要停止的点
    //   - velocity: 滚动速度
    // - Returns: 滚动停止的点
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var targetPoint = proposedContentOffset
        // 1.计算中心点的 x 值
        let centerX = proposedContentOffset.x + collectionView!.bounds.width / 2
        // 2.获取这个点可视范围内的布局属性
        let attrs = self.layoutAttributesForElements(in: CGRect(x: proposedContentOffset.x, y: proposedContentOffset.y, width: collectionView!.bounds.size.width, height: collectionView!.bounds.size.height))
        
        // 3. 需要移动的最小距离
        var moveDistance: CGFloat = CGFloat(MAXFLOAT)
        // 4.遍历数组找出最小距离
        attrs!.forEach { (attr) in
            if abs(attr.center.x - centerX) < abs(moveDistance) {
                moveDistance = attr.center.x - centerX
            }
        }
        // 5.返回一个新的偏移点
        if targetPoint.x > 0 && targetPoint.x < collectionViewContentSize.width - collectionView!.bounds.width {
            targetPoint.x += moveDistance
        }
        
        return targetPoint
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
