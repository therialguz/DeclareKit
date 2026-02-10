//
//  SplitController.swift
//  DeclareKit
//
//  Created by Benjamín Guzmán López on 10-02-26.
//

import UIKit

public struct SplitController<Content: RepresentableController>: RepresentableController {
 
    private let content: Content

    /// Creates a navigation controller with a root controller from `content`.
    public init(@ControllerBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    public func buildController() -> UISplitViewController {
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = content.buildControllerList()
        return splitViewController
    }
}

extension RepresentableController where Representable == UISplitViewController {
    public func minimumPrimaryColumnWidth(_ minimumPrimaryColumnWidth: @autoclosure @escaping () -> CGFloat) -> ModifiedController<Self> {
        ModifiedController(content: self) { $0.minimumPrimaryColumnWidth = minimumPrimaryColumnWidth() }
    }
    
    public func maximumPrimaryColumnWidth(_ maximumPrimaryColumnWidth: @autoclosure @escaping () -> CGFloat) -> ModifiedController<Self> {
        ModifiedController(content: self) { $0.maximumPrimaryColumnWidth = maximumPrimaryColumnWidth() }
    }
    
    public func minimumSecondaryColumnWidth(_ minimumSecondaryColumnWidth: @autoclosure @escaping () -> CGFloat) -> ModifiedController<Self> {
        ModifiedController(content: self) { $0.minimumSecondaryColumnWidth = minimumSecondaryColumnWidth() }
    }
    
    public func minimumInspectorColumnWidth(_ minimumInspectorColumnWidth: @autoclosure @escaping () -> CGFloat) -> ModifiedController<Self> {
        ModifiedController(content: self) { $0.minimumInspectorColumnWidth = minimumInspectorColumnWidth() }
    }
    
    public func maximumInspectorColumnWidth(_ maximumInspectorColumnWidth: @autoclosure @escaping () -> CGFloat) -> ModifiedController<Self> {
        ModifiedController(content: self) { $0.maximumInspectorColumnWidth = maximumInspectorColumnWidth() }
    }
    
    public func minimumSupplementaryColumnWidth(_ minimumSupplementaryColumnWidth: @autoclosure @escaping () -> CGFloat) -> ModifiedController<Self> {
        ModifiedController(content: self) { $0.minimumSupplementaryColumnWidth = minimumSupplementaryColumnWidth() }
    }
    
    public func maximumSupplementaryColumnWidth(_ maximumSupplementaryColumnWidth: @autoclosure @escaping () -> CGFloat) -> ModifiedController<Self> {
        ModifiedController(content: self) { $0.maximumSupplementaryColumnWidth = maximumSupplementaryColumnWidth() }
    }
}

#Preview {
    SplitController {
        ViewController {
            Label("Primary")
        }
        
        ViewController {
            Label("Secondary")
        }
        
        ViewController {
            Label("Content")
        }
        
        ViewController {
            Label("Content")
        }
    }
    .minimumPrimaryColumnWidth(10)
    .buildController()
}
