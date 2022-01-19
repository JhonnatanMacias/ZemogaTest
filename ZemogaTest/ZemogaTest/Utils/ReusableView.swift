//
//  ReusableView.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 18/01/22.
//

import Foundation
import UIKit

public protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView: ReusableView {

}

extension UITableViewCell: ReusableView {

}

extension UICollectionReusableView: ReusableView {

}
