//
//  RWSBounceButton.swift
//  Ranjithkumar Matheswaran
//
//  Created by Ranjithkumar on 06/05/16.
//  Copyright © 2016 Ranjith Work Studio - http://iranjith4.com. All rights reserved.
//

import UIKit

public class RWSBounceButton: UIButton {
    
    var selectedColor = UIColor.orangeColor()
    var normalColor = UIColor.whiteColor()
    var selectedBorderColor = UIColor.orangeColor()
    var normalBorderColor = UIColor.orangeColor()
    
    private
    var isShrinked : Bool = false
    var isShrinking : Bool = false
    var touchEnded : Bool = false
    var touchDelayTimer : NSTimer!
    var isButtonSelected : Bool = false
    
    public init(frame: CGRect, selectedString : String, normalString : String) {
        super.init(frame: frame)
        self.setTitle(normalString, forState: UIControlState.Normal)
        self.setTitle(selectedString, forState: UIControlState.Selected)
        
        self.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        self.addTarget(self, action: #selector(changeState), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.orangeColor().CGColor
        self.layer.masksToBounds = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.adjustsImageWhenHighlighted = true
        self.tintColor = UIColor.orangeColor()
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.orangeColor().CGColor
        self.layer.masksToBounds = true
    }
    
    //Animations for the buttons
    
    func beginShrinkAnimation(){
        self.touchDelayTimer.invalidate()
        self.isShrinked = true
        
        UIView.animateWithDuration(0.3) {
            self.isShrinking = true
            self.transform = CGAffineTransformMakeScale(0.83, 0.83)
        }
        
        UIView.animateWithDuration(0.18, animations: {
            if (self.touchEnded) {
                self.isShrinking = false
                return
            }
            self.transform = CGAffineTransformMakeScale(0.85, 0.85)
        }) {(finished) in
            self.isShrinking = false
        }
    }
    
    func beginEnlargeAnimation(){
        self.isShrinked = false
        if self.isShrinking {
            self.isShrinking = false
            let presentationLayer = self.layer.presentationLayer()
            self.transform = CATransform3DGetAffineTransform((presentationLayer?.transform)!)
            UIView.animateWithDuration(0.1, animations: {
                self.transform = CGAffineTransformMakeScale(0.85, 0.85)
            })
        }else{
            UIView.animateWithDuration(0.1, animations: {
                self.transform = CGAffineTransformMakeScale(0.85, 0.85)
            })
        }
        
        UIView.animateWithDuration(0.18, animations: {
            self.transform = CGAffineTransformMakeScale(1.05, 1.05)
        })
        
        UIView.animateWithDuration(0.18, animations: {
            self.transform = CGAffineTransformMakeScale(0.98, 0.98)
        })
        
        UIView.animateWithDuration(0.17, animations: {
            self.transform = CGAffineTransformMakeScale(1.01, 1.01)
        })
        
        UIView.animateWithDuration(0.17, animations: {
            self.transform = CGAffineTransformIdentity
        })
    }
    
    //MARK: - Touch Event
    
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.touchEnded = false
        self.touchDelayTimer = NSTimer.scheduledTimerWithTimeInterval(0.15, target: self, selector: #selector(beginShrinkAnimation), userInfo: nil, repeats: false)
        NSRunLoop.currentRunLoop().addTimer(self.touchDelayTimer, forMode: NSRunLoopCommonModes)
    }
    
    override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        self.touchEnded = true
        self.touchDelayTimer.invalidate()
        beginEnlargeAnimation()
    }
    
    override public func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesEnded(touches!, withEvent: event)
        self.touchEnded = true
        self.touchDelayTimer.invalidate()
        if self.isShrinked {
            self.beginEnlargeAnimation()
        }
    }
    
    //MARK : Selector Method
    public func changeState(){
        if self.isButtonSelected {
            isButtonSelected = false
            self.selected = false
            self.backgroundColor = normalColor
        }else{
            isButtonSelected = true
            self.selected = true
            self.backgroundColor = selectedColor
        }
    }
    
    public func setButtonSelected(selected : Bool){
        self.isButtonSelected = selected
        changeState()
    }
    
    
}
