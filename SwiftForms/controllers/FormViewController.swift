//
//  FormViewController.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuño on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

open class FormViewController : UITableViewController {
    
    private static var __once: () = {
            FormViewController.defaultCellClasses[.text] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.label] = FormLabelCell.self
            FormViewController.defaultCellClasses[.number] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.numbersAndPunctuation] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.decimal] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.name] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.phone] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.url] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.twitter] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.namePhone] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.email] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.asciiCapable] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.password] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.button] = FormButtonCell.self
            FormViewController.defaultCellClasses[.booleanSwitch] = FormSwitchCell.self
            FormViewController.defaultCellClasses[.booleanCheck] = FormCheckCell.self
            FormViewController.defaultCellClasses[.segmentedControl] = FormSegmentedControlCell.self
            FormViewController.defaultCellClasses[.picker] = FormPickerCell.self
            FormViewController.defaultCellClasses[.date] = FormDateCell.self
            FormViewController.defaultCellClasses[.time] = FormDateCell.self
            FormViewController.defaultCellClasses[.dateAndTime] = FormDateCell.self
            FormViewController.defaultCellClasses[.stepper] = FormStepperCell.self
            FormViewController.defaultCellClasses[.slider] = FormSliderCell.self
            FormViewController.defaultCellClasses[.multipleSelector] = FormSelectorCell.self
            FormViewController.defaultCellClasses[.multilineText] = FormTextViewCell.self
        }()
    
    // MARK: Class variables
    
    fileprivate static var onceDefaultCellClass: Int = 0
    fileprivate static var defaultCellClasses: [FormRowDescriptor.RowType : FormBaseCell.Type] = [:]
    
    // MARK: Properties
    
    open var form = FormDescriptor()
    
    // MARK: Init
    
    public convenience init() {
        self.init(style: .grouped)
    }
    
    public convenience init(form: FormDescriptor) {
        self.init(style: .grouped)
        self.form = form
    }
    
    public override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: View life cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = form.title
    }
    
    // MARK: Public interface
    
    open func valueForTag(_ tag: String) -> AnyObject? {
        for section in form.sections {
            for row in section.rows {
                if row.tag == tag {
                    return row.value
                }
            }
        }
        return nil
    }
    
    open func setValue(_ value: AnyObject, forTag tag: String) {
        for (sectionIndex, section) in form.sections.enumerated() {
            for (rowIndex, row) in section.rows.enumerated() {
                if row.tag == tag {
                    form.sections[sectionIndex].rows[rowIndex].value = value
                    if let cell = self.tableView.cellForRow(at: IndexPath(row: rowIndex, section: sectionIndex)) as? FormBaseCell {
                        cell.update()
                    }
                    return
                }
            }
        }
    }
    
    // MARK: UITableViewDataSource
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return form.sections.count
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return form.sections[section].rows.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowDescriptor = formRowDescriptorAtIndexPath(indexPath)
        
        let formBaseCellClass = formBaseCellClassFromRowDescriptor(rowDescriptor)
        
        let reuseIdentifier = NSStringFromClass(formBaseCellClass!)
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? FormBaseCell
        if cell == nil {
            cell = formBaseCellClass?.init(style: .default, reuseIdentifier: reuseIdentifier)
            cell?.formViewController = self
            cell?.configure()
        }
        
        cell?.rowDescriptor = rowDescriptor
        
        // apply cell custom design
        for (keyPath, value) in rowDescriptor.configuration.cell.appearance {
            cell?.setValue(value, forKeyPath: keyPath)
        }
        return cell!
    }
    
    open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return form.sections[section].headerTitle
    }
    
    open override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return form.sections[section].footerTitle
    }
    
    open override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let headerView = form.sections[section].headerView else { return nil }
        return headerView
    }
    
    open override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let footerView = form.sections[section].footerView else { return nil }
        return footerView
    }
    
    open override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let headerView = form.sections[section].headerView , headerView.translatesAutoresizingMaskIntoConstraints else {
            return form.sections[section].headerViewHeight
        }
        return headerView.frame.size.height
    }
    
    open override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let footerView = form.sections[section].footerView , footerView.translatesAutoresizingMaskIntoConstraints else {
            return form.sections[section].footerViewHeight
        }
        return footerView.frame.size.height
    }
    
    // MARK: UITableViewDelegate
    
    open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let rowDescriptor = formRowDescriptorAtIndexPath(indexPath)
        
        if let formBaseCellClass = formBaseCellClassFromRowDescriptor(rowDescriptor) {
            return formBaseCellClass.formRowCellHeight()
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowDescriptor = formRowDescriptorAtIndexPath(indexPath)
        
        if let selectedRow = tableView.cellForRow(at: indexPath) as? FormBaseCell {
            if let formBaseCellClass = formBaseCellClassFromRowDescriptor(rowDescriptor) {
                formBaseCellClass.formViewController(self, didSelectRow: selectedRow)
            }
        }
        
        if let didSelectClosure = rowDescriptor.configuration.button.didSelectClosure {
            didSelectClosure(rowDescriptor)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    fileprivate class func defaultCellClassForRowType(_ rowType: FormRowDescriptor.RowType) -> FormBaseCell.Type {
        _ = FormViewController.__once
        return FormViewController.defaultCellClasses[rowType]!
    }
    
    fileprivate func formRowDescriptorAtIndexPath(_ indexPath: IndexPath) -> FormRowDescriptor {
    
        let section = form.sections[(indexPath as NSIndexPath).section]
        let rowDescriptor = section.rows[(indexPath as NSIndexPath).row]
        return rowDescriptor
    }
    
    fileprivate func formBaseCellClassFromRowDescriptor(_ rowDescriptor: FormRowDescriptor) -> FormBaseCell.Type! {
        
        var formBaseCellClass: FormBaseCell.Type
        
        if let cellClass = rowDescriptor.configuration.cell.cellClass as? FormBaseCell.Type {
            formBaseCellClass = cellClass
        } else {
            formBaseCellClass = FormViewController.defaultCellClassForRowType(rowDescriptor.type)
        }
        return formBaseCellClass
    }
}
