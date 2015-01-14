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
    
    weak var formViewController: FormViewController!
    
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
    
    func firstResponderElement() -> UIResponder? {
        /// override
        return nil
    }
    
    func inputAccesoryView() -> UIToolbar {
        
        let actionBar = UIToolbar()
        actionBar.translucent = true
        actionBar.sizeToFit()
        actionBar.barStyle = .Default
        
//        let prevNext = UISegmentedControl(items: [NSLocalizedString("Previous", comment: ""), NSLocalizedString("Next", comment: "")])
//        prevNext.momentary = true
//        prevNext.tintColor = actionBar.tintColor
//        prevNext.addTarget(self, action: "handleActionBarPreviousNext:", forControlEvents: .ValueChanged)
        
        let doneButton = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .Done, target: self, action: "handleDoneAction:")
        
//        let prevNextWrapper = UIBarButtonItem(customView: prevNext)
        let flexible = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        actionBar.items = [/*prevNextWrapper, */ flexible, doneButton]
        
        return actionBar
    }
    
    func handleActionBarPreviousNext(segmentedControl: UISegmentedControl) {
        
    }
    
    func handleDoneAction(_: UIBarButtonItem) {
        firstResponderElement()?.resignFirstResponder()
    }
    
    class func formRowCellHeight() -> CGFloat {
        return 44.0
    }
    
    class func formRowCanBecomeFirstResponder() -> Bool {
        return false
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
        
        var visualConstraints: NSArray!
        
        if let visualConstraintsClosure = rowDescriptor.configuration[FormRowDescriptor.Configuration.VisualConstraintsClosure] as? VisualConstraintsClosure {
            visualConstraints = visualConstraintsClosure(self)
        }
        else {
            visualConstraints = self.defaultVisualConstraints()
        }
        
        for visualConstraint in visualConstraints {
            let constraints = NSLayoutConstraint.constraintsWithVisualFormat(visualConstraint as String, options: NSLayoutFormatOptions(0), metrics: nil, views: views)
            for constraint in constraints {
                customConstraints.append(constraint)
            }
        }
        
        contentView.addConstraints(customConstraints)
        super.updateConstraints()
    }
}
