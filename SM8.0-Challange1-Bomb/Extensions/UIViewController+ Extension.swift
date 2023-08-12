import UIKit.UIViewController

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
    
    func navBarForGameVC(vc: UIViewController, button: UIButton) {
        vc.navigationController!.navigationBar.topItem!.backBarButtonItem = UIBarButtonItem(customView:button)
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
            UserDefaults.standard.set("Шоу Бэнни Хила", forKey: K.UserDefaultsKeys.bgMusicSavedValue)
        }
        
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.bombTikSavedValue) == false {
            UserDefaults.standard.set("Тиканье часов", forKey: K.UserDefaultsKeys.bombTikSavedValue)
        }
        
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.bombExplosionSaveValue) == false {
            UserDefaults.standard.set("Взрыв 1", forKey: K.UserDefaultsKeys.bombExplosionSaveValue)
        }
        
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.gameInProgress) == false {
            UserDefaults.standard.set(false, forKey: K.UserDefaultsKeys.gameInProgress)
        }
        
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.aboutAllCategoryChoosen) == false {
            UserDefaults.standard.set(true, forKey: K.UserDefaultsKeys.aboutAllCategoryChoosen)
        }
        
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.sportAndHobbyCathegoryChoosen) == false {
            UserDefaults.standard.set(false, forKey: K.UserDefaultsKeys.sportAndHobbyCathegoryChoosen)
        }
        
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.lifeCategoryChoosen) == false {
            UserDefaults.standard.set(false, forKey: K.UserDefaultsKeys.lifeCategoryChoosen)
        }
        
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.fameosCategoryChoosen) == false {
            UserDefaults.standard.set(false, forKey: K.UserDefaultsKeys.fameosCategoryChoosen)
        }
        
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.artAndCinemaCategoryChoosen) == false {
            UserDefaults.standard.set(false, forKey: K.UserDefaultsKeys.artAndCinemaCategoryChoosen)
        }
        
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.natureCategoryChoosen) == false {
            UserDefaults.standard.set(false, forKey: K.UserDefaultsKeys.natureCategoryChoosen)
        }
    }
}
