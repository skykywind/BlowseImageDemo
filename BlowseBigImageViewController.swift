//
//  BlowsBigImageViewController.swift
//  BlowseImageDemo
//
//  Created by AtronJia on 2017/2/24.
//  Copyright © 2017年 Artron. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ImageCollectionViewCell"
private let cellMargin: CGFloat = 15.0
class BlowseBigImageViewController: UICollectionViewController {
    var currentIndexPath: IndexPath?
    var imageArray:Array<UIImage>?
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
        layout.minimumLineSpacing = 15.0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        self.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.frame.size.width = UIScreen.main.bounds.size.width + cellMargin  //重设宽度，翻页令图片处在正中
        self.collectionView?.isPagingEnabled = true
        guard currentIndexPath != nil else {
            return
        }
        // 设置显示时的位置（默认是从[0,0]开始的）
        self.collectionView?.scrollToItem(at: currentIndexPath! , at: .left, animated: false)
    }

    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return imageArray?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        guard  let image:UIImage = imageArray?[indexPath.item] else {
            cell.filterWithImage(#imageLiteral(resourceName: "empty_picture"),resizeStyle: kCAGravityResizeAspect)
            return cell
        }
        cell.filterWithImage(image, resizeStyle: kCAGravityResizeAspect)
        
        
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
    }

}
