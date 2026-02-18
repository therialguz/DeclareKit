//
//  Controller.swift
//  DeclareKit
//
//  Created by Benjamín Guzmán López on 08-02-26.
//

import UIKit

public protocol Controller: RepresentableController {
    /// The composed controller content for this screen.
    associatedtype Body: RepresentableController

    /// The declarative controller tree for this screen.
    @ControllerBuilder var body: Body { get }
}

extension Controller {
    /// Builds this screen by building its `body`.
    public func buildController() -> UIViewController {
        body.buildController()
    }

    /// Builds this screen as a flattened list of controllers.
    public func buildControllerList() -> [UIViewController] {
        body.buildControllerList()
    }
}
