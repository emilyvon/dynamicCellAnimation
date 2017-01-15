//
//  PopAnimator.swift
//  testing-hero
//
//  Created by Mengying Feng on 10/1/17.
//  Copyright © 2017 iEmRollin. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration    = 3.0
    var presenting  = true
    var originFrame = CGRect.zero
    var isExpanding = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?)-> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        let fromController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        containerView.insertSubview(toController.view, belowSubview: fromController.view)
        
        if let weekviewController = fromController as? ViewController {
            let tableView = weekviewController.tableView!
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            let selectedCell = tableView.cellForRow(at: selectedIndexPath)!
            
            tableView.backgroundColor = UIColor.clear
            fromController.view.backgroundColor = UIColor.clear
            selectedCell.alpha = 0
            
            let selectedRowRelativeToVisibleCells = relativeRowInTableView(tableView: tableView, visibleCell: selectedCell)
            
            let topCellCount = selectedRowRelativeToVisibleCells
            
            let bottomCellCount = tableView.visibleCells.count - 1 - selectedRowRelativeToVisibleCells
            
            let topDistance = topCellCount * 130
            let bottomDistance = bottomCellCount * 130
            
            
        }
        
//        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
//        let fromView = presenting ? toView : transitionContext.view(forKey: UITransitionContextViewKey.from)!
        
        /*
        // testing
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.yellow.cgColor
        maskLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        */
        
        
//        if isExpanding {
//            herbView.alpha = 0
//        } else {
//            fromView.alpha = 1
        
//            herbView.layer.mask = maskLayer
            
//        }
        
//        let initialFrame = presenting ? originFrame : fromView.frame
//        let finalFrame = presenting ? fromView.frame : originFrame
//        
//        let xScaleFactor = presenting ?
//            initialFrame.width / finalFrame.width :
//            finalFrame.width / initialFrame.width
//        
//        let yScaleFactor = presenting ?
//            initialFrame.height / finalFrame.height :
//            finalFrame.height / initialFrame.height
//        
//        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
//            fromView.transform = scaleTransform
//            fromView.center = CGPoint(
//                x: initialFrame.midX,
//                y: initialFrame.midY)
//            fromView.clipsToBounds = true
        }
        
        //        containerView.addSubview(toView)
        //        containerView.bringSubview(toFront: fromView)
        
        
        

        
        UIView.animate(withDuration: duration, delay:0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: [.curveLinear],
                       animations: {
                        fromView.transform = self.presenting ?
                            CGAffineTransform.identity : scaleTransform
                        
                        
                        fromView.center = CGPoint(x: finalFrame.midX,
                                                  y: finalFrame.midY)
                        
                        if self.isExpanding {
                            fromView.alpha = 1
                        } else {
                            fromView.alpha = 0
                        }
                        
        }, completion:{_ in
            self.isExpanding = false
            transitionContext.completeTransition(true)
        })
        
    }
 
    
    private func relativeRowInTableView(tableView: UITableView, visibleCell: UITableViewCell) -> Int {
        
        var row = 0
        
        for cell in tableView.visibleCells {
            
            if cell == visibleCell {
                return row
            }
            row += 1
        }
        return row
    }
    
}
