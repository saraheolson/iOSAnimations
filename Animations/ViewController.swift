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

        // set up some constants for the square
        // set size to be a random number between 20.0 and 60.0
        let size : CGFloat = CGFloat( arc4random_uniform(40))+20
        
        // set yPosition to be a random number between 20.0 and 220.0
        let yPosition : CGFloat = CGFloat( arc4random_uniform(200))+20

        let coloredSquare = UIView()

        // create the square using these constants
        // in this example I've also used the Objective-C convention for making the CGRect
        // but I could have used CGRect(x:0, y:yPosition, width:size, height:size) like we've done previously - they are equivalent
        coloredSquare.backgroundColor = UIColor.blueColor()
        coloredSquare.frame = CGRectMake(0, yPosition, size, size)
        self.view.addSubview(coloredSquare)

        // set up some constants for the animation
        let duration = 1.0
        let delay = 0.0
        let options = UIViewAnimationOptions.CurveLinear
        
        // define the animation
        UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
            
            coloredSquare.backgroundColor = UIColor.redColor()
            
            // again use the square constants size and yPosition
            coloredSquare.frame = CGRectMake(320-size, yPosition, size, size)
            
            }, completion: { animationFinished in
                
                coloredSquare.removeFromSuperview()
        })
    }
    
    // we override this method to manage what style status bar is shown
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return self.presentingViewController == nil ? UIStatusBarStyle.Default : UIStatusBarStyle.LightContent
    }
}