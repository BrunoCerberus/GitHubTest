//
//  Stepper.swift
//  GitHubTest
//
//  Created by Bruno on 7/18/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol Step {}

protocol Stepper: AnyObject {
    associatedtype ViewModelSteps: Step
    var selectedStep: BehaviorRelay<ViewModelSteps?> { get set }
}
