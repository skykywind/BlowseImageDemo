//
//  Utils.swift
//  BlowseImageDemo
//
//  Created by AtronJia on 2017/2/24.
//  Copyright © 2017年 Artron. All rights reserved.
//

import Foundation
import UIKit

let screenWidth:CGFloat = UIScreen.main.bounds.width
let screenHeight:CGFloat = UIScreen.main.bounds.height

func showImageToFullScreen(_ image: UIImage?) ->CGRect {
    guard image != nil else {
        return CGRect.zero
    }
    let h:CGFloat = screenWidth * image!.size.height / image!.size.width
    let x:CGFloat = 0.0
    let y:CGFloat = (screenHeight - h) * 0.5
    
    return CGRect(x: x, y: y, width: screenWidth, height: h)
    
}
