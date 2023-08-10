import Foundation
import UIKit.UIScreen

struct K {
    
    struct Images {
        
        static let background : String = "background"
        
        static let logoImage : String = "bomb"
        
        static let diference : String = "image 1"
        
        static let sportAndHobby : String = "image 2"
        
        static let aboutLife : String = "image 10"
        
        static let fameos : String = "image 4"
        
        static let artAndCinema : String = "image 5"
        
        static let nature : String = "image 6"
        
        static let bomb : String = "image 7"
        
        static let explosion : String = "image 9"
        
        static let settingsLogo : String = "image 11"
        
        static let question : String = "question"
    }
    
    struct DeviceSizes {
        static let currentHeight = UIScreen.main.bounds.height
        static let currentWidth = UIScreen.main.bounds.width
    }
    
    struct UserDefaultsKeys {
        static let roundTimeDurationInSeconds : String = "RoundDuration"
        static let gameWithTasksBool : String = "TasksInclude"
        static let backgroundMusicBool : String = "BGMusicEnabled"
        static let bgMusicSavedValue : String = "BGSongName"
        static let bombTikSavedValue : String = "TikSoundName"
        static let bombExplosionSaveValue : String = "ExplosionSoundName"
    }
    
}
