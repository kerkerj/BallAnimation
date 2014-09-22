//
//  ViewController.swift
//  in.kerkerj.animation_test
//
//  Created by Jerry Huang on 2014/9/17.
//  Copyright (c) 2014年 Jerry Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let btn = UIButton()
    let slideBar = UISlider()
    
    var width : CGFloat = 0.0
    var height : CGFloat = 0.0
    var objectNums : Int = 1
    
    struct currentPoint {
        var x: CGFloat
        var y: CGFloat
        var initialized: Bool
    }
    
    var point = currentPoint(x: 0.0, y: 0.0, initialized: true)
    
    func _init() {
        // Get Screen resolution
        var bounds: CGRect = UIScreen.mainScreen().bounds
        width = bounds.size.width
        height = bounds.size.height
        
        // slideBar
        self.slideBar.frame = CGRectMake(width/2 - 300/2, height*0.8 + 40, 300, 20)
        self.slideBar.value = 1.0
        self.slideBar.maximumValue = 50.0
        self.slideBar.addTarget(
            self,
            action: Selector("getSlider:"),
            forControlEvents: UIControlEvents.TouchUpInside)
        
        // button
        self.btn.frame = CGRectMake(width/2 - 25, height*0.8, 50, 20)
        self.btn.setTitle("Show", forState: UIControlState.Normal)
        self.btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.btn.backgroundColor = UIColor.whiteColor()
        self.btn.layer.cornerRadius = 7
        self.btn.layer.borderWidth = 0.5
        self.btn.addTarget(
            self,
            action: Selector("showAnimation:"),
            forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(btn)
        self.view.addSubview(slideBar)
        
        // Add getTapRecognizer
        var getTapRecognizer = UITapGestureRecognizer(target: self, action: Selector("getTap:"))
        self.view.addGestureRecognizer(getTapRecognizer)
    }
    
    // Get slider value
    func getSlider(sender : UISlider) {
        objectNums = Int(sender.value)
        
        if objectNums <= 0 {
            objectNums = 1
        }
        
        println(objectNums)
    }
    
    // Button added
    func showAnimation(sender: UIButton) {
        for loopNum in 1...objectNums {
            self.genObjectView(0.0, y: 0.0)
        }
    }
    
    // Generate Circle
    func genObjectView(x : CGFloat, y: CGFloat) {
        let duration = 0.5
        let delay = 0.0
        let options = UIViewAnimationOptions.CurveLinear
        let size : CGFloat = CGFloat( Int(rand()) %  40 + 20.0)
        let xPosition : CGFloat = CGFloat( Int(rand()) %  Int(height) + 20.0)
        let yPosition : CGFloat = CGFloat( Int(rand()) %  Int(height) + 20.0)
        let radius : CGFloat = 20.0
        
        let coloredSquare = UIView()
        coloredSquare.backgroundColor = self.getRandomColor()
        coloredSquare.frame = CGRect(x: x, y: y, width: radius, height: radius)
        coloredSquare.layer.cornerRadius = radius/2
        
        self.view.addSubview(coloredSquare)
        
        UIView.animateWithDuration(
            duration,
            delay: delay,
            options: options,
            animations: {
                coloredSquare.backgroundColor = self.getRandomColor()
                coloredSquare.frame = CGRect(
                    x: xPosition,
                    y: yPosition,
                    width: radius/2,
                    height: radius/2)
            },
            completion: { animationFinished in
                coloredSquare.removeFromSuperview()
            }
        )
    }
    
    // Get random UIColor
    func getRandomColor() -> UIColor {
        var randomRed:CGFloat = CGFloat(drand48())
        var randomGreen:CGFloat = CGFloat(drand48())
        var randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    // Get Tap
    func getTap(recognizer: UITapGestureRecognizer) {
        var message: String = "( \(point.x) , \(point.y) )"
        println(message)
        for loop in 1...objectNums {
            genObjectView(point.x, y: point.y)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _init()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        let touch : UITouch = touches.anyObject() as UITouch
        let cgpoint: CGPoint = touch.locationInView(self.view)
        
        point.x = cgpoint.x
        point.y = cgpoint.y
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}