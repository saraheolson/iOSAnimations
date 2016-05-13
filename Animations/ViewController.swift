//
//  ViewController.swift
//  Animations
//
//  Created by floater on 5/12/16.
//  Copyright © 2016 SarahEOlson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let transitionManager = TransitionManager()

    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destinationViewController as UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        toViewController.transitioningDelegate = self.transitionManager
        
    }
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        // empty for now
    }
    
    @IBAction func animateButtonTapped(sender: AnyObject) {

        // loop from 0 to 5
        for i in 0...5 {
            
            // create a square
            let square = UIView()
            square.frame = CGRect(x: 55, y: 300, width: 20, height: 20)
            square.backgroundColor = UIColor.redColor()
            self.view.addSubview(square)
            
            // randomly create a value between 0.0 and 150.0
            let randomYOffset = CGFloat( arc4random_uniform(150))
            
            // for every y-value on the bezier curve
            // add our random y offset so that each individual animation
            // will appear at a different y-position
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: 16,y: 239 + randomYOffset))
            path.addCurveToPoint(CGPoint(x: 301, y: 239 + randomYOffset), controlPoint1: CGPoint(x: 136, y: 373 + randomYOffset), controlPoint2: CGPoint(x: 178, y: 110 + randomYOffset))
            
            // create the animation
            let anim = CAKeyframeAnimation(keyPath: "position")
            anim.path = path.CGPath
            anim.rotationMode = kCAAnimationRotateAuto
            anim.repeatCount = Float.infinity
            
            // each square will take between 4.0 and 8.0 seconds
            // to complete one animation loop
            anim.duration = Double(arc4random_uniform(40)+30) / 10
            
            // stagger each animation by a random value
            // `290` was chosen simply by experimentation
            anim.timeOffset = Double(arc4random_uniform(290))
            
            // add the animation 
            square.layer.addAnimation(anim, forKey: "animate position along path")
        }
    }
    
    // we override this method to manage what style status bar is shown
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return self.presentingViewController == nil ? UIStatusBarStyle.Default : UIStatusBarStyle.LightContent
    }
}