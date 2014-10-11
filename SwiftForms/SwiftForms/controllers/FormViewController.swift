//
//  FormViewController.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuño on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

@objc protocol FormViewControllerDelegate: NSObjectProtocol {
    optional func formViewController(controller: FormViewController, didSelectRowDescriptor: FormRowDescriptor)
}

class FormViewController : UITableViewController {

    /// MARK: Types
    
    struct Static {
        static var onceDefaultCellClass: dispatch_once_t = 0
        static var defaultCellClasses: Dictionary<FormRowType, FormBaseCell.Type> = [:]
    }
    
    /// MARK: Properties
    
    var form: FormDescriptor!
    
    weak var delegate: FormViewControllerDelegate?
    
    /// MARK: Init
    
    override convenience init() {
        self.init(style: .Grouped)
    }
    
    convenience init(form: FormDescriptor) {
        self.init()
        self.form = form
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        baseInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseInit()
    }
    
    private func baseInit() {
    }
    
    /// MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = form.title
    }
    
    /// MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return form.sections.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return form.sections[section].rows.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let rowDescriptor = formRowDescriptorAtIndexPath(indexPath)
        
        var formBaseCellClass = formBaseCellClassFromRowDescriptor(rowDescriptor)
        
        let reuseIdentifier = NSStringFromClass(formBaseCellClass)
        
        var cell: FormBaseCell? = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as? FormBaseCell
        if cell == nil {
            
            cell = formBaseCellClass(style: rowDescriptor.cellStyle, reuseIdentifier: reuseIdentifier)
            cell?.configure()
        }
        
        cell?.rowDescriptor = rowDescriptor
        
        // apply cell custom design
        for (keyPath, value) in rowDescriptor.cellConfiguration {
            cell?.setValue(value, forKeyPath: keyPath)
        }
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return form.sections[section].headerTitle
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return form.sections[section].footerTitle
    }
    
    /// MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        let rowDescriptor = formRowDescriptorAtIndexPath(indexPath)
        
        if let formBaseCellClass = formBaseCellClassFromRowDescriptor(rowDescriptor) {
            return formBaseCellClass.formRowCellHeight()
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let rowDescriptor = formRowDescriptorAtIndexPath(indexPath)
        
        if let selectedRow = tableView.cellForRowAtIndexPath(indexPath) as? FormBaseCell {
            if let formBaseCellClass = formBaseCellClassFromRowDescriptor(rowDescriptor) {
                formBaseCellClass.formViewController(self, didSelectRow: selectedRow)
            }
        }
        
        delegate?.formViewController?(self, didSelectRowDescriptor: rowDescriptor)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    /// MARK: Private interface
    
    private class func isSelectionableRowDescriptor(rowType: FormRowType) -> Bool {
        switch( rowType ) {
        case .Button, .BooleanCheck, .Picker, .Date, .Time, .DateAndTime:
            return true
        default:
            return false
        }
    }
    
    private class func defaultCellClassForRowType(rowType: FormRowType) -> FormBaseCell.Type {
        dispatch_once(&Static.onceDefaultCellClass) {
            Static.defaultCellClasses[FormRowType.Text] = FormTextFieldCell.self
            Static.defaultCellClasses[FormRowType.Phone] = FormTextFieldCell.self
            Static.defaultCellClasses[FormRowType.URL] = FormTextFieldCell.self
            Static.defaultCellClasses[FormRowType.Email] = FormTextFieldCell.self
            Static.defaultCellClasses[FormRowType.Password] = FormTextFieldCell.self
            Static.defaultCellClasses[FormRowType.Button] = FormButtonCell.self
            Static.defaultCellClasses[FormRowType.BooleanSwitch] = FormSwitchCell.self
            Static.defaultCellClasses[FormRowType.BooleanCheck] = FormCheckCell.self
            Static.defaultCellClasses[FormRowType.SegmentedControl] = FormSegmentedControlCell.self
            Static.defaultCellClasses[FormRowType.Picker] = FormPickerCell.self
            Static.defaultCellClasses[FormRowType.Date] = FormDateCell.self
            Static.defaultCellClasses[FormRowType.Time] = FormDateCell.self
            Static.defaultCellClasses[FormRowType.DateAndTime] = FormDateCell.self
            Static.defaultCellClasses[FormRowType.MultipleSelector] = FormSelectorCell.self
        }
        return Static.defaultCellClasses[rowType]!
    }
    
    private func formRowDescriptorAtIndexPath(indexPath: NSIndexPath!) -> FormRowDescriptor {
        let section = form.sections[indexPath.section]
        let rowDescriptor = section.rows[indexPath.row]
        return rowDescriptor
    }
    
    private func formBaseCellClassFromRowDescriptor(rowDescriptor: FormRowDescriptor) -> FormBaseCell.Type! {
        
        var formBaseCellClass: FormBaseCell.Type!
        
        if rowDescriptor.cellClass == nil { // fallback to default cell class
            formBaseCellClass = FormViewController.defaultCellClassForRowType(rowDescriptor.rowType)
        }
        else {
            formBaseCellClass = rowDescriptor.cellClass as? FormBaseCell.Type
        }
        
        assert(formBaseCellClass != nil, "cellClass must be a FormBaseCell derived class value.")
        
        return formBaseCellClass
    }
}
