//
//  DrawerLeftViewController.swift
//  Clikat
//
//  Created by Night Reaper on 15/04/16.
//  Copyright © 2016 Gagan. All rights reserved.
//

import UIKit
import ENSwiftSideMenu

class LeftNavigationViewController : ENSideMenuNavigationController {
    
    
    var overLayView = UIView(frame: UIScreen.main.bounds)
    var menuController : UIViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overLayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        let tap = UITapGestureRecognizer(target: self, action: #selector(LeftNavigationViewController.handleTap(_:)))
        overLayView.addGestureRecognizer(tap)
        
        let leftDrawerVc = StoryboardScene.Main.instantiateLeftDrawerViewController()
        menuController = leftDrawerVc
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: leftDrawerVc, menuPosition:.left)
        
        sideMenu?.menuWidth = (UIScreen.main.bounds.width * 4.0)/5.0 // optional, default is 160
        sideMenu?.delegate = self
        sideMenu?.bouncingEnabled = false
        sideMenu?.allowPanGesture = false
        sideMenu?.allowLeftSwipe = false
        sideMenu?.allowRightSwipe = false
        view.bringSubview(toFront: navigationBar)
    }
    
    func handleTap(_ sender : UITapGestureRecognizer){
        toggleSideMenuView()
    }
}


// MARK: - ENSideMenu Delegate

extension LeftNavigationViewController : ENSideMenuDelegate{
    
    func sideMenuWillOpen() {
        view.endEditing(true)
        
        UIView.animate(withDuration: 0.3, animations: {
            weak var weakSelf : LeftNavigationViewController? = self
            weakSelf?.topViewController?.view.addSubview(self.overLayView)
        }) 
    }
    
    func sideMenuWillClose() {
        
        UIView.animate(withDuration: 0.4, animations: {
            weak var weakSelf : LeftNavigationViewController? = self
            weakSelf?.overLayView.removeFromSuperview()
        }) 
    }
    
    
}




