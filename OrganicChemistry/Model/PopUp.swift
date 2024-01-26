//
//  popupCheckMark.swift.swift
//  OrganicChemistry
//
//  Created by 北村昌彦 on 2022/01/02.
//

import UIKit


struct PopUp {
    
    private var imageview = UIImageView()
    var color: UIColor { didSet { imageview.tintColor = color } }
    var duration: Double
    var animationOptions: UIView.AnimationOptions
    
    init(viewController: UIViewController, style: PopUpSyle) {
        
        color = .green
        duration = 1.0
        animationOptions = [.curveEaseIn]
        
        if let image = UIImage(systemName: style.rawValue) {
            
            imageview = UIImageView(image: image)
            imageview.translatesAutoresizingMaskIntoConstraints = false
            imageview.alpha = 0.0
            imageview.tintColor = color
            
            viewController.view.addSubview(imageview)
            
            // centerY = centerY
            let centerY = NSLayoutConstraint.init(
                item: imageview,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: viewController.view,
                attribute: .centerY,
                multiplier: 1.0,
                constant: 0.0)
            centerY.isActive = true
            
            // centerX = centerX
            let centerX = NSLayoutConstraint.init(
                item: imageview,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: viewController.view,
                attribute: .centerX,
                multiplier: 1.0,
                constant: 0.0)
            centerX.isActive = true
            
            // width = 100
            let widthConstraint = NSLayoutConstraint.init(
                item: imageview,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1.0,
                constant: 100.0)
            widthConstraint.isActive = true
            
            // height = 100
            let heightConstraint = NSLayoutConstraint.init(
                item: imageview,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1.0,
                constant: 100.0)
            heightConstraint.isActive = true
        }
    }
    
    
    func start(completion: (() -> ())?) {
        imageview.alpha = 1.0
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: animationOptions) {
                self.imageview.alpha = 0.0
                
            } completion: { isDone in
                if isDone {
                    completion?()
                }
            }
    }
    
    enum PopUpSyle: String {
        case check = "checkmark.circle"
        case multiply = "multiply.circle"
        case circle = "circle"
    }
}
