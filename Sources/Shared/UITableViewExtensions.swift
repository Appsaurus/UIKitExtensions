//
//  UITableViewExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 8/10/16.
//
//

import UIKit

public extension UITableView{
	public func hideSeparatorInset(){
		layoutMargins = UIEdgeInsets.zero
		separatorInset = UIEdgeInsets.zero
	}
	
    public func hideEmptyCellsAtBottomOfTable(){
		guard tableFooterView == nil else { return }
        self.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    public func automaticallySizeCellHeights(_ heightEstimate: CGFloat){
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = heightEstimate
    }
    
    public func automaticallySizeSectionHeaderHeights(_ heightEstimate: CGFloat){
        sectionHeaderHeight = UITableView.automaticDimension
        estimatedSectionHeaderHeight = heightEstimate
    }
    
    public func automaticallySizeSectionFooterHeights(_ heightEstimate: CGFloat){
        sectionFooterHeight = UITableView.automaticDimension
        estimatedSectionFooterHeight = heightEstimate
    }
    
    //Conveniece for single section tableview
    public func dequeueReusableCell<Cell: UITableViewCell>(for index: Int) -> Cell{
        return dequeueReusableCell(IndexPath(item: index, section: 0))
    }
    
    public func dequeueReusableCell<Cell: UITableViewCell>(_ indexPath: IndexPath, with identifier: String? = nil) -> Cell {
        let identifier = identifier ?? Cell.defaultReuseIdentifier
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("The requested cell type \(Cell.className) was not registered for this table view with reuse identifier \(identifier) .")
        }
        return cell
    }
    
    public func register<CellType: UITableViewCell>(_ cellType: CellType.Type, with identifier: String?){
        register(cellType, forCellReuseIdentifier: identifier ?? CellType.defaultReuseIdentifier)
    }
    
    public func register<CellType: UITableViewCell>(_ cellTypes: CellType.Type...){
        for type in cellTypes {
            register(type, with: nil)
        }
    }
    
    public func append(rowCount: Int, to section: Int? = nil){
        guard let dataSource = dataSource else{ return }
        var indexPaths: [IndexPath] = []
        let targetSection: Int = section ?? (dataSource.numberOfSections!(in: self) - 1)
        let firstNewRow = dataSource.tableView(self, numberOfRowsInSection: targetSection) - rowCount
        let lastNewRow = firstNewRow + rowCount - 1
        
        for index in firstNewRow...lastNewRow{
            indexPaths.append(IndexPath(row: index, section: targetSection))
        }
        append(indexPaths: indexPaths)
    }
    public func append(indexPaths: [IndexPath], with animation: UITableView.RowAnimation = .fade){
        beginUpdates()
        insertRows(at: indexPaths, with: animation)
        for index in indexPaths{
                print("inserting rows at" + index.section.toString + index.row.toString)
        }
        endUpdates()
    }
}

////Dynamic Height TableView Header //TODO: Fix bug where height breaks after rotation
//extension UITableView {
//    public func layoutDynamicHeightHeaderView(width: CGFloat) {
//        guard let headerView = tableHeaderView else { return }
//        headerView.translatesAutoresizingMaskIntoConstraints = false
//        let widthConstraint = headerView.autoSizeWidth(to: width)
//        headerView.addConstraint(widthConstraint)
//        headerView.forceAutolayoutPass()
//        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
//        headerView.removeConstraint(widthConstraint)
//        headerView.frame = CGRect(x: 0, y: 0, width: width, height: height)
//        headerView.translatesAutoresizingMaskIntoConstraints = true
//        self.tableHeaderView = headerView
//    }
//    
//    /// Dynamically Size TableView headers with AutoLayout
//    //  NOTE: Requires following override in UITableViewController
//    //    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//    //        super.viewWillTransition(to: size, with: coordinator)
//    //        self.tableView.layoutDynamicHeightHeaderView(width: size.width)
//    //    }
//    //
//    //    override open func viewWillAppear(_ animated: Bool) {
//    //        super.viewWillAppear(animated)
//    //        self.tableView.layoutDynamicHeightHeaderView(width: self.tableView.bounds.width)
//    //    }
//    /// - Parameters:
//    ///   - view: Base view for header
//    ///   - insets: Insets for base view
//
//    public func setupDynamicHeightTableHeaderView(fittingContentView view: UIView, insets: UIEdgeInsets = UIEdgeInsets(padding: 20)){
//        tableHeaderView = UIView.parentViewFittingContent(of: view, insetBy: insets)
//    }
//
//}

extension UITableView {
	public func reloadData(completion: @escaping ()->()) {
		UIView.animate(withDuration: 0, animations: {
			DispatchQueue.main.async {
				self.reloadData()
			}
		}){ _ in
			DispatchQueue.main.async {
				completion()
			}
		}
	}
}
