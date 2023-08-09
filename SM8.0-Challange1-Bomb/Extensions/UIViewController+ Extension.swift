import UIKit

extension UIViewController {
    
    func createCustomNavigationBar(title: String) {
        
        let navigationBar = navigationController?.navigationBar
        navigationBar?.tintColor = .black
        let navigationBarAppearance = UINavigationBarAppearance()
        
        
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .clear
        navigationBarAppearance.shadowColor = .clear
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.specialViolet, NSAttributedString.Key.font: UIFont.delaGothic20() ?? UIFont.systemFont(ofSize: 20)
        ]
        
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                title: "", style: .plain, target: nil, action: nil)
        self.title = title
    }
    
    func addButtonToNavBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pause.circle"), style:.done, target: self, action: nil)
        
    }
    
}
