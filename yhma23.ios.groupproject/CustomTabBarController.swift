//
//  CustomTabBarController.swift
//  yhma23.ios.groupproject
//
//  Created by Linus Ilbratt on 2024-04-03.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        self.view.backgroundColor = UIColor.white

    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false
        }

        if fromView != toView {
            let fromIndex = self.viewControllers?.firstIndex(of: selectedViewController!)
            let toIndex = self.viewControllers?.firstIndex(of: viewController)
            
            let offset = (toIndex! > fromIndex! ? self.view.bounds.width : -self.view.bounds.width)
            toView.frame = CGRect(x: offset, y: 0, width: toView.frame.width, height: toView.frame.height)

            UIView.animate(withDuration: 0.3, animations: {
                fromView.frame = CGRect(x: -offset, y: 0, width: fromView.frame.width, height: fromView.frame.height)
                toView.frame = CGRect(x: 0, y: 0, width: toView.frame.width, height: toView.frame.height)
            }, completion: { finished in
                if finished {
                    self.selectedIndex = self.viewControllers!.firstIndex(of: viewController)!
                }
            })
        }
        
        return true
    }
}

