import UIKit

/// Internal type representing multiple controllers composed together.
///
/// This type is created by `@ControllerBuilder` when multiple controllers are declared
/// in a single block. It mirrors `_TupleNode` but for controllers.
@MainActor
struct _TupleController<Content>: RepresentableController {
    let content: Content
    
    init(_ content: Content) {
        self.content = content
    }
    
    func buildController(in context: BuildContext) -> UIViewController {
        // Return the first controller from the list
        buildControllerList(in: context).first ?? UIViewController()
    }
    
    func buildControllerList(in context: BuildContext) -> [UIViewController] {
        // Use variadic generics to flatten the tuple into an array of controllers
        _buildControllerList(from: content, in: context)
    }
    
    private func _buildControllerList(from value: Content, in context: BuildContext) -> [UIViewController] {
        var controllers: [UIViewController] = []
        
        func buildItem<C: RepresentableController>(_ item: C) {
            controllers.append(contentsOf: item.buildControllerList(in: context))
        }
        
        // Use a mirror to iterate over the tuple elements
        let mirror = Mirror(reflecting: value)
        for child in mirror.children {
            if let controller = child.value as? any RepresentableController {
                buildItem(controller)
            }
        }
        
        return controllers
    }
}
