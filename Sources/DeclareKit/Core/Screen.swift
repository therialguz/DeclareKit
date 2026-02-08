//
//  Screen.swift
//  DeclareKit
//
//  Created by Benjamín Guzmán López on 08-02-26.
//

import UIKit

protocol Screen: RepresentableController {
    associatedtype Body: RepresentableController
    @ControllerBuilder var body: Body { get }
}
                                                                                                                        
extension Screen {
    func buildController() -> UIViewController {
        body.buildController()
    }
    
    func buildControllerList() -> [UIViewController] {
        body.buildControllerList()
    }
}
