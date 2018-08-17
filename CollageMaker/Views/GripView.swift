//
//Copyright © 2018 Dimasno1. All rights reserved. Product:  CollageMaker
//

import UIKit

class GripView: UIView {
    
    init(with position: GripPosition, in cellView: CollageCellView) {
        self.position = position
        self.associatedCellView = cellView
        super.init(frame: .zero)
        
        backgroundColor = .darkGray
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented ")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        let verticalSize = CGSize(width: 5, height: associatedCellView.frame.height / 3)
        let horizontalSize = CGSize(width: associatedCellView.frame.width / 3, height: 5)
        
        switch position {
        case .left:
            center = CGPoint(x: associatedCellView.frame.minX, y: associatedCellView.frame.midY)
            bounds.size = verticalSize
        case .right:
            center = CGPoint(x: associatedCellView.frame.maxX, y: associatedCellView.frame.midY)
            bounds.size = verticalSize
        case .top:
            center = CGPoint(x: associatedCellView.frame.midX, y: associatedCellView.frame.minY)
            bounds.size = horizontalSize
        case .bottom:
            center = CGPoint(x: associatedCellView.frame.midX, y: associatedCellView.frame.maxY)
            bounds.size = horizontalSize
        }
        
        layer.cornerRadius = min(frame.height, frame.width) / 2
    }
    
    private(set) var position: GripPosition
    private var associatedCellView: CollageCellView
}