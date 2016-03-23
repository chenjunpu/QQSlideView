//
//  ContainerTabBarController.swift
//  QQSlideView
//
//  Created by chenjunpu on 16/3/22.
//  Copyright © 2016年 chenjunpu. All rights reserved.
//

import UIKit

class ContainerTabBarController: UITabBarController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewControllers()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}

//MARK: - set up UI
extension ContainerTabBarController{
    
    private func addChildViewControllers() {
        addChildViewController(MessageViewController(), title: "消息", imageName: "tab_recent_")
        addChildViewController(ContactViewController(), title: "联系人", imageName: "tab_buddy_")
        addChildViewController(DynamicViewController(), title: "动态", imageName: "tab_qworld_")
    }
    
    private func addChildViewController(vc: UIViewController, title: String, imageName: String) {
        
        vc.title = title
        
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 13/255.0, green: 184/255.0, blue: 246/255.0, alpha: 1)], forState: .Selected)
        
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(10)], forState: .Normal)
        
        vc.tabBarItem.image = UIImage(named: imageName + "nor")
        
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "press")?.imageWithRenderingMode(.AlwaysOriginal)
        
        addChildViewController(vc)
        
    }
    
}

//MARK: - UITabBarDelegate
extension ContainerTabBarController{
    
    /**
     post Notification to change NavigationController title
     */
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        NSNotificationCenter.defaultCenter().postNotificationName("changeTitle", object: item.title)

    }
}