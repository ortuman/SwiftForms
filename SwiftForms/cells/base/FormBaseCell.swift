//
//  FormBaseCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormBaseCell: UITableViewCell {

    /// MARK: Properties
    
    public var rowDescriptor: FormRowDescriptor! {
        didSet {
            self.update()
        }
    }
    
    public weak var formViewController: FormViewController!
    
    private var customConstraints: [NSLayoutConstraint] = []
    
    /// MARK: Init
    
    public required override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// MARK: Public interface
    
    public func configure() {
        /// override
    }
    
    public func update() {
        /// override
    }
    
    public func defaultVisualConstraints() -> [String] {
        /// override
        return []
    }
    
    public func constraintsViews() -> [String : UIView] {
        /// override
        return [:]
    }
    
    public func firstResponderElement() -> UIResponder? {
        /// override
        return nil
    }
    
    public func inputAccesoryView() -> UIToolbar {
        
        let actionBar = UIToolbar()
        actionBar.translucent = true
        actionBar.sizeToFit()
        actionBar.barStyle = .Default
        
        let doneButton = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .Done, target: self, action: "handleDoneAction:")
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        actionBar.items = [flexible, doneButton]
        
        return actionBar
    }
    
    internal func handleDoneAction(_: UIBarButtonItem) {
        firstResponderElement()?.resignFirstResponder()
    }
    
    public class func formRowCellHeight() -> CGFloat {
        return 44.0
    }
    
    public class func formRowCanBecomeFirstResponder() -> Bool {
        return false
    }
    
    public class func formViewController(formViewController: FormViewController, didSelectRow: FormBaseCell) {
    }
    
    /// MARK: Constraints
    
    public override func updateConstraints() {
        
        if customConstraints.count > 0 {
            contentView.removeConstraints(customConstraints)
        }
        
        let views = constraintsViews()
        
        customConstraints.removeAll()
        
        var visualConstraints: NSArray!
        
        if let visualConstraintsClosure = rowDescriptor.configuration[FormRowDescriptor.Configuration.VisualConstraintsClosure] as? VisualConstraintsClosure {
            visualConstraints = visualConstraintsClosure(self)
        }
        else {
            visualConstraints = self.defaultVisualConstraints()
        }
        
        for visualConstraint in visualConstraints {
            let constraints = NSLayoutConstraint.constraintsWithVisualFormat(visualConstraint as! String, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
            for constraint in constraints {
                customConstraints.append(constraint)
            }
        }
        
        contentView.addConstraints(customConstraints)
        super.updateConstraints()
    }
}
