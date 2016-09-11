//
//  UIImageView.swift
//  Dropshippers
//
//  Created by DARKNIGHT on 07/09/2016.
//  Copyright © 2016 DARKNIGHT. All rights reserved.
//

import UIKit

extension UIView{
    // MARK: Border
    
    /**
     The layer border color
     */
    @IBInspectable var borderColor: UIColor {
        get {
            return layer.borderColor == nil ? UIColor.clearColor() : UIColor(CGColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.CGColor
        }
    }
    
    /**
     The layer border width
     */
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    
    // MARK: Corner Radius
    
    /**
     The layer corner radius
     */
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    
    // MARK: Shadow
    
    /**
     The shadow color of the layer
     */
    @IBInspectable var shadowColor: UIColor {
        get {
            return layer.shadowColor == nil ? UIColor.clearColor() : UIColor(CGColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.CGColor
        }
    }
    
    
    /**
     The shadow offset of the layer
     */
    @IBInspectable var shadowOffset:CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    /**
     The shadow opacity of the layer
     
     - Returns: Float
     */
    @IBInspectable var shadowOpacity:Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    /**
     The shadow radius of the layer
     
     - Returns: CGFloat
     */
    @IBInspectable var shadowRadius:CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
}

