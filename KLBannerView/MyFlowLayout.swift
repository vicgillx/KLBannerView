

import UIKit

class MyFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        guard let c = collectionView else {
            return
        }
        c.decelerationRate = UIScrollView.DecelerationRate.normal
        let offset = (c.bounds.width-itemSize.width)/2
        c.contentInset = UIEdgeInsets.init(top: 0, left:offset, bottom: 0, right: offset)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let array = super.layoutAttributesForElementsInRect(rect)
//          // 可见矩阵
//          let visiableRect = CGRectMake(self.collectionView!.contentOffset.x, self.collectionView!.contentOffset.y, self.collectionView!.frame.width, self.collectionView!.frame.height)
//          for attributes in array! {
//              // 不在可见区域的attributes不变化
//              if !CGRectIntersectsRect(visiableRect, attributes.frame) {continue}
//              let frame = attributes.frame
//              let distance = abs(collectionView!.contentOffset.x + collectionView!.contentInset.left - frame.origin.x)
//              let scale = min(max(1 - distance/(collectionView!.bounds.width), 0.85), 1)
//              attributes.transform = CGAffineTransformMakeScale(scale, scale)
//          }
//          return array
        let rects = super.layoutAttributesForElements(in: rect)!
        let visableRect = CGRect.init(x: collectionView!.contentOffset.x, y: collectionView!.contentOffset.y, width: collectionView!.bounds.width, height: collectionView!.bounds.height)
        for rect in rects {
            if !visableRect.intersects(rect.frame){
                continue
            }else{
                let frame = rect.frame
                let distance = abs(collectionView!.contentOffset.x + collectionView!.contentInset.left - frame.minX)
                let scale = min(max(1 - distance/(collectionView!.bounds.width), 0.85), 1)
                rect.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        return rects
    }
    
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//        let lastRect = CGRect.init(x: proposedContentOffset.x, y: proposedContentOffset.y, width: self.collectionView!.frame.width, height: self.collectionView!.frame.height)
//            //获得collectionVIew中央的X值(即显示在屏幕中央的X)
//            let centerX = proposedContentOffset.x + self.collectionView!.frame.width * 0.5;
//            //这个范围内所有的属性
//        let array = self.layoutAttributesForElements(in: lastRect)
//            //需要移动的距离
//            var adjustOffsetX = CGFloat(MAXFLOAT);
//            for attri in array! {
//                if abs(attri.center.x - centerX) < abs(adjustOffsetX) {
//                    adjustOffsetX = attri.center.x - centerX;
//                }
//            }
//        return CGPoint.init(x: (proposedContentOffset.x + adjustOffsetX), y: proposedContentOffset.y)
//        }
}
