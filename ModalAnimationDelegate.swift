//
//  ModalAnimationDelegate.swift
//  BlowseImageDemo
//
//  Created by AtronJia on 2017/2/24.
//  Copyright © 2017年 Artron. All rights reserved.
//

import UIKit

class ModalAnimationDelegate: NSObject, UIViewControllerTransitioningDelegate {
    // 用来区分present 和 dismiss
    fileprivate var isPresent: Bool = true
    fileprivate var duration: TimeInterval = 1
}

extension ModalAnimationDelegate: UIViewControllerAnimatedTransitioning {
    // present方法
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }
    
    // dismiss方法
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        return self
    }
    
    
}

extension ModalAnimationDelegate {
    // MARK: UIViewControllerAnimatedTransitioning 必须实现的的两个代理方法
    // 动画时间
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    // 动画效果
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        isPresent ? customPresentAnimation(transitionContext) : customDismissAnimation(transitionContext)
    }
    
    // 自定义present动画
    private func customPresentAnimation(_ transitionContext: UIViewControllerContextTransitioning){
        
        // 获取转场上下文中的 目标view 和 容器view，并将目标view添加到容器view上
        let destinationView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let containerView = transitionContext.containerView
        guard let _ = destinationView else {
            return
        }
        containerView.addSubview(destinationView!)
        
        // 目标控制器
        let destinationVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? BlowseBigImageViewController
        // 获取点击的indexPath
        let indexPath = destinationVC?.currentIndexPath
        // 当前控制器
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? ViewController
        let collectionView = fromVC?.collectionView
        // 获取选择的cell
        let selectedCell = collectionView?.cellForItem(at: indexPath!) as! ImageCollectionViewCell
        
        // 获取cell filterWithImage的图片
        let image = UIImage(cgImage: selectedCell.contentView.layer.contents as! CGImage)
//         //获取cell showImage的图片
//        let image = selectedCell.imgView.image
        // 创建一个imageview用来做动画
        let animateView = UIImageView(image: image)
        animateView.contentMode = .scaleAspectFill
        animateView.clipsToBounds = true
        
        // 获取cell的坐标转换
        let originFrame = collectionView?.convert(selectedCell.frame, to: UIApplication.shared.keyWindow)
        animateView.frame = originFrame!
        containerView.addSubview(animateView)
        let endFrame = showImageToFullScreen(image) //本张图片全屏时的frame
        destinationView?.alpha = 0
        
        // 改变frame和透明度
        UIView.animate(withDuration: duration, animations: {
            animateView.frame = endFrame
        }) { (finieshed) in
            transitionContext.completeTransition(true)
            UIView.animate(withDuration: 0.3, animations: {
                destinationView?.alpha = 1
            }, completion: { (_) in
                animateView.removeFromSuperview()
            })
        }
    }
    
    // 自定义dismiss动画
    private func customDismissAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.view(forKey: .from)
        let contentView = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: .from) as! BlowseBigImageViewController
        // 获取浏览大图控制器中的collectionView
        let collectionView = fromVC.collectionView
        // 获取当前显示的cell
        let dismissCell = collectionView?.visibleCells.first as! ImageCollectionViewCell
        let image = UIImage(cgImage: dismissCell.contentView.layer.contents as! CGImage)
        // 创建一个imageview用来做动画
        let animateView = UIImageView(image: image)
        animateView.contentMode = .scaleAspectFill
        animateView.clipsToBounds = true
        // 获取到当前cell在window的frame,即动画view的初始frame
        animateView.frame = (collectionView?.convert(dismissCell.frame, to: UIApplication.shared.keyWindow))!
        contentView.addSubview(animateView)
        
        // 根据dismissCell的indexPath找到九宫格中对应的cell
        let indexPath = collectionView?.indexPath(for: dismissCell)
        let originView = (transitionContext.viewController(forKey: .to) as! ViewController).collectionView
        var originCell = originView?.cellForItem(at: indexPath!)
        // 当originCell取不到时（证明这个cell不在可视范围内），将cell移动到视野中间
        if originCell == nil {
            originView?.scrollToItem(at: indexPath!, at: .centeredVertically, animated: false)
            originView?.layoutIfNeeded()
        }
        originCell = originView!.cellForItem(at: indexPath!)
        let originFrame = originView?.convert(originCell!.frame, to: UIApplication.shared.keyWindow)
        
        // 开始动画
        UIView.animate(withDuration: duration, animations: {
            animateView.frame = originFrame!
            fromView?.alpha = 0
        }, completion: { (_) in
            animateView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })

    }
}

























