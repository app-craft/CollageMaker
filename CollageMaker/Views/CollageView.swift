//
//Copyright © 2018 Dimasno1. All rights reserved. Product:  CollageMaker
//

import UIKit

protocol CollageViewDelegate: AnyObject {
    func collageView(_ collageView: CollageView, tapped point: CGPoint)
}

class CollageView: UIView {
    
    weak var delegate: CollageViewDelegate?
    
    init(collage: Collage, width: CGFloat = 0) {
        self.collage = collage
        self.cellViews = collage.cells.map(CollageCellView.init)
        
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: width, height: width)))
        
        cellViews.forEach { addSubview($0) }
        
        if let cell = cellViews.first(where: {$0.collageCell.id  == collage.selectedCell.id}) {
            setSelected(cellView: cell)
        }
        
        tapGestureRecognizer.addTarget(self, action: #selector(cellSelected(with:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellViews.forEach { $0.frame = $0.collageCell.relativePosition.absolutePosition(in: bounds) }
    }
    
    func setSelected(cellView: CollageCellView) {
        selectedCellView?.layer.borderColor = UIColor.white.cgColor
        selectedCellView = cellView
        selectedCellView?.layer.borderColor = UIColor.gray.cgColor
        
        showGrips()
    }
    
    private func showGrips() {
        gripViews.forEach { $0.removeFromSuperview() }
        gripViews = []
        
        selectedCellGripPositions?.forEach(layoutGripView(for: ))
    }
    
    private func layoutGripView(for position: GripPosition) {
        guard let selectedCellView = selectedCellView else {
            return
        }
        
        let gripView = GripView(with: position, in: selectedCellView)
        
        addSubview(gripView)
        gripViews.append(gripView)
    }
    
    @objc private func cellSelected(with recognizer: UITapGestureRecognizer) {
        let point = recognizer.location(in: self)
        
        delegate?.collageView(self, tapped: point)
    }
    
    private var selectedCellGripPositions: Set<GripPosition>? {
        return selectedCellView?.collageCell.gripPositions
    }
    
    private var collage: Collage
    private(set) var gripViews: [GripView] = []
    private(set) var cellViews: [CollageCellView]
    private var selectedCellView: CollageCellView?
    private var tapGestureRecognizer = UITapGestureRecognizer()
}
