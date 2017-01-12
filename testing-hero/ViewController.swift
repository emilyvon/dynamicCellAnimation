//
//  ViewController.swift
//  testing-hero
//
//  Created by Mengying Feng on 10/1/17.
//  Copyright © 2017 iEmRollin. All rights reserved.
//

import UIKit

let uicolorArr = [UIColor.blue, UIColor.green, UIColor.brown, UIColor.cyan, UIColor.yellow, UIColor.orange, UIColor.magenta]

extension CGFloat {
    
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    
    static func randomColor() -> UIColor {
        
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
        
    }
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let transition = PopAnimator()
    var selectedIndexPath: IndexPath?
    
    var currentSelectedCell = -1
    var previousSelectedCell = -1
    var isSameSelectedCell = false
    
    var cellRectBeforeExpanding: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorStyle = .none
        
        
    }
    
    
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeekviewCell") as! WeekviewTableViewCell
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if currentSelectedCell != -1 && currentSelectedCell == indexPath.row && currentSelectedCell != previousSelectedCell {
            return 343
        }
        else if isSameSelectedCell && currentSelectedCell == indexPath.row {
            return self.view.frame.size.height
        }
            
        else {
            return 130
        }
    }
    
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("index: \(indexPath.row)")
        selectedIndexPath = indexPath
        
        //        let selctedIndexRow = indexPath.row
        
        let selectedCell = tableView.cellForRow(at: indexPath)!
        
        currentSelectedCell = indexPath.row
        
        if previousSelectedCell == currentSelectedCell {
            isSameSelectedCell = true
        } else {
            isSameSelectedCell = false
        }
        
        print("previous: \(previousSelectedCell)")
        print("current:\(currentSelectedCell)")
        print("isSame:\(isSameSelectedCell)")
        print("✅")
        
        
        if !isSameSelectedCell {
            
            UIView.animate(withDuration: 3.0) {
                
                selectedCell.contentView.layoutIfNeeded()
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
            tableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: UITableViewScrollPosition.middle, animated: true)
        }
            
        else {
            
            cellRectBeforeExpanding = tableView.rectForRow(at: indexPath)
            
            DispatchQueue.main.async {
                
                UIView.animate(withDuration: 3.0, animations: {
                    selectedCell.contentView.layoutIfNeeded()
                }, completion: { (_) in
                    
                    let secondVC = self.storyboard!.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
                    secondVC.transitioningDelegate = self
                    secondVC.passedString = "hello?"
                    self.present(secondVC, animated: true, completion: nil)
                })
                
                tableView.beginUpdates()
                tableView.endUpdates()
                
                tableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: UITableViewScrollPosition.middle, animated: true)
                
            }
        }
        
        previousSelectedCell = currentSelectedCell
    }
    
    
    
    
    
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("animationController:forDismissed ❗️")
        transition.presenting = false
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.3) {
            
            self.isSameSelectedCell = false
            
            self.previousSelectedCell = -1
            
            let selectedCell = self.tableView.cellForRow(at: IndexPath(row: self.currentSelectedCell, section: 0))!
            
            UIView.animate(withDuration: 1.0) {
                selectedCell.contentView.layoutIfNeeded()
            }
            
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            
            
            self.tableView.scrollToRow(at: IndexPath(row: self.currentSelectedCell, section: 0), at: UITableViewScrollPosition.middle, animated: true)
        }
        
        return transition
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("animationController:forPresented ❗️")
        //        let cellRect = tableView.rectForRow(at: selectedIndexPath!)
        let cellRect = cellRectBeforeExpanding!
        let rectInSuperview = tableView.convert(cellRect, to: tableView.superview)
        transition.originFrame = rectInSuperview
        transition.presenting = true
        transition.isExpanding = true
        return transition
    }
    
}
