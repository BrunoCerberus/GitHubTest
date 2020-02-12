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
        if #available(iOS 13.0, *) {
            loader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        } else {
            loader = UIActivityIndicatorView(style: .gray)
        }
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
