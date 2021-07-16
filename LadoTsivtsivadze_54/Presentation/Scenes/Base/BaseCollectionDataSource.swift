//
//  BaseCollectionDataSource.swift
//  LadoTsivtsivadze_54
//
//  Created by lado tsivtsivadze on 7/16/21.
//

import UIKit


class BaseCollectionDataSource: NSObject {
    
    internal var singleSectionModels: [CellItem]!
    internal var multiSectionModels: [[CellItem]]!
    
    internal weak var collectionView: UICollectionView? {
        didSet {
            collectionView?.dataSource = self
            collectionView?.delegate = self
        }
    }
    
    func refresh(with products: [ProductModel]) {
        
    }
    
    func initCustomCell(for indexPath: IndexPath, with cellIdentifier: String) -> UICollectionViewCell? {
        return nil
    }
}

extension BaseCollectionDataSource: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if singleSectionModels != nil {
            return 1
        } else if multiSectionModels != nil {
            return multiSectionModels.count
        } else {
            fatalError("No models set up!")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items(for: section).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = items(for: indexPath.section)[indexPath.row]
        let cell: UICollectionViewCell
        
        switch cellViewModel.cellIdentifier {
        case GridCell.identifier:
            cell = collectionView.deque(GridCell.self, for: indexPath)
        default:
            if let _cell = initCustomCell(for: indexPath, with: cellViewModel.cellIdentifier) {
                cell = _cell
            } else {
                fatalError()
            }
        }
        
        if let configurableCell = cell as? CellConfigurableCollection {
            configurableCell.configure(with: cellViewModel)
        }
        
        return cell
    }
//    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 60) / 2
        return CGSize(width: width, height: width)
    }
    
    func items(for section: Int) -> [CellItem] {
        if singleSectionModels != nil {
            return singleSectionModels
        } else if multiSectionModels != nil {
            return multiSectionModels[section]
        } else {
            fatalError("No models set up!")
        }
    }
}
