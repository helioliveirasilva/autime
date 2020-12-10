//
//  ViewController.swift
//  Autime
//
//  Created by Hélio Silva on 12/11/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(#colorLiteral(red: 0.5529411765, green: 0.8117647059, blue: 0.3921568627, alpha: 1).image(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
        navigationController?.navigationBar.barStyle = .black
//        navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// Color Image NavBar
extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

// Add SF Rounded
extension UIFont {
    class func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
        let font: UIFont
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: size)
        } else {
            font = systemFont
        }
        return font
    }
}

// Done Button Keyboard
extension UITextField {
    func addDoneButtonToKeyboard(myAction: Selector?) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Retornar", style: UIBarButtonItem.Style.done, target: self, action: myAction)
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.inputAccessoryView = doneToolbar
    }
}

extension UIViewController{
    func topMostViewController() -> UIViewController {
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController!.topMostViewController()
    }
}
extension UIApplication {
    func topMostViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController()
    }
}

// Get parent View Controller from UIView
extension UIResponder {
    public var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
