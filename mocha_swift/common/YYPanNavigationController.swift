//
//  YYPanNavigationController.swift
//  mocha_swift
//
//  Created by 向文品 on 14-6-25.
//  Copyright (c) 2014年 向文品. All rights reserved.
//

import UIKit
let KEY_WINDOW = UIApplication.sharedApplication().keyWindow
class YYPanNavigationController: YYNavigationController {

    var startTouch:CGPoint?
    var lastScreenShotView:UIImageView?
    var blackMask:UIView?
    var backgroundView:UIView?
    var screenShotsList:NSMutableArray?
    var isMoving:Bool?
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.screenShotsList = NSMutableArray(capacity: 2)
    }
    
    init(rootViewController: UIViewController!)
    {
        super.init(rootViewController: rootViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var recognizer = UIPanGestureRecognizer(target: self, action: "paningGestureReceive:")
        recognizer.delaysTouchesBegan = true
        self.view.addGestureRecognizer(recognizer)
    }
    
    override func pushViewController(viewController: UIViewController!, animated: Bool) {
        self.screenShotsList?.addObject(self.capture())
        
        super.pushViewController(viewController,animated:animated)
        
        //lastScreenShotView!.image = nil
    }
    
    override func popViewControllerAnimated(animated: Bool) -> UIViewController! {
        self.screenShotsList?.removeLastObject()
        
        
        //lastScreenShotView!.image = nil
        return super.popViewControllerAnimated(animated)
    }
    
    override func popToViewController(viewController: UIViewController!, animated: Bool) -> AnyObject[]! {
        //        var index = self.viewControllers!
        //
        //        var index = self.viewControllers.indexOfObject(viewController)
        //        for (int i=0 i<self.viewControllers.count-index-1 i++) {
        //            [self.screenShotsList removeLastObject]
        //        }
        //        lastScreenShotView.image = nil
        return super.popToViewController(viewController,animated:animated)
    }
    
    func capture()->UIImage{
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size,self.view.opaque, 0.0)
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext())
        
        var img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return img
    }
    
    
    // set lastScreenShotView 's position and alpha when paning
    func moveViewWithX(var x:Float)
    {
        x = Float(x>320 ? 320 : x)
        x = Float(x<0 ? 0 : x)
        
        var frame = self.view.frame
        frame.origin.x = x
        self.view.frame = frame
        
        var scale = (x/6400)+0.95
        var alpha = 0.4 - (x/800)
        
        self.lastScreenShotView!.transform = CGAffineTransformMakeScale(scale, scale)
        blackMask!.alpha = alpha
        self.view.superview.bringSubviewToFront(self.view)
    }
    
    //pragma mark - Gesture Recognizer -
    
    func paningGestureReceive(recoginzer:UIPanGestureRecognizer)
    {
        // If the viewControllers has only one vc or disable the interaction, then return.
        if self.viewControllers.count <= 1{
            return
        }
        
        // we get the touch position by the window's coordinate
        var touchPoint = recoginzer.locationInView(KEY_WINDOW)
        
        // begin paning, show the backgroundView(last screenshot),if not exist, create it.
        if recoginzer.state == UIGestureRecognizerState.Began {
            
            isMoving = true
            startTouch = touchPoint
            
            if !self.backgroundView
            {
                var frame = self.view.frame
                
                self.backgroundView = UIView(frame:CGRectMake(0, 0, frame.size.width , frame.size.height))
                self.backgroundView!.backgroundColor = UIColor.blackColor()
                self.view.superview.insertSubview(self.backgroundView, aboveSubview: self.view)
                
                blackMask = UIView(frame:CGRectMake(0, 0, frame.size.width , frame.size.height))
                blackMask!.backgroundColor = UIColor.blackColor()
                self.backgroundView!.addSubview(blackMask)
            }
            if !self.backgroundView!.superview {
                self.view.superview.insertSubview(self.backgroundView ,belowSubview:self.view)
            }
            self.backgroundView!.hidden = false
            
            if lastScreenShotView{
                lastScreenShotView!.removeFromSuperview()
            }
            
            
            //var lastScreen:UIImage = self.screenShotsList!.lastObject
            lastScreenShotView = UIImageView(frame: self.backgroundView!.bounds)
            lastScreenShotView!.image = self.screenShotsList!.lastObject as UIImage
            self.backgroundView!.insertSubview(lastScreenShotView,belowSubview:blackMask)
            
            //End paning, always check that if it should move right or move left automatically
        }else if recoginzer.state == UIGestureRecognizerState.Ended{
            
            
            if touchPoint.x - startTouch!.x > 50{
                
                UIView.animateWithDuration(0.3, animations: {
                    self.moveViewWithX(Float(320))
                    }, completion: {(_) -> Void in
                        self.popViewControllerAnimated(false)
                        var frame = self.view.frame
                        frame.origin.x = 0
                        self.view.frame = frame
                        
                        self.isMoving = false
                    })
            }else{
                UIView.animateWithDuration(0.2, animations: {
                    self.moveViewWithX(Float(0))
                    }, completion: {(_) -> Void in
                        self.isMoving = false
                        self.backgroundView!.hidden = true
                    })
                
            }
            return;
            
            // cancal panning, alway move to left side automatically
        }else if recoginzer.state == UIGestureRecognizerState.Cancelled{
            UIView.animateWithDuration(0.2, animations: {
                self.moveViewWithX(Float(0))
                }, completion: {(_) -> Void in
                    self.isMoving = false
                    self.backgroundView!.hidden = true
                })
            return;
        }
        
        // it keeps move with touch
        if self.isMoving {
            self.moveViewWithX(touchPoint.x - startTouch!.x)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // #pragma mark - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */

}
