//
//  ImageCollectionViewCell.swift
//  BlowseImageDemo
//
//  Created by AtronJia on 2017/2/24.
//  Copyright © 2017年 Artron. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    lazy var imgView: UIImageView = {
        let imgView: UIImageView = UIImageView(frame: self.contentView.bounds)
        imgView.isUserInteractionEnabled = true
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    // 需要交互时采用imageview添加图片
    func showImage(_ image: UIImage) {
        self.contentView.addSubview(imgView)
        imgView.image = image
    }
    
    /**
     *  如果只是一张图片做背景，直接设置layer
     *  @parm: image：UIImage        目标图片
     *  @parm: resizeStyle:String    图片缩放方式
     */
    func filterWithImage(_ image:UIImage, resizeStyle:String) {
//       下面方法据说耗内存太严重，没测试
//        self.contentView.backgroundColor = UIColor(patternImage: image)
        
        self.contentView.layer.contents = image.cgImage
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.contentsGravity = resizeStyle
    }
}
