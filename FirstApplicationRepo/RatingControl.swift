//
//  RatingControl.swift
//  FirstApplicationRepo
//
//  Created by Srinivasa Ravi Teja Peri on 7/14/19.
//  Copyright © 2019 HarshaRaviGitHub. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private var ratingButtons = [UIButton]();
    var rating = 0 {
        didSet {
            updateButtonSelectionStates();
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
        didSet{
            setupButtons();
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons();
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupButtons();
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder);
        setupButtons();
    }
    
    private func updateButtonSelectionStates (){
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating;
            
            let hintString: String?
            if rating == index+1 {
                hintString = "Tap to reset the rating to zero."
            }
            else {
                hintString = nil
            }
            
            let valueString: String
            switch(rating){
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set"
            default:
                valueString = "\(rating) stars set"
            }
            
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }

    @objc func ratingButtonTapped(button: UIButton) {
        print("Button Pressed :)");
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button \(button), is not in the rating Buttons array");
        }
        
        let selectedRating = index + 1;
        
        if (selectedRating == rating) {
            rating = 0;
        }
        else
        {
            rating = selectedRating;
        }
    }
    
    private func setupButtons()
    {
        
        for button in ratingButtons{
            removeArrangedSubview(button);
            button.removeFromSuperview();
        }
        
        ratingButtons.removeAll();
        
        let bundle = Bundle(for: type(of:self));
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<5{
            let button = UIButton();
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            button.translatesAutoresizingMaskIntoConstraints = false;
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true;
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true;
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside);
            
            self.addArrangedSubview(button);
            
            ratingButtons.append(button);
        }
        
        updateButtonSelectionStates();
    }
}
