//
//  LastShot.swift
//  modul2Lesson10
//
//  Created by Давид Узунян on 19.01.2024.
//

import UIKit

class LastShot: UIViewController {

    var receivedImage: UIImage?
        
    lazy var imageView: UIImageView = {
            let imageSize: CGFloat = 600
            let screenWidth = view.frame.width
            let xCoordinate = (screenWidth - imageSize) / 2
            let imageView = UIImageView(frame: CGRect(x: xCoordinate, y: 100, width: imageSize, height: imageSize))
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            view.addSubview(imageView)
            
            if let image = receivedImage {
                imageView.image = image
            }
        }

}
