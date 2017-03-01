//
//  MalertViewController.swift
//  Pods
//
//  Created by Vitor Mesquita on 01/11/16.
//
//

import UIKit
import Cartography

class MalertViewController: BaseMalertViewController {
    
    fileprivate lazy var visibleView: UIView = self.buildVisibleView()
    fileprivate let bottomInsetConstraintGroup = ConstraintGroup()
    
    fileprivate var malertView: MalertView? {
        willSet {
            if let malertView = malertView {
                malertView.removeFromSuperview()
            }
        }
        didSet {
            guard let malertView = malertView else {
                return
            }
            malertView.alpha = 1
            visibleView.addSubview(malertView)
            constrain(malertView, visibleView) { (malertView, visibleView) in
                malertView.center == visibleView.center
                malertView.left == visibleView.left + 16
                malertView.right == visibleView.right - 16
            }
        }
    }
    
    override func loadView() {
        
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
//        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listenKeyboard()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        constrain(view, visibleView, replace: bottomInsetConstraintGroup, block: { (view, visibleView) -> () in
            visibleView.bottom == view.bottom - keyboardRect.size.height
        })
    }
    
    override func keyboardWillShow(sender: NSNotification) {
        super.keyboardWillShow(sender: sender)
        view.setNeedsUpdateConstraints()
    }
    
    override func keyboardWillHide(sender: NSNotification) {
        super.keyboardWillHide(sender: sender)
        view.setNeedsUpdateConstraints()
    }
    
}

extension MalertViewController {
    
    /**
     * Extension to create and put MalertView on screen
     */ 
    func setMalertView(malertViewStruct: MalertViewStruct) {
        self.malertView = MalertView.buildAlert(with: malertViewStruct)
    }
    
    func getMalertView() -> MalertView? {
        return malertView
    }
    
    func buildVisibleView() -> UIView {
        let visibleView = UIView(frame: self.view.frame)
//        visibleView.backgroundColor = .red
        view.addSubview(visibleView)
        constrain(visibleView, view) { (visibleView, containerView) in
            visibleView.top == containerView.top
            visibleView.right == containerView.right
            visibleView.left == containerView.left
        }
        return visibleView
    }
}
