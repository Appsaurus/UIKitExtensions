//
//  UITableViewExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 8/10/16.
//
//

#if canImport(UIKit)
import UIKit

public extension UITableView {
    func hideSeparatorInset() {
		layoutMargins = UIEdgeInsets.zero
		separatorInset = UIEdgeInsets.zero
	}
	
    func hideEmptyCellsAtBottomOfTable() {
		guard tableFooterView == nil else { return }
        self.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func automaticallySizeCellHeights(_ heightEstimate: CGFloat) {
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = heightEstimate
    }
    
    func automaticallySizeSectionHeaderHeights(_ heightEstimate: CGFloat) {
        sectionHeaderHeight = UITableView.automaticDimension
        estimatedSectionHeaderHeight = heightEstimate
    }
    
    func automaticallySizeSectionFooterHeights(_ heightEstimate: CGFloat) {
        sectionFooterHeight = UITableView.automaticDimension
        estimatedSectionFooterHeight = heightEstimate
    }
    
    //Conveniece for single section tableview
    func dequeueReusableCell<Cell: UITableViewCell>(for index: Int) -> Cell {
        return dequeueReusableCell(IndexPath(item: index, section: 0))
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(_ indexPath: IndexPath, with identifier: String? = nil) -> Cell {
        let identifier = identifier ?? Cell.defaultReuseIdentifier
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("The requested cell type \(Cell.className) was not registered for this table view with reuse identifier \(identifier) .")
        }
        return cell
    }
    
    func register<CellType: UITableViewCell>(_ cellType: CellType.Type, with identifier: String?) {
        register(cellType, forCellReuseIdentifier: identifier ?? CellType.defaultReuseIdentifier)
    }
    
    func register<CellType: UITableViewCell>(_ cellTypes: CellType.Type...) {
        for type in cellTypes {
            register(type, with: nil)
        }
    }
    
    func append(rowCount: Int, to section: Int? = nil) {
        guard let dataSource = dataSource else { return }
        var indexPaths: [IndexPath] = []
        let targetSection: Int = section ?? (dataSource.numberOfSections!(in: self) - 1)
        let firstNewRow = dataSource.tableView(self, numberOfRowsInSection: targetSection) - rowCount
        let lastNewRow = firstNewRow + rowCount - 1
        
        for index in firstNewRow...lastNewRow {
            indexPaths.append(IndexPath(row: index, section: targetSection))
        }
        append(indexPaths: indexPaths)
    }
    func append(indexPaths: [IndexPath], with animation: UITableView.RowAnimation = .fade) {
        beginUpdates()
        insertRows(at: indexPaths, with: animation)
        endUpdates()
    }
}


public extension UITableView {
	func reloadData(completion: @escaping () -> Void) {
		UIView.animate(withDuration: 0, animations: {
			DispatchQueue.main.async {
				self.reloadData()
			}
        }, completion: { _ in
			DispatchQueue.main.async {
				completion()
			}
		})
	}
}
#endif
