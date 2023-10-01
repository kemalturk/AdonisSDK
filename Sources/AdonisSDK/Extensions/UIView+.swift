//
//  UIView+.swift
//  AdonisDemo
//
//  Created by Kemal Türk on 30.09.2023.
//

import Foundation
import UIKit

extension UIView {
    
    func fillSuperView() {
        guard let superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
        ])
    }
    
    @discardableResult
    func height(_ size: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.heightAnchor.constraint(equalToConstant: size)
        constraint.isActive = true
        return constraint
    }
    
    func width(_ size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: size).isActive = true
    }
    
}
