import UIKit
import Observation


@Observable
class ExampleViewController: UIViewController {
    var count = 0
    
    func track(_ apply: @escaping () -> Void) {
        withObservationTracking(apply, onChange: { self.track(apply) })
    }
    
    override func viewDidLoad() {
//        let button = UIButton(type: .contactAdd)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        track {
//            button.setTitle("Add to \(self.count)", for: .normal)
//            button.addTarget(self, action: #selector(self.onTap), for: .touchUpInside)
//        }
        
//        let button = Button("Increase Count") {
//            self.count += 1
//        }.build()
        
        let uiAction = UIAction(
            title: "Increase Count",
            subtitle: "This will increase the count",
        ) { action in
            print("Chuta!!")
            self.count += 1
        }
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.isEnabled = false
//        button.setTitle("Hello World", for: .normal)
//        button.setTitle("Disabled", for: .disabled)
        button.setTitleColor(.black, for: .normal)
        
        print("Button: \(button)")
        
        view.addSubview(button)
        
        let label = Text("Chuta").build()
        track {
            label.text = "Count: \(self.count)"
        }
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    @objc private func onTap() {
        count += 1
    }
}

#Preview {
    ExampleViewController()
}
