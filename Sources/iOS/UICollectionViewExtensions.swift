//
//  UICollectionViewExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 5/5/17.
//
//

#if canImport(UIKit)
import UIKit

public extension UICollectionView {

    func register<Cell: UICollectionViewCell>(_ cellType: Cell.Type, with identifier: String? = nil) {
        register(cellType, forCellWithReuseIdentifier: identifier ?? cellType.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(_ indexPath: IndexPath, with identifier: String? = nil) -> Cell {
        let identifier = identifier ?? Cell.defaultReuseIdentifier
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! Cell
    }

    func dequeueReusableCell<Cell: UICollectionViewCell>(for index: Int) -> Cell {
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withReuseIdentifier: Cell.self.defaultReuseIdentifier, for: IndexPath(item: index, section: 0)) as! Cell
    }
}

public extension UICollectionView {
    func registerSectionHeader(_ viewType: UICollectionReusableView.Type, with identifier: String? = nil) {
        self.register(viewType, with: identifier, for: UICollectionView.elementKindSectionHeader)
    }

    func registerSectionFooter(_ viewType: UICollectionReusableView.Type, with identifier: String? = nil) {
        self.register(viewType, with: identifier, for: UICollectionView.elementKindSectionFooter)
    }
    func register(_ viewType: UICollectionReusableView.Type, with identifier: String? = nil, for supplementaryViewKind: String) {
        let identifier = identifier ?? viewType.defaultReuseIdentifier
        register(viewType.self, forSupplementaryViewOfKind: supplementaryViewKind, withReuseIdentifier: identifier)
    }

    func dequeueReusableView<View: UICollectionReusableView>(of kind: String, at indexPath: IndexPath) -> View {
        // swiftlint:disable:next force_cast
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: View.defaultReuseIdentifier, for: indexPath) as! View
    }
}

extension UICollectionView {

    public var contentCenter: CGPoint {
        return CGPoint(x: self.center.x + self.contentOffset.x, y: self.center.y + self.contentOffset.y)
    }

    public var centerCellIndexPath: IndexPath? {

        if let centerIndexPath = self.indexPathForItem(at: self.contentCenter) {
            return centerIndexPath
        }
        return nil
    }

    public func centerScrollViewContentOnCurrentCell() {
        guard let centerCellIndexPath = centerCellIndexPath else { return }
        scrollToItem(at: centerCellIndexPath, at: .centeredHorizontally, animated: false)
    }

    public func centerScrollViewContentOnFirstVisibleCell() {
        guard let firstCellIndexPath = indexPathsForVisibleItems.first else { return }
        scrollToItem(at: firstCellIndexPath, at: .centeredHorizontally, animated: false)
    }

    public func reloadData(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            self.reloadData()
            self.performBatchUpdates(nil, completion: { (_) in
                DispatchQueue.main.async {
                    completion()
                }
            })
        }
    }

    public func deselectAll(animated: Bool = true) {
        indexPathsForSelectedItems?.forEach({ (index) in
            deselectItem(at: index, animated: animated)
        })
    }
}
#endif
