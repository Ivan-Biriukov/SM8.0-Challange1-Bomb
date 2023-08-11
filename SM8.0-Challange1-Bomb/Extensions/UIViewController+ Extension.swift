import UIKit

extension UIViewController {
    
    func createCustomNavigationBar(title: String) {
        
        let navigationBar = navigationController?.navigationBar
        navigationBar?.tintColor = .black
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .clear
        navigationBarAppearance.shadowColor = .clear
      
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.topItem?.title = " "
        
        self.navigationItem.title = nil
        
        let navTitle : UILabel = {
            let lb = UILabel()
            lb.font = .delaGothic30()
            lb.textColor = .specialViolet
            lb.textAlignment = .center
            lb.backgroundColor = .clear
            lb.text = title
            return lb
        }()
        
        self.navigationItem.titleView = navTitle
    }
    
    func addButtonToNavBar(_ button: UIButton?) {
        if let safeButton = button {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: safeButton)
        } else {
            let customView : UIButton = {
                let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                btn.setImage(UIImage(systemName: "pause.circle"), for: .normal)
                btn.tintColor = .black
                btn.setTitle(nil, for: .normal)
                btn.contentVerticalAlignment = .fill
                btn.contentHorizontalAlignment = .fill
                return btn
            }()
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: customView)
        }     
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
            UserDefaults.standard.set(10, forKey: K.UserDefaultsKeys.roundTimeDurationInSeconds)
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
