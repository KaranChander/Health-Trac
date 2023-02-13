//
//  UITableViewExtension.swift
//   Health Track
//



import Foundation
import UIKit

// MARK: - Table View Extension
extension UITableView {

    ///Returns cell for the given item
    func cell(forItem item: Any) -> UITableViewCell? {
        if let indexPath = self.indexPath(forItem: item) {
            return self.cellForRow(at: indexPath)
        }
        return nil
    }

    ///Returns the indexpath for the given item
    func indexPath(forItem item: Any) -> IndexPath? {
        let itemPosition: CGPoint = (item as AnyObject).convert(CGPoint.zero, to: self)
        return self.indexPathForRow(at: itemPosition)
    }

    ///Registers the given cell
    func registerClass(cellType: UITableViewCell.Type) {
        register(cellType, forCellReuseIdentifier: cellType.defaultReuseIdentifier)
    }

    ///dequeues a reusable cell for the given indexpath
    func dequeueReusableCellForIndexPath<T: UITableViewCell>(indexPath: NSIndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError( "Failed to dequeue a cell with identifier \(T.defaultReuseIdentifier). Ensure you have registered the cell." )
        }

        return cell
    }

    func indexPathForCells(inSection: Int, exceptRows: [Int] = []) -> [IndexPath] {
        let rows = self.numberOfRows(inSection: inSection)
        var indices: [IndexPath] = []
        for row in 0..<rows {
            if exceptRows.contains(row) { continue }
            indices.append([inSection, row])
        }

        return indices
    }
    
    func scrollToLastCell(animated: Bool) {
           let lastSectionIndex = self.numberOfSections - 1 // last section
           let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 2 // last row
        self.scrollToRow(at: IndexPath(row: lastRowIndex, section: lastSectionIndex), at: .bottom, animated: animated)
       }
    
    func scrollToBottom() {
           let lastSectionIndex = self.numberOfSections - 1 // last section
           let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1 // last row
        self.scrollToRow(at: IndexPath(row: lastRowIndex, section: lastSectionIndex), at: .middle, animated: false)
    }

    ///Register Table View Cell Nib
    func registerCell(with identifier: UITableViewCell.Type) {
        self.register(UINib(nibName: "\(identifier.self)", bundle: nil),
                      forCellReuseIdentifier: "\(identifier.self)")
    }

    ///Register Header Footer View Nib
    func registerHeaderFooter(with identifier: UITableViewHeaderFooterView.Type) {
        self.register(UINib(nibName: "\(identifier.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: "\(identifier.self)")
    }

    ///Dequeue Table View Cell
    func dequeueCell <T: UITableViewCell> (with identifier: T.Type, indexPath: IndexPath? = nil) -> T {
        if let index = indexPath {
            return self.dequeueReusableCell(withIdentifier: "\(identifier.self)", for: index) as! T
        } else {
            return self.dequeueReusableCell(withIdentifier: "\(identifier.self)") as! T
        }
    }

    ///Dequeue Header Footer View
    func dequeueHeaderFooter <T: UITableViewHeaderFooterView> (with identifier: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: "\(identifier.self)") as! T
    }
}

extension UITableViewCell {
    public static var defaultReuseIdentifier: String {
        return "\(self)"
    }
}

extension UITableView {

    public func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion:{ _ in
            completion()
        })
    }

    func scroll(to: scrollsTo, animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            switch to{
            case .top:
                if numberOfRows > 0 {
                     let indexPath = IndexPath(row: 0, section: 0)
                     self.scrollToRow(at: indexPath, at: .top, animated: animated)
                }
                break
            case .bottom:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                    self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
                break
            }
        }
    }

    enum scrollsTo {
        case top,bottom
    }
}

