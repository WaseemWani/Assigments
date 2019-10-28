//
//  ReusbaleProtocols.swift
//  LumiApp
//
//  Created by Amit Kumar on 04/09/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import Foundation
import UIKit

/// Genric Protocol for nib and identifier
protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
    static var nib: UINib? { return UINib(nibName: reuseIdentifier, bundle: nil) }
}
