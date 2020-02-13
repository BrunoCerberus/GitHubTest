//
//  Notifications.swift
//  GitHubTest
//
//  Created by Bruno on 12/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

private enum NotificationNames: String {
    case pullToRefresh
}

extension Notification.Name {
    static let pullToRefresh = Notification.Name(NotificationNames.pullToRefresh.rawValue)
}

extension Notification {
    static let pullToRefresh = Notification(name: .pullToRefresh)
}
