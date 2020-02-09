//
//  RepositoryModel.swift
//  GitHubTest
//
//  Created by bruno on 09/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

typealias Repository = [RepositoryElement]

// MARK: - RepositoryElement
struct RepositoryElement: IMCodable {
    let id: Int?
    let nodeID, name, fullName: String?
    let repositoryPrivate: Bool?
    let owner: Owner?
    let htmlURL: String?
    let repositoryDescription: String?
    let fork: Bool?
    let url: String?
    let forksURL: String?
    let keysURL, collaboratorsURL: String?
    let teamsURL, hooksURL: String?
    let issueEventsURL: String?
    let eventsURL: String?
    let assigneesURL, branchesURL: String?
    let tagsURL: String?
    let blobsURL, gitTagsURL, gitRefsURL, treesURL: String?
    let statusesURL: String?
    let languagesURL, stargazersURL, contributorsURL, subscribersURL: String?
    let subscriptionURL: String?
    let commitsURL, gitCommitsURL, commentsURL, issueCommentURL: String?
    let contentsURL, compareURL: String?
    let mergesURL: String?
    let archiveURL: String?
    let downloadsURL: String?
    let issuesURL, pullsURL, milestonesURL, notificationsURL: String?
    let labelsURL, releasesURL: String?
    let deploymentsURL: String?
    let createdAt, updatedAt, pushedAt: Date?
    let gitURL, sshURL: String?
    let cloneURL: String?
    let svnURL: String?
    let homepage: String?
    let size, stargazersCount, watchersCount: Int?
    let language: String?
    let hasIssues, hasProjects, hasDownloads, hasWiki: Bool?
    let hasPages: Bool?
    let forksCount: Int?
    let archived, disabled: Bool?
    let openIssuesCount: Int?
    let license: License?
    let forks, openIssues, watchers: Int?
    let defaultBranch: DefaultBranch?
    let permissions: Permissions?

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID
        case name
        case fullName
        case repositoryPrivate
        case owner
        case htmlURL
        case repositoryDescription
        case fork, url
        case forksURL
        case keysURL
        case collaboratorsURL
        case teamsURL
        case hooksURL
        case issueEventsURL
        case eventsURL
        case assigneesURL
        case branchesURL
        case tagsURL
        case blobsURL
        case gitTagsURL
        case gitRefsURL
        case treesURL
        case statusesURL
        case languagesURL
        case stargazersURL
        case contributorsURL
        case subscribersURL
        case subscriptionURL
        case commitsURL
        case gitCommitsURL
        case commentsURL
        case issueCommentURL
        case contentsURL
        case compareURL
        case mergesURL
        case archiveURL
        case downloadsURL
        case issuesURL
        case pullsURL
        case milestonesURL
        case notificationsURL
        case labelsURL
        case releasesURL
        case deploymentsURL
        case createdAt
        case updatedAt
        case pushedAt
        case gitURL
        case sshURL
        case cloneURL
        case svnURL
        case homepage, size
        case stargazersCount
        case watchersCount
        case language
        case hasIssues
        case hasProjects
        case hasDownloads
        case hasWiki
        case hasPages
        case forksCount
        case archived, disabled
        case openIssuesCount
        case license, forks
        case openIssues
        case watchers
        case defaultBranch
        case permissions
    }
}

enum DefaultBranch: String, Codable {
    case master = "master"
    case the4Stable = "4-stable"
}

// MARK: - License
struct License: IMCodable {
    let key, name, spdxID: String?
    let url: String?
    let nodeID: String?

    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID
        case url
        case nodeID
    }
}

// MARK: - Owner
struct Owner: IMCodable {
    let id: Int?
    let avatarURL: String?
    let gravatarID: String?
    let url, htmlURL, followersURL: String?
    let subscriptionsURL, organizationsURL, reposURL: String?
    let receivedEventsURL: String?
    let siteAdmin: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case avatarURL
        case gravatarID
        case url
        case htmlURL
        case followersURL
        case subscriptionsURL
        case organizationsURL
        case reposURL
        case receivedEventsURL
        case siteAdmin
    }
}

// MARK: - Permissions
struct Permissions: IMCodable {
    let admin, push, pull: Bool?
}
