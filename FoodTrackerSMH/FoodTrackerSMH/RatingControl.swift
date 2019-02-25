//
//  RatingControl.swift
//  FoodTrackerSMH
//
//  Created by Sean Halstead on 2/22/19.
//  Copyright © 2019 Sean Halstead. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) { didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 { didSet {
            setupButtons()
        }
    }

    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button Action
    @objc func ratingButtonTapped(Button: UIButton){
        guard let index = ratingButtons.index(of: Button) else {
            fatalError("The button, \(Button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
    
    //MARK: Private Methods
    private func setupButtons() {
        
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<starCount {
            // creat the button
            let Button = UIButton()
            
            // Set the button images
            Button.setImage(emptyStar, for: .normal)
            Button.setImage(filledStar, for: .selected)
            Button.setImage(highlightedStar, for: .highlighted)
            Button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // add constraints
            Button.translatesAutoresizingMaskIntoConstraints = false
            Button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
            Button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
            
            // Set the accessibility label
            Button.accessibilityLabel = "Set \(index + 1) star rating"
            
            //setup Button action
            Button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(Button:)), for: .touchUpInside)
            
            // adds button to the stack
            addArrangedSubview(Button)
            
            // Add the new button to the rating button array
            ratingButtons.append(Button)
        }
        
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        for (index, Button) in ratingButtons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected.
            Button.isSelected = index < rating
            
            // Set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            // Calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
            
            // Assign the hint string and value string
            Button.accessibilityHint = hintString
            Button.accessibilityValue = valueString
        }
    }
}
