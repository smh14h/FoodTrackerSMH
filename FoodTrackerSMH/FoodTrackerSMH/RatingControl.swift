//
//  RatingControl.swift
//  FoodTrackerSMH
//
//  Created by Sean Halstead on 2/22/19.
//  Copyright © 2019 Sean Halstead. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {

    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Private Methods
    private func setupButtons() {
        // creat the button
        let Button = UIButton()
        Button.backgroundColor = UIColor.red
        
        // add constraints
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        Button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        // adds button to the stack
        addArrangedSubview(Button)
    }
}
