//
//  ActivityManager.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation
import UIKit

class ActivityManager {
    static let shared = ActivityManager()

    var loader: UIActivityIndicatorView?

    func showLoader(view: UIView) {
        hideLoader()
        loader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        loader?.color = .imActivityIndicator
        view.addSubview(loader!)
        view.alpha = 0.5
        loader?.startAnimating()
    }

    func hideLoader() {
        loader?.stopAnimating()
        loader?.removeFromSuperview()
    }
}
