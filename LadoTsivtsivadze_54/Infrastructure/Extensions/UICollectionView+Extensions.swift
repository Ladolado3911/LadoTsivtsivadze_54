

import UIKit

extension UICollectionView {
    func registerNib<T: UICollectionViewCell>(class: T.Type) {
        self.register(T.nib(), forCellWithReuseIdentifier: T.identifier)
    }
    
    func registerClass<T: UICollectionViewCell>(class: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    func deque<T: UICollectionViewCell>(_ classType: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
    
    func prepareCollectionViewLayout() {

        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.allowsMultipleSelection = true

        let screenWidth = UIScreen.main.bounds.width

        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize(width: screenWidth, height: 0)
        layout.minimumInteritemSpacing = PillCellSpacing.defaultValue.rawValue
        layout.minimumLineSpacing = PillCellSpacing.defaultValue.rawValue
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
    
    private enum PillCellSpacing: CGFloat {
        case defaultValue = 10.0
    }
}
