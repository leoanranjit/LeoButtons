//
//  LeoButtons.swift
//  LeoButtons
//
//  Created by Leoan Ranjit on 5/13/22.
//

import Foundation
import UIKit

enum Color {
    case black,white
}
enum Direction : String {
    case inward = "inward"
    case outward = "outward"
}

public class LeoButtons: UIButton {
    // MARK: - Constants and variables
    
    var btnTitle = ""
    var btnImage = UIImage()
    var isLoading = false
    var size = 0.97
    
    let view1 = UIView()
    let view2 = UIView()
    let view3 = UIView()
    let stackView = UIStackView()
    
    @IBInspectable
    var animates : Bool{
        get{
            return self.animates
        }
        set{
            if newValue{
                setupAnimation()
            }
        }
    }
    
    @IBInspectable
    var expandSize: CGFloat{
        get{
            return CGFloat(size)
        }
        set{
            self.size = Double(newValue)
        }
    }
    
    @IBInspectable
    var cornerRadius : CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
    @IBInspectable
    var borderWidth : CGFloat{
        get{
            return self.layer.borderWidth
        }
        set{
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable
    var borderColor : UIColor{
        get{
            return UIColor(cgColor: self.layer.borderColor ?? UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor)
        }
        set{
            self.layer.borderColor = newValue.cgColor
        }
    }
    @IBInspectable
    var shadowColor : UIColor{
        get{
            return UIColor(cgColor: self.layer.shadowColor ?? UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor)
        }
        set{
            self.layer.shadowColor = newValue.cgColor
        }
    }
    @IBInspectable
    var shadowOpacity : Float{
        get{
            return self.layer.shadowOpacity
        }
        set{
            self.layer.shadowOpacity = newValue
        }
    }
    @IBInspectable
    var shadowRadius : CGFloat{
        get{
            return self.layer.shadowRadius
        }
        set{
            self.layer.shadowRadius = newValue
        }
    }
    @IBInspectable
    var shadowOffset : CGSize{
        get{
            return self.layer.shadowOffset
        }
        set{
            self.layer.shadowOffset = newValue
        }
    }
    
    open var dotSize: CGFloat  = 6.0
    @IBInspectable
    var _dotSize : CGFloat = 6.0{
        didSet{
            dotSize = _dotSize
        }
    }
    
    open var dotOneColor : UIColor = .white
    @IBInspectable
    var _dotOneColor : UIColor = .white{
        didSet{
            dotOneColor = _dotOneColor
        }
    }
    
    open var dotTwoColor : UIColor = .white
    @IBInspectable
    var _dotTwoColor : UIColor = .white{
        didSet{
            dotTwoColor = _dotTwoColor
        }
    }
    
    open var dotThreeColor : UIColor = .white
    @IBInspectable
    var _dotThreeColor : UIColor = .white{
        didSet{
            dotThreeColor = _dotThreeColor
        }
    }
    
    open var spacing : CGFloat = 3
    @IBInspectable
    var _spacing : CGFloat = 3{
        didSet{
            spacing = _spacing
        }
    }
    
    open var duration : CGFloat = 0.4
    @IBInspectable
    var _duration : CGFloat = 0.4{
        didSet{
            duration = _duration
        }
    }
    
    open var translation : CGFloat = 4
    @IBInspectable
    var _translation : CGFloat = 4{
        didSet{
            translation = _translation
        }
    }
    
    // MARK: - ViewController Functions
    public override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.view1.layer.cornerRadius = self.view1.layer.frame.width/2
            self.view1.clipsToBounds = true
            self.view2.layer.cornerRadius = self.view2.layer.frame.width / 2
            self.view2.clipsToBounds = true
            self.view3.layer.cornerRadius = self.view3.layer.frame.width / 2
            self.view3.clipsToBounds = true
        }
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (bounds.width - (bounds.width / 2)) - 16)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
        }
    }
    
    // MARK: - Additional Functions
    public func startLoading(){
        self.isLoading = true
        self.btnTitle = self.title(for: .normal) ?? ""
        self.btnImage = self.image(for: .normal) ?? UIImage()
        self.isUserInteractionEnabled = false
        self.setTitle("", for: .normal)
        self.setImage(UIImage(), for: .normal)
        
        //View 1
        view1.backgroundColor = dotOneColor
        view1.heightAnchor.constraint(equalToConstant: dotSize).isActive = true
        view1.widthAnchor.constraint(equalToConstant: dotSize).isActive = true
        view1.alpha = 0
        
        //View 2
        view2.backgroundColor = dotTwoColor
        view2.heightAnchor.constraint(equalToConstant: dotSize).isActive = true
        view2.widthAnchor.constraint(equalToConstant: dotSize).isActive = true
        view2.alpha = 0
        
        //View 3
        view3.backgroundColor = dotThreeColor
        view3.heightAnchor.constraint(equalToConstant: dotSize).isActive = true
        view3.widthAnchor.constraint(equalToConstant: dotSize).isActive = true
        view3.alpha = 0
        
        //Stack View
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = spacing
        stackView.addArrangedSubview(view1)
        stackView.addArrangedSubview(view2)
        stackView.addArrangedSubview(view3)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        //Layout for Stack View
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.addSubview(self.stackView)
        
        //Animating Views
        UIView.animate(withDuration: 0.05) {
            self.view1.alpha = 1
        }
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: [.repeat, .autoreverse] , animations: {
            self.view1.transform = CGAffineTransform(translationX: 0, y: -self.translation/2)
            self.view1.transform = CGAffineTransform(translationX: 0, y: self.translation/2)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(duration/2)) {
            UIView.animate(withDuration: 0.1) {
                self.view2.alpha = 1
            }
            UIView.animate(withDuration: TimeInterval(self.duration), delay: 0, options: [.repeat, .autoreverse] , animations: {
                self.view2.transform = CGAffineTransform(translationX: 0, y: -self.translation/2)
                self.view2.transform = CGAffineTransform(translationX: 0, y: self.translation/2)
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(duration)) {
            UIView.animate(withDuration: 0.1) {
                self.view3.alpha = 1
            }
            UIView.animate(withDuration: TimeInterval(self.duration), delay: 0, options: [.repeat, .autoreverse] , animations: {
                self.view3.transform = CGAffineTransform(translationX: 0, y: -self.translation/2)
                self.view3.transform = CGAffineTransform(translationX: 0, y: self.translation/2)
            })
            
        }
    }
    
    public func stopLoading(){
        if isLoading{
            self.stackView.removeFromSuperview()
            self.isUserInteractionEnabled = true
            self.setTitle(btnTitle, for: .normal)
            self.setImage(btnImage, for: .normal)
        }
    }
    
    
    func setupAnimation(){
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    func applyGradient(colors: [CGColor])
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.bounds.height/2
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: CGFloat(size), y: CGFloat(size)))
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
    
    @objc private func animateUp(sender: UIButton) {
        animate(sender, transform: .identity)
    }
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        self.transform = CGAffineTransform(scaleX: CGFloat(size), y: CGFloat(size))
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: CGFloat(0.40), initialSpringVelocity: CGFloat(8.0), options: UIView.AnimationOptions.allowUserInteraction, animations: {
            button.transform = transform
        }, completion: { Void in()  }
        )
    }
}

extension UIViewController{
    
    func startLoading(color: UIColor) {
        if #available(iOS 13.0, *) {
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .medium)
            indicator.color = color
            indicator.startAnimating()
            let barButton = UIBarButtonItem(customView: indicator)
            self.navigationItem.setRightBarButton(barButton, animated: true)
        } else {
            // Fallback on earlier versions
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
            indicator.color = color
            indicator.startAnimating()
            let barButton = UIBarButtonItem(customView: indicator)
            self.navigationItem.setRightBarButton(barButton, animated: true)
        }
    }
    
    func stopLoading(){
        self.navigationItem.setRightBarButton(UIBarButtonItem(), animated: true)
    }
}


