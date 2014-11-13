//
//  FormBaseCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormBaseCell: UITableViewCell {

    /// MARK: Properties
    
    var rowDescriptor: FormRowDescriptor! {
        didSet {
            self.update()
        }
    }
    
    private var customConstraints: [AnyObject] = []
    
    /// MARK: Init
    
    required override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// MARK: Public interface
    
    func configure() {
        /// override
    }
    
    func update() {
        /// override
    }
    
    func defaultVisualConstraints() -> [String] {
        /// override
        return []
    }
    
    func constraintsViews() -> [String : UIView] {
        /// override
        return [:]
    }
    
    class func formRowCellHeight() -> CGFloat {
        return 44.0
    }
    
    class func formViewController(formViewController: FormViewController, didSelectRow: FormBaseCell) {
    }
    
    /// MARK: Constraints
    
    override func updateConstraints() {
        
        if customConstraints.count > 0 {
            contentView.removeConstraints(customConstraints)
        }
        
        var views = constraintsViews()
        
        customConstraints.removeAll()
        
        var visualConstraints: [String]!
        
        if rowDescriptor.visualConstraintsBlock != nil {
            visualConstraints = rowDescriptor.visualConstraintsBlock(self)
        }
        else {
            visualConstraints = self.defaultVisualConstraints()
        }
        
        for visualConstraint in visualConstraints {
            let constraints = NSLayoutConstraint.constraintsWithVisualFormat(visualConstraint, options: NSLayoutFormatOptions(0), metrics: nil, views: views)
            for constraint in constraints {
                customConstraints.append(constraint)
            }
        }
        
        contentView.addConstraints(customConstraints)
        super.updateConstraints()
    }
}
