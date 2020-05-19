//
//  CardContainerView.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/26/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import UIKit

@IBDesignable
final class CardContainerView: UIView {
    
    // MARK: - Inspectable
    
    @IBInspectable var cornerRadius: CGFloat = Layout.View.cornerRadius {
        didSet {
            setupCorners()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = Layout.Shadow.color {
        didSet {
            setupShadow()
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupCorners()
        setupShadow()
    }
    
    private func setupCorners() {
        layer.cornerRadius = cornerRadius
    }
    
    private func setupShadow() {
        layer.shadowOffset = Layout.Shadow.offset
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = Layout.Shadow.opacity
        layer.shadowRadius = Layout.Shadow.radius
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCorners()
    }
    
    private enum Layout {
        enum View {
            static let cornerRadius: CGFloat = 6
        }
        enum Shadow {
            static let offset = CGSize(width: 2, height: 2)
            static let opacity: Float = 0.5
            static let radius: CGFloat = 4
            static let color = UIColor.shadow
        }
    }
}
