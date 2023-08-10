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
        self.navigationController?.navigationBar.topItem?.title = " "
        self.title = title
    }
    
    func addButtonToNavBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pause.circle"), style:.done, target: self, action: nil)
    }
    
    // Function check if UserDefault even exist, true when exist (has value) false when doesnt exist (has no value)
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    // Methods for check if UD values = nil we will set a defaults values
    func setUDDefaultsValuesForFirstAppLaunch() {
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.backgroundMusicBool) == false {
            UserDefaults.standard.set(true, forKey: K.UserDefaultsKeys.backgroundMusicBool)
        }
        
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.gameWithTasksBool) == false {
            UserDefaults.standard.set(true, forKey: K.UserDefaultsKeys.gameWithTasksBool)
        }
        
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.roundTimeDurationInSeconds) == false {
            UserDefaults.standard.set(30, forKey: K.UserDefaultsKeys.roundTimeDurationInSeconds)
        }
        
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.bgMusicSavedValue) == false {
            UserDefaults.standard.set("mainTheme1", forKey: K.UserDefaultsKeys.bgMusicSavedValue)
        }
        
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.bombTikSavedValue) == false {
            UserDefaults.standard.set("timer1", forKey: K.UserDefaultsKeys.bombTikSavedValue)
        }
        
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.bombExplosionSaveValue) == false {
            UserDefaults.standard.set("explosion1", forKey: K.UserDefaultsKeys.bombExplosionSaveValue)
        }
    }
}
