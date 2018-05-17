//
//  UIImageView+SetImageFromURL.swift
//  APOD
//
//  Created by Vinoth Vino on 17/05/18.
//  Copyright © 2018 Coder Earth. All rights reserved.
//

import UIKit.UIImageView

extension UIImageView {
    
    func setImageFromURL(stringImageUrl url: String){
        
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}
