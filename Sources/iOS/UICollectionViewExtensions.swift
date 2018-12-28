//
//  UICollectionViewExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 5/5/17.
//
//

#if canImport(UIKit)
import UIKit

extension UICollectionView {

    public func registerReusable(cellClass: UICollectionViewCell.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.defaultIdentifier)
    }
    
    public func dequeueReusableCell<C: UICollectionViewCell>(for indexPath: IndexPath) -> C {
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withReuseIdentifier: C.self.defaultIdentifier, for: indexPath) as! C
    }

    public func dequeueReusableCell<C: UICollectionViewCell>(for index: Int) -> C {
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withReuseIdentifier: C.self.defaultIdentifier, for: IndexPath(item: index, section: 0)) as! C
    }
}

extension UICollectionViewCell {
    public static var defaultIdentifier: String {
        return className + "Identifier"
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
