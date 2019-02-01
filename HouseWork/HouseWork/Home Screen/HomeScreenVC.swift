//
//  HomeScreenVC.swift
//  HouseWork
//
//  Created by Sean Lohman on 1/18/19.
//  Copyright © 2019 Sean Lohman. All rights reserved.
//

import UIKit

class HomeScreenVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var houses = [HouseHold]()
    
    //Member Variables
    @IBOutlet weak var View_Menu: UIView!
    @IBOutlet weak var View_Black: UIView!
    @IBOutlet weak var constraintMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var constraintMenuLeft: NSLayoutConstraint!
    @IBOutlet var gestureScreenEdgePanLeft: UIScreenEdgePanGestureRecognizer!
    
    let maxBlackViewAlpha: CGFloat = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        constraintMenuLeft.constant = -constraintMenuWidth.constant
        
        View_Black.alpha = 0
        View_Black.isHidden = true
        
    }
    
    func openMenu(){

        //when the menu is opened, its left constraint should be 0, so it is visible
        constraintMenuLeft.constant = 0

        //view for dimming effect should also be shown
        View_Black.isHidden = false

        //animate the menu when it opens and including the opacity values of the black screen
        UIView.animate(withDuration: 0.3, animations: {
            
            self.view.layoutIfNeeded()
            self.View_Black.alpha = self.maxBlackViewAlpha
            
        }) { (complete) in
            
            self.gestureScreenEdgePanLeft.isEnabled = false
            
        }
        
    }
    
    func closeMenu(){
        //when the menu is closed, it's left constraint should be the value of its width, so that it is fully off the screen and is uninteractable.
        constraintMenuLeft.constant = -constraintMenuWidth.constant
        
        //animate closing of the menu, including alpha value for black screen
        UIView.animate(withDuration: 0.3, animations: {
            
            self.view.layoutIfNeeded()
            self.View_Black.alpha = 0
            
        }) { (complete) in
            
            //re-enabling the left screen pan gesture so we can detect it on next open
            self.gestureScreenEdgePanLeft.isEnabled = true
            
            //hide the view for dimming effect so it wont interrupt touches for the under views
            self.View_Black.isHidden = true
            
        }
    }
    

    @IBAction func gestureScreenEdgePanleft(_ sender: UIScreenEdgePanGestureRecognizer) {
        
        //retrieve the current state
        if sender.state == UIGestureRecognizer.State.began{
            
            //if the user has just started dragging, make sure dimming effect view is hidden
            View_Black.isHidden = false
            View_Black.alpha = 0
            
        }else if (sender.state == UIGestureRecognizer.State.changed){
            
            //retrieve the amount viewMenu has been dragged
            let tranX = sender.translation(in: sender.view).x
            if (-constraintMenuWidth.constant + tranX > 0) {
                
                //view Menu is being dragged
                constraintMenuLeft.constant = 0
                View_Black.alpha = maxBlackViewAlpha
                
            }else {
                
                //view menu is being dragged somewhere between min and max
                constraintMenuLeft.constant = -constraintMenuWidth.constant + tranX
                
                let ratio = tranX / constraintMenuWidth.constant
                let alphaValue = ratio * maxBlackViewAlpha
                
                View_Black.alpha = alphaValue
                
            }
            
        }else{
            
            //if the menu was dragged less than half of it's width, close it. Otherwise open it
            if (constraintMenuLeft.constant < -constraintMenuWidth.constant / 2) {
                
                self.closeMenu()
                
            } else {
                
                self.openMenu()
                
            }
            
        }
        
    }
    
    @IBAction func gesturePan(_ sender: UIPanGestureRecognizer) {
        
        //retrieve the current state of the gesture
        if sender.state == UIGestureRecognizer.State.began {
            
        }else if sender.state == UIGestureRecognizer.State.changed {
            
            //retrieve the amount view meny has been dragged
            let tranX = sender.translation(in: sender.view).x
            if tranX > 0 {
                
                //view menu fully dragged out
                constraintMenuLeft.constant = 0
                View_Black.alpha = maxBlackViewAlpha
                
            }else if tranX < -constraintMenuWidth.constant {
                
                //view menu fully dragged in
                constraintMenuLeft.constant = -constraintMenuWidth.constant
                View_Black.alpha = 0
                
            }else {
                
                //it's being dragged somewhere between min and max
                constraintMenuLeft.constant = tranX
                
                let ratio = (constraintMenuWidth.constant + tranX) / constraintMenuWidth.constant
                let alphaValue = ratio * maxBlackViewAlpha
                View_Black.alpha = alphaValue
                
            }
        }else{
            
            //if the drag was less than half of it's width, close it otherwise keep it open
            if constraintMenuLeft.constant < -constraintMenuWidth.constant / 2 {
                self.closeMenu()
            }else{
                self.openMenu()
            }
            
        }
        
    }
    
    //GestureTap Recognizer for when the Black opaque view is tapped it cloes the hamburger menu
    @IBAction func gestureTap(_ sender: UITapGestureRecognizer) {
        
        self.closeMenu()
        
    }

    
    //Adding Hamburger menu IBAction so when the hamburger menu button is clicked the menu slides open
    @IBAction func hamburgerMenu(_ sender: UIButton) {
        
        self.openMenu()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return houses.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath.row == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddHouseCell", for: indexPath)
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CardCell
        
        cell.configure()
        cell.CardViewLabel.text = houses[indexPath.item - 1].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (indexPath.item == 0) {
            print("Adding a House!")
            houses.append(HouseHold(HouseName: "TestHouse"))
            collectionView.reloadData()
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
