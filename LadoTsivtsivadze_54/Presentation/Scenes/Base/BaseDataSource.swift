//
//  BaseDataSource.swift
//  Lecture 54
//
//  Created by Nika Kirkitadze on 15.07.21.
//

import UIKit

class BaseDataSource: NSObject {
    
    internal var singleSectionModels: [CellItem]!
    internal var multiSectionModels: [[CellItem]]!
    
    internal weak var tableView: UITableView? {
        didSet {
            tableView?.dataSource = self
        }
    }
    
    func refresh(with products: [ProductModel]) {
        
    }
    
    func initCustomCell(for indexPath: IndexPath, with cellIdentifier: String) -> UITableViewCell? {
        return nil
    }
}

extension BaseDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if singleSectionModels != nil {
            return 1
        } else if multiSectionModels != nil {
            return multiSectionModels.count
        } else {
            fatalError("No models set up!")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items(for: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellViewModel = items(for: indexPath.section)[indexPath.row]
        let cell: UITableViewCell
        
        
        switch cellViewModel.cellIdentifier {
        case ItemCategoryCell.identifier:
            cell = tableView.deque(ItemCategoryCell.self, for: indexPath)
        case GridContentCell.identifier:
            cell = tableView.deque(GridContentCell.self, for: indexPath)
        case RecentlyViewedTitleCell.identifier:
            cell = tableView.deque(RecentlyViewedTitleCell.self, for: indexPath)
        case SavedItemsTitleCell.identifier:
            cell = tableView.deque(SavedItemsTitleCell.self, for: indexPath)
        case SavedItemCell.identifier:
            cell = tableView.deque(SavedItemCell.self, for: indexPath)
        default:
            if let _cell = initCustomCell(for: indexPath, with: cellViewModel.cellIdentifier) {
                cell = _cell
            } else {
                fatalError()
            }
        }
        
        if let configurableCell = cell as? CellConfigurable {
            configurableCell.configure(with: cellViewModel)
        }
        
        return cell
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

// single section model

// ["Object1", "Object2", "Object3"]

// [ ["Object1", "Object2", "Object3"], ["Object11", "Object12", "Object13"] ]

protocol CellConfigurable: UITableViewCell {
    func configure(with item: CellItem)
}

protocol CellConfigurableCollection: UICollectionViewCell {
    func configure(with item: CellItem)
}

protocol CellItem {
    var cellIdentifier: String { get }
}

struct CellViewModel: CellItem {
    
    private(set) var cellIdentifier: String
    
    let userData: [CellViewModelUserDataKey: Any]
    
    init(cellIdentifier: String,
         userData: [CellViewModelUserDataKey: Any]? = nil) {
        self.cellIdentifier = cellIdentifier
        self.userData = userData ?? [:]
    }
}

enum CellViewModelUserDataKey {
    case data
}
