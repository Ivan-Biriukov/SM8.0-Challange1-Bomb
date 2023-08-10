//
//  UIImage+Extension.swift
//  SM8.0-Challange1-Bomb
//
//  Created by Ilyas Tyumenev on 10.08.2023.
//

import UIKit

extension UIImage {
    
    class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("Failed to create CGImage source")
            return nil
        }
        
        let frameCount = CGImageSourceGetCount(source)
        var images: [UIImage] = []
        
        for i in 0..<frameCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                let image = UIImage(cgImage: cgImage)
                images.append(image)
            }
        }
        
        return UIImage.animatedImage(with: images, duration: 2.0)
    }
}
