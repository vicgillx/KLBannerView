

import UIKit
import SnapKit
class MyCollectionViewCell: UICollectionViewCell {
    let label:UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 26)
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
