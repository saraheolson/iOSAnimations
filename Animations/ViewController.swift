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

    // set up some constants for the square
    let size : CGFloat = 50
    let yPosition : CGFloat = 120
    
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

        // Create and add a colored square
        let coloredSquare = UIView()
        
        // set background color to blue
        coloredSquare.backgroundColor = UIColor.blueColor()
        
        // set frame (position and size) of the square
        // iOS coordinate system starts at the top left of the screen
        // so this square will be at top left of screen, 50x50pt
        // CG in CGRect stands for Core Graphics
        coloredSquare.frame = CGRect(x: 0, y: 120, width: 50, height: 50)
        
        // finally, add the square to the screen
        self.view.addSubview(coloredSquare)
        
        UIView.animateWithDuration(1.0, animations: {
            
            // animate color change and position
            coloredSquare.backgroundColor = UIColor.redColor()
            coloredSquare.frame = CGRect(x: 320-50, y: 120, width: 50, height: 50)
            
            }, completion: { animationFinished in
                
                // when complete, remove the square from the parent view
                coloredSquare.removeFromSuperview()
                
        })
    }
    
    // we override this method to manage what style status bar is shown
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return self.presentingViewController == nil ? UIStatusBarStyle.Default : UIStatusBarStyle.LightContent
    }
}