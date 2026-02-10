//
//  Screen.swift
//  DeclareKit
//
//  Created by Benjamín Guzmán López on 08-02-26.
//

import UIKit

public protocol Screen: RepresentableController {
    associatedtype Body: RepresentableController
    @ControllerBuilder var body: Body { get }
}

extension Screen {
    public func buildController() -> UIViewController {
        body.buildController()
    }

    public func buildControllerList() -> [UIViewController] {
        body.buildControllerList()
    }
}
