//
//  UIView+Extension.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/17/20.
//

import UIKit

extension UIView {
    func fixInView(_ container: UIView) {
        self.frame = container.bounds
        container.addSubview(self)

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0),
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0)
        ])
    }
    
    func animateWithRippleEffect() {
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        let shapePosition = CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
        let rippleShape = CAShapeLayer()
        
        rippleShape.bounds = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        rippleShape.path = path.cgPath
        rippleShape.fillColor = UIColor.clear.cgColor
        rippleShape.strokeColor = UIColor.red.cgColor
        rippleShape.lineWidth = 2
        rippleShape.position = shapePosition
        rippleShape.opacity = 0
        self.layer.addSublayer(rippleShape)
        
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        scaleAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(2, 2, 1))
        
        let opacityAnim = CABasicAnimation(keyPath: "opacity")
        opacityAnim.fromValue = 1
        opacityAnim.toValue = nil
        
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnim, opacityAnim]
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.duration = CFTimeInterval(0.7)
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = true
        rippleShape.add(animation, forKey: "rippleEffect")
    }
}

@propertyWrapper
struct UsesAutoLayout<T> where T: UIView {
    var wrappedValue: T? {
        didSet {
            wrappedValue?.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
        wrappedValue?.translatesAutoresizingMaskIntoConstraints = false
    }
}
