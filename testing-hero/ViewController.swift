//
//  ViewController.swift
//  testing-hero
//
//  Created by Mengying Feng on 10/1/17.
//  Copyright © 2017 iEmRollin. All rights reserved.
//

import UIKit

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
    
    let weekdayArr = [5, 6, 7, 1, 2, 3, 4]
    let taskNoArr = [0, 1, 1, 1, 2, 3, 4]
    let daysInRow = 2 // unfinished/current active task no
    
    var isScrolled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCurrentActiveTask(withIndex: daysInRow)
        setupTableView()
    }
    
    func setupCurrentActiveTask(withIndex num: Int) {
//        var currentActiveIndexArr = [Int]()
//        
//        for item in weekdayArr {
//            
//            if item != 1 && item != 7 {
//                
//                currentActiveIndexArr.append(item)
//           
//                if currentActiveIndexArr.count == daysInRow + 1 {
//                    break
//                }
//            }
//            
//        }
//        
//        print("currentActiveIndex: \(currentActiveIndexArr.last!)")
        
        // get the index of the value = 3 in taskNoArr
        let index = taskNoArr.index(of: daysInRow)!
        
        
        currentSelectedCell = index
        previousSelectedCell = index
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
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
        cell.configureCell(weekdayNo: weekdayArr[indexPath.row], currentActiveTaskNo: daysInRow, taskNo: taskNoArr[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if currentSelectedCell != -1 && currentSelectedCell == indexPath.row && currentSelectedCell != previousSelectedCell {
            return 343
        }
        else if isSameSelectedCell && currentSelectedCell == indexPath.row {
            return self.view.frame.size.height
        }
        else if currentSelectedCell == indexPath.row {
            return 343
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
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! WeekviewTableViewCell
        
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
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if !isScrolled {
            tableView.scrollToRow(at: IndexPath(row: currentSelectedCell, section: 0), at: UITableViewScrollPosition.middle, animated: true)
            isScrolled = true
        }
        
    }
    
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("animationController:forDismissed ❗️")
        transition.presenting = false
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.3) {
            
            self.isSameSelectedCell = false
            
            self.previousSelectedCell = self.currentSelectedCell
            
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
