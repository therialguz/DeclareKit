//
//  Screen.swift
//  DeclareKit
//
//  Created by Benjamín Guzmán López on 08-02-26.
//

import UIKit

/// A reusable declarative controller component.
///
/// `Screen` mirrors `Component` for controller composition. Implement `body`
/// and DeclareKit will forward controller construction automatically.
public protocol Screen: RepresentableController {
    /// The composed controller content for this screen.
    associatedtype Body: RepresentableController

    /// The declarative controller tree for this screen.
    @ControllerBuilder var body: Body { get }
}

extension Screen {
    /// Builds this screen by building its `body`.
    public func buildController() -> UIViewController {
        body.buildController()
    }

    /// Builds this screen as a flattened list of controllers.
    public func buildControllerList() -> [UIViewController] {
        body.buildControllerList()
    }
}
