//
//  HUD.swift
//  SkyApp
//
//  Created by Bruno Lopes on 31/08/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import UIKit

public final class HUD {
    // MARK: Public methods, ModalHUD based
    public static func show(_ view: UIView? = nil) {
        DispatchQueue.main.async {
            IMHUD.sharedHUD.dimsBackground = true
            IMHUD.sharedHUD.contentView = ModalHUDSystemActivityIndicatorView()
            IMHUD.sharedHUD.show(onView: view)
        }
    }
    
    public static func hide(afterDelay delay: TimeInterval, completion: ((Bool) -> Void)? = nil) {
        DispatchQueue.main.async {
            IMHUD.sharedHUD.hide(afterDelay: delay, completion: completion)
        }
    }
}

/// The ModalHUD object controls showing and hiding of the HUD, as well as its contents and touch response behavior.
private class IMHUD: NSObject {
    fileprivate struct Constants {
        static let sharedHUD = IMHUD()
    }
    public var viewToPresentOn: UIView?
    fileprivate let container = ContainerView()
    fileprivate var hideTimer: Timer?
    public typealias TimerAction = (Bool) -> Void
    fileprivate var timerActions = [String: TimerAction]()
    public var gracePeriod: TimeInterval = 0
    fileprivate var graceTimer: Timer?
    
    // MARK: Public
    open class var sharedHUD: IMHUD {
        return Constants.sharedHUD
    }
    
    public override init () {
        super.init()
        
        #if swift(>=4.2)
        let notificationName = UIApplication.willEnterForegroundNotification
        #else
        let notificationName = NSNotification.Name.UIApplicationWillEnterForeground
        #endif
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(IMHUD.willEnterForeground(_:)),
                                               name: notificationName,
                                               object: nil)
        userInteractionOnUnderlyingViewsEnabled = false
        container.frameView.autoresizingMask = [ .flexibleLeftMargin,
                                                 .flexibleRightMargin,
                                                 .flexibleTopMargin,
                                                 .flexibleBottomMargin ]
        
        self.container.isAccessibilityElement = true
        self.container.accessibilityIdentifier = "ModalHUD"
    }
    
    public convenience init(viewToPresentOn view: UIView) {
        self.init()
        viewToPresentOn = view
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    open var dimsBackground = true
    open var userInteractionOnUnderlyingViewsEnabled: Bool {
        get {
            return !container.isUserInteractionEnabled
        }
        set {
            container.isUserInteractionEnabled = !newValue
        }
    }
    open var isVisible: Bool {
        return !container.isHidden
    }
    open var contentView: UIView {
        get {
            return container.frameView.content
        }
        set {
            container.frameView.content = newValue
            startAnimatingContentView()
        }
    }
    open var leadingMargin: CGFloat = 0
    open var trailingMargin: CGFloat = 0
    
    open func show(onView view: UIView? = nil) {
        let view: UIView = view ?? viewToPresentOn ?? UIApplication.shared.keyWindow!
        if  !view.subviews.contains(container) {
            view.addSubview(container)
            container.frame.origin = CGPoint.zero
            container.frame.size = view.frame.size
            container.autoresizingMask = [ .flexibleHeight, .flexibleWidth ]
            container.isHidden = true
        }
        if dimsBackground {
            container.showBackground(animated: true)
        }
        
        // If the grace time is set, postpone the HUD display
        if gracePeriod > 0.0 {
            let timer = Timer(timeInterval: gracePeriod,
                              target: self,
                              selector: #selector(IMHUD.handleGraceTimer(_:)), userInfo: nil, repeats: false)
            #if swift(>=4.2)
            RunLoop.current.add(timer, forMode: .common)
            #else
            RunLoop.current.add(timer, forMode: .commonModes)
            #endif
            graceTimer = timer
        } else {
            showContent()
        }
    }
    
    func showContent() {
        graceTimer?.invalidate()
        container.showFrameView()
        startAnimatingContentView()
    }
    
    open func hide(animated anim: Bool = true, completion: TimerAction? = nil) {
        graceTimer?.invalidate()
        container.hideFrameView(animated: anim, completion: completion)
        stopAnimatingContentView()
    }
    
    open func hide(_ animated: Bool, completion: TimerAction? = nil) {
        hide(animated: animated, completion: completion)
    }
    
    open func hide(afterDelay delay: TimeInterval, completion: TimerAction? = nil) {
        let key = UUID().uuidString
        let userInfo = ["timerActionKey": key]
        if let completion = completion {
            timerActions[key] = completion
        }
        hideTimer?.invalidate()
        hideTimer = Timer.scheduledTimer(timeInterval: delay,
                                         target: self,
                                         selector: #selector(IMHUD.performDelayedHide(_:)),
                                         userInfo: userInfo,
                                         repeats: false)
    }
    
    // MARK: Internal
    @objc internal func willEnterForeground(_ notification: Notification?) {
        self.startAnimatingContentView()
    }
    
    internal func startAnimatingContentView() {
        if let animatingContentView = contentView as? ModalHUDAnimating, isVisible {
            animatingContentView.startAnimation()
        }
    }
    
    internal func stopAnimatingContentView() {
        if let animatingContentView = contentView as? ModalHUDAnimating {
            animatingContentView.stopAnimation?()
        }
    }
    
    // MARK: Timer callbacks
    @objc internal func performDelayedHide(_ timer: Timer? = nil) {
        let userInfo = timer?.userInfo as? [String: AnyObject]
        let key = userInfo?["timerActionKey"] as? String
        var completion: TimerAction?
        if let key = key, let action = timerActions[key] {
            completion = action
            timerActions[key] = nil
        }
        hide(animated: true, completion: completion)
    }
    
    @objc internal func handleGraceTimer(_ timer: Timer? = nil) {
        // Show the HUD only if the task is still running
        if (graceTimer?.isValid)! { showContent() }
    }
}

/// The window used to display the ModalHUD within. Placed atop the applications main window.
private class ContainerView: UIView {
    internal let frameView: FrameView
    internal init(frameView: FrameView = FrameView()) {
        self.frameView = frameView
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        frameView = FrameView()
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        backgroundColor = UIColor.clear
        isHidden = true
        addSubview(backgroundView)
        addSubview(frameView)
    }
    
    internal override func layoutSubviews() {
        super.layoutSubviews()
        frameView.center = calculateHudCenter()
        backgroundView.frame = bounds
    }
    
    internal func showFrameView() {
        layer.removeAllAnimations()
        frameView.center = calculateHudCenter()
        frameView.alpha = 0.9
        isHidden = false
    }
    
    fileprivate var willHide = false
    
    internal func hideFrameView(animated anim: Bool, completion: ((Bool) -> Void)? = nil) {
        let finalize: (_ finished: Bool) -> Void = { finished in
            self.isHidden = true
            self.removeFromSuperview()
            self.willHide = false
            completion?(finished)
        }
        
        if isHidden { return }
        
        willHide = true
        
        if anim {
            UIView.animate(withDuration: 0.8, animations: {
                self.frameView.alpha = 0.0
                self.hideBackground(animated: false)
            }, completion: { _ in finalize(true) })
        } else {
            self.frameView.alpha = 0.0
            finalize(true)
        }
    }
    
    fileprivate let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.16, green: 0.18, blue: 0.26, alpha: 1)
        view.alpha = 0
        return view
    }()
    
    internal func showBackground(animated anim: Bool) {
        if anim {
            UIView.animate(withDuration: 0.375, animations: {
                self.backgroundView.alpha = 0.9
            })
        } else {
            backgroundView.alpha = 0.9
        }
    }
    
    internal func hideBackground(animated anim: Bool) {
        if anim {
            UIView.animate(withDuration: 0.65, animations: {
                self.backgroundView.alpha = 0.0
            })
        } else {
            backgroundView.alpha = 0.0
        }
    }
    
    // MARK: - Helpers
    private func animateHUDWith(duration: Double, curve: UIView.AnimationCurve, toLocation location: CGPoint) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(TimeInterval(duration))
        UIView.setAnimationCurve(curve)
        frameView.center = location
        UIView.commitAnimations()
    }
    
    private func calculateHudCenter() -> CGPoint {
        return center
    }
}

/// Provides the general look and feel of the ModalHUD, into which the eventual content is inserted.
private class FrameView: UIView {
    internal init() {
        super.init(frame: CGRect.zero)
        DispatchQueue.main.async {
            self.commonInit()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        DispatchQueue.main.async {
            self.commonInit()
        }
    }
    
    private func commonInit() {
        backgroundColor = UIColor.clear
        layer.cornerRadius = 9.0
        layer.masksToBounds = true
        addSubview(content)
    }
    
    private var _content = UIView()
    internal var content: UIView {
        get {
            return _content
        }
        set {
            _content.removeFromSuperview()
            _content = newValue
            _content.alpha = 1
            _content.clipsToBounds = true
            _content.contentMode = .center
            frame.size = _content.bounds.size
            addSubview(_content)
        }
    }
}

/// ModalHUDSystemActivityIndicatorView provides the system UIActivityIndicatorView as an alternative.
fileprivate final class ModalHUDSystemActivityIndicatorView: ModalHUDSquareBaseView, ModalHUDAnimating {
    public init() {
        super.init(frame: ModalHUDSquareBaseView.defaultSquareBaseViewFrame)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit () {
        backgroundColor = UIColor.clear
        alpha = 0
        self.addSubview(activityIndicatorView)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView.center = self.center
    }
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.color = UIColor.white
        return activity
    }()
    
    public func startAnimation() {
        activityIndicatorView.startAnimating()
    }
}

/// ModalHUDSquareBaseView provides a square view, which you can subclass and add additional views to.
private class ModalHUDSquareBaseView: UIView {
    static let defaultSquareBaseViewFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: 156.0, height: 156.0))
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(image: UIImage? = nil, title: String? = nil, subtitle: String? = nil) {
        super.init(frame: ModalHUDSquareBaseView.defaultSquareBaseViewFrame)
        self.imageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0.85
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        return imageView
    }()
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.textColor = UIColor.black.withAlphaComponent(0.85)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        return label
    }()
    
    public let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        return label
    }()
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let margin: CGFloat = IMHUD.sharedHUD.leadingMargin + IMHUD.sharedHUD.trailingMargin
        let originX: CGFloat = margin > 0 ? margin : 0.0
        let viewWidth = bounds.size.width - 2 * margin
        let viewHeight = bounds.size.height
        let halfHeight = CGFloat(ceilf(CFloat(viewHeight / 2.0)))
        let quarterHeight = CGFloat(ceilf(CFloat(viewHeight / 4.0)))
        let threeQuarterHeight = CGFloat(ceilf(CFloat(viewHeight / 4.0 * 3.0)))
        titleLabel.frame = CGRect(origin: CGPoint(x: originX, y: 0.0),
                                  size: CGSize(width: viewWidth, height: quarterHeight))
        imageView.frame = CGRect(origin: CGPoint(x: originX, y: quarterHeight),
                                 size: CGSize(width: viewWidth, height: halfHeight))
        subtitleLabel.frame = CGRect(origin: CGPoint(x: originX, y: threeQuarterHeight),
                                     size: CGSize(width: viewWidth, height: quarterHeight))
        
    }
}

@objc private protocol ModalHUDAnimating {
    func startAnimation()
    @objc optional func stopAnimation()
}
