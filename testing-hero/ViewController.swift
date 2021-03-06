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
        let cell = UITableViewCell()
        
        cell.backgroundColor = uicolorArr[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row)"
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        print("heightForRow ✅ indexPath.row: \(indexPath.row)")
        
        if currentSelectedCell != -1 && currentSelectedCell == indexPath.row && currentSelectedCell != previousSelectedCell {
            print("self.view.frame.size.height * 0.5: \(self.view.frame.size.height * 0.5)")
            return self.view.frame.size.height * 0.5
        }
            
        else if isSameSelectedCell && currentSelectedCell == indexPath.row {
            print("self.view.frame.size.height: \(self.view.frame.size.height)")
            return self.view.frame.size.height
        }
            //
            //        else if currentSelectedCell == previousSelectedCell {
            //            return self.view.frame.size.height
            //        }
            
            //        if previousSelectedCell == currentSelectedCell {
            //
            //            if currentSelectedCell == -1 {
            //                return 200
            //            } else {
            //                return self.view.frame.size.height * 0.8
            //            }
            //
            //        } else {
            //            return self.view.frame.size.height * 0.5
            //        }
        else {
            print("200")
            return 200
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
            
            /*
             UIView.animate(withDuration: 3.0) {
             
             selectedCell.contentView.layoutIfNeeded()
             }
             
             
             tableView.beginUpdates()
             tableView.endUpdates()
             
             tableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: UITableViewScrollPosition.middle, animated: true)
             */
        }
        
        
        previousSelectedCell = currentSelectedCell
        
        /*
         for index in 0...6 {
         if index == selctedIndexRow {
         print("= \(index)")
         UIView.animate(withDuration: 4.0, animations: {
         selectedCell.backgroundColor = UIColor.randomColor()
         }, completion: { (result) in
         
         })
         
         }
         else if index < selctedIndexRow {
         print("< \(index)")
         UIView.animate(withDuration: 4.0, animations: {
         selectedCell.center.y -= 100
         }, completion: { (result) in
         
         })
         
         
         }
         //            else {
         //                print("> \(index)")
         //                selectedCell.center.y += 100
         //            }
         
         }
         
         
         
         */
        
        //
        //        for index in 0...6 {
        //            let selectedCell = tableView.cellForRow(at: IndexPath(row: index, section: 0))!
        //
        //            if index > indexPath.row {
        //
        //                UIView.animate(withDuration: 4.0, animations: {
        //                    if index > indexPath.row {
        //                    selectedCell.center.y += 100
        //                    } else {
        //                        selectedCell.center.y -= 100
        //                    }
        //                }, completion: { (result) in
        //
        //                })
        //
        //            }
        //        }
        
        
        
        
        //        let secondVC = storyboard!.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        //        secondVC.transitioningDelegate = self
        //        secondVC.passedString = "hello?"
        //        present(secondVC, animated: true, completion: nil)
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
