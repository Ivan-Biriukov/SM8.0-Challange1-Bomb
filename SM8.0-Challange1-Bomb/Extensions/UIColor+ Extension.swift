import UIKit.UIColor

extension UIColor {
    
    static let specialViolet = UIColor(red: 0.51, green: 0.19, blue: 0.65, alpha: 1)
    
    static let specialYellow = UIColor(red: 0.98, green: 1, blue: 0, alpha: 1)
    
    static let specialGrey = UIColor(red: 0.235, green: 0.227, blue: 0.227, alpha: 1.0) // Color: #3C3A3A
    
    static let specialOrange = UIColor(red: 1, green: 0.61, blue: 0.02, alpha: 1.0)
    
    static func gradientColor() -> UIColor {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = UIScreen.main.bounds
        gradientLayer.colors = [specialYellow.cgColor, specialOrange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1) // Start from bottom
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return UIColor(patternImage: image!)
    }
    
    static let speciallightBlack = UIColor(red: 60/256, green: 58/256, blue: 58/256, alpha: 1)
    
    
    
}
