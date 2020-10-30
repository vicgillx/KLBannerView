
import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    let  list : [String] = {
        var list = [String].init()
        for i in 0..<20{
            list.append("\(i)")
        }
        return list
    }()
    
    let screenWidth = UIScreen.main.bounds.width
    
    let cellIntervel:CGFloat = 10
    
    lazy var  cellHeight:CGFloat = view.bounds.height - 100
    
    lazy var cellWidth:CGFloat = {
        return screenWidth
    }()
    
    lazy var collection:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let c = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        c.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        c.decelerationRate = .fast
        c.dataSource = self
        //c.isPagingEnabled = true
        c.delegate = self
        return c
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collection)
        collection.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.label.text = list[indexPath.row]
        cell.backgroundColor = .red
        return cell
    }
}

extension ViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellIntervel
    }
}

//可用
extension ViewController:UIScrollViewDelegate{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        var indexes = self.collection.indexPathsForVisibleItems
        indexes.sort()
        var index = indexes.first!
        let cell = self.collection.cellForItem(at: index)!
        let position = self.collection.contentOffset.x - cell.frame.origin.x
        if position > cell.frame.size.width/2{
           index.row = index.row+1
        }
        self.collection.scrollToItem(at: index, at: .left, animated: true )
    }
}
