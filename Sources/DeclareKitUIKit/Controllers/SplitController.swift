//
//  SplitController.swift
//  DeclareKit
//
//  Created by Benjamín Guzmán López on 10-02-26.
//

import UIKit

public struct SplitController<Primary: RepresentableController, Secondary: RepresentableController, Supplementary: RepresentableController>: RepresentableController {
 
    private let primary: Primary
    private let secondary: Secondary
    private let supplementary: Supplementary?

    /// Creates a navigation controller with a root controller from `content`.
//    public init(@ControllerBuilder _ primary: () -> Primary, @ControllerBuilder secondary: () -> Secondary) {
//        self.primary = primary()
//        self.secondary = secondary()
//    }
    
    public init(@ControllerBuilder _ primary: () -> Primary, @ControllerBuilder secondary: () -> Secondary, @ControllerBuilder supplementary: () -> Supplementary) {
        self.primary = primary()
        self.secondary = secondary()
        self.supplementary = supplementary()
    }
    
    public func buildController() -> UISplitViewController {
        let style = supplementary == nil ? UISplitViewController.Style.doubleColumn : UISplitViewController.Style.tripleColumn
        let splitViewController = UISplitViewController(style: style)
        
        splitViewController.setViewController(primary.buildController(), for: .primary)
        splitViewController.setViewController(secondary.buildController(), for: .secondary)
        
        if let supplementary {
            splitViewController.setViewController(supplementary.buildController(), for: .supplementary)
        }
        
        return splitViewController
    }
}

extension Never: RepresentableController {
    public func buildController() -> UIViewController {
        fatalError("Cannot call `build` on `Never")
    }
}

public extension SplitController where Supplementary == Never {
    init(@ControllerBuilder _ primary: () -> Primary, @ControllerBuilder secondary: () -> Secondary) {
        self.primary = primary()
        self.secondary = secondary()
        self.supplementary = nil
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
        NavigationController {
            ViewController {
                ScrollView {
                    Stack(.vertical) {
                        Label("Primary")
                            .backgroundColor(.blue)
                    }
                    .backgroundColor(.green)
                }
                .backgroundColor(.red)
            }
            .title("Primary")
        }
    } secondary: {
        NavigationController {
            ViewController {
                Label("Secondary")
                    .pin(to: .safeAreaLayoutGuide)
            }
            .title("Secondary")
            .navigationItem(searchController: .init())
        }
    } supplementary: {
        NavigationController {
            ViewController {
                Label("Supplementary")
                    .pin(to: .safeAreaLayoutGuide)
            }
            .title("Supplementary")
            .navigationItem(searchController: .init())
        }
    }
    .buildController()
}
