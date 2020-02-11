//
//  FilterButton.swift
//  GitHubTest
//
//  Created by Bruno on 11/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

@IBDesignable
final class FilterButton: UIButton {
    
    enum SelectedState {
        case selected
        case unselected
    }

    var fborderWidth: CGFloat = 1.0
    var fborderColor = UIColor.black.cgColor
    
    var selectedState: SelectedState = .unselected
    var selectedImage: UIImage = UIImage(named: "ICO_SELECTED")!

    @IBInspectable var titleText: String? {
        didSet {
            self.setTitle(titleText, for: .normal)
            self.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let title = titleText else { return }
        if UserDefaults.standard.bool(forKey: "\(title)-selected") {
            didSelect()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    func setup() {
        self.clipsToBounds = true
        self.layer.borderColor = fborderColor
        self.layer.borderWidth = fborderWidth
    }
    
    func didSelect() {
        if selectedState == .unselected {
            setImage(selectedImage, for: .normal)
            backgroundColor = .black
            setTitleColor(.white, for: .normal)
            selectedState = .selected
            guard let title = titleText else { return }
            UserDefaults.standard.set(true, forKey: "\(title)-selected")
        } else {
            removeImage()
        }
    }
    
    func removeImage() {
        setImage(nil, for: .normal)
        backgroundColor = .white
        setTitleColor(.black, for: .normal)
        selectedState = .unselected
        guard let title = titleText else { return }
        UserDefaults.standard.set(false, forKey: "\(title)-selected")
    }
}
