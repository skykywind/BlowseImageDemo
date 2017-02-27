//
//  ViewController.swift
//  BlowseImageDemo
//
//  Created by AtronJia on 2017/2/24.
//  Copyright © 2017年 Artron. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    var collectionView: UICollectionView?
    fileprivate lazy var modalDelegate: ModalAnimationDelegate = ModalAnimationDelegate()
    // 这里默认30个图片了
    lazy var imgArray: Array<UIImage> = {
        var arr:Array<UIImage> = Array()
        for index in 0...30 {
            let imageStr = "images/10_" + String(abs(index - 17)) + ".jpg"
            let image = UIImage(named: imageStr)
            arr.append(image!)
        }
        return arr
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
    }

    func  initCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: (screenWidth - 25) / 4, height: (screenWidth - 25) / 4)
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 5, 0, 5)
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
        
        collectionView?.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCollectionViewCell")
    }
    
    //MARK: collectionview delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let blowse: BlowseBigImageViewController = BlowseBigImageViewController()
        blowse.currentIndexPath = indexPath
        blowse.imageArray = imgArray
        blowse.transitioningDelegate = modalDelegate
        blowse.modalPresentationStyle = .custom
        present(blowse, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        let image: UIImage = imgArray[indexPath.item]
        cell.filterWithImage(image, resizeStyle: kCAGravityResizeAspectFill)
        
        return cell
    }
}

