//
//  MainViewController.swift
//  QQSlideView
//
//  Created by chenjunpu on 16/3/22.
//  Copyright © 2016年 chenjunpu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - properties
    private var mainNav: UINavigationController?
    
    lazy private var slideV: SlideView = SlideView()
    lazy private var img: UIImageView = {
        
        let i = UIImageView(image: UIImage(named: "sidebar_bg"))
        return i
    }()
    lazy private var mainTabBar: ContainerTabBarController = ContainerTabBarController()

//    right limit transform
    private var rightTransform: CGAffineTransform?
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        set right limit transform
        rightTransform = CGAffineTransformTranslate(self.view.transform, UIScreen.mainScreen().bounds.size.width * 0.75, 0)
        
        setupUI()
        
//        addObserver to change Navigation title
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changNavTitle:", name: "changeTitle", object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: - Notification method
    func changNavTitle(notify: NSNotification){
        
        mainTabBar.navigationItem.title = notify.object as? String
        
    }
    
}

//MARK: - UI method
extension MainViewController{
    
    private func setupUI(){
        
        view.backgroundColor = UIColor(red: 13/255.0, green: 184/255.0, blue: 246/255.0, alpha: 1)
        
        self.view.addSubview(img)
        self.view.addSubview(slideV)
        
        slideV.frame = CGRectMake(-self.view.frame.size.width * 0.25, 0, self.view.bounds.size.width, self.view.bounds.size.height)
        slideV.delegate = self
        
        img.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.4)
        
        addTabbarController()
    }
    
    private func addTabbarController(){
        

        mainNav = UINavigationController(rootViewController: mainTabBar)
        mainTabBar.navigationItem.title = "消息"
        
        addChildViewController(mainNav!)
        view.addSubview(mainNav!.view)
        
        mainTabBar.view.frame = self.view.bounds
        
        addRecognizer()
        
    }
}

//MARK: - GestureRecognizer method
extension MainViewController{
    
    private func addRecognizer(){
        
        let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "panEvent:")
        
        self.view.addGestureRecognizer(pan)
    }
    
    @objc private func panEvent(recognizer: UIPanGestureRecognizer){
        
        let trans = recognizer.translationInView(mainNav?.view)
        
        mainNav?.view.transform = CGAffineTransformTranslate((mainNav?.view.transform)!, trans.x, 0)
        
        slideV.transform.tx = (mainNav?.view.transform.tx)! / 3
        
        recognizer.setTranslation(CGPointZero, inView: mainNav?.view)
        
//        When moving to the right limit
        if mainNav?.view.transform.tx > rightTransform!.tx {
            
            mainNav?.view.transform = rightTransform!
            
            slideV.transform.tx = (mainNav?.view.transform.tx)! / 3
            
        }else if mainNav?.view.transform.tx < 0.0 {
            
            mainNav?.view.transform = CGAffineTransformTranslate(self.view.transform, 0, 0)
            
            slideV.transform.tx = (mainNav?.view.transform.tx)! / 3
            
        }
        
//        when gestureRecognizer did end
        if recognizer.state == .Ended{
            
            if self.mainNav?.view.frame.origin.x > UIScreen.mainScreen().bounds.size.width * 0.5{
            
                showMenu()
                
            }else{
                
                showHome()

            }
        }
    }
    
    @objc private func showMenu(){
        
        let rightTransform: CGAffineTransform = CGAffineTransformTranslate(self.view.transform, UIScreen.mainScreen().bounds.size.width * 0.75, 0)
        doSlide(rightTransform)
    }
    
    @objc private func showHome(){
        
        doSlide(CGAffineTransformIdentity)
    }
    
    @objc private func doSlide(proportion: CGAffineTransform){
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            self.mainNav?.view.transform = proportion
            self.slideV.transform.tx = (self.mainNav?.view.transform.tx)! / 3
        })
        
    }
}

//MARK: - SlideTableViewDelegate
extension MainViewController: SlideTableViewDelegate{
    
    func didSelectItem(title: String){
        
        let vc = OtherViewController()
        vc.title = title
        vc.hidesBottomBarWhenPushed = true
        mainNav?.pushViewController(vc, animated: true)
        showHome()
    }
    
    func didSelectHeadBtn(title: String){
        
        let vc = OtherViewController()
        vc.title = title
        vc.hidesBottomBarWhenPushed = true
        mainNav?.pushViewController(vc, animated: true)
        showHome()
    }
}
