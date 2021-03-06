// 
// Copyright 2020 New Vector Ltd
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

enum SelectionMode {
    case Single
    case Multiple
}

class SelectableFilteredSearchController<T: Equatable> : UITableViewController, FilteredTableViewSource {
    
    var selected: [T] = []
    private var selectionDidChange: ((_ item: T, _ added: Bool) -> Void)
    private var scrollViewDidScroll: (() -> Void)!
    let session: MXSession
    var mode: SelectionMode = .Multiple
    
    init (withSelectionChangeHandler selectionChanged: @escaping ((_ item: T, _ added: Bool) -> Void), andScrollHandler scrollViewDidScroll: @escaping (() -> Void)) {
        selectionDidChange = selectionChanged
        session = (AppDelegate.theDelegate().mxSessions.first as? MXSession)!
        self.scrollViewDidScroll = scrollViewDidScroll
        super.init(style: .plain)
    }
    
    convenience init() {
        self.init(withSelectionChangeHandler: {(_, _) in
            
        }, andScrollHandler: {})
    }
    
    init?(Coder: NSCoder) {
        selectionDidChange = {(_, _) in
            
        }
        session = (AppDelegate.theDelegate().mxSessions.first as? MXSession)!
        super.init(coder: Coder)
    }
    
    required init?(coder: NSCoder) {
        selectionDidChange = {(_, _) in
            
        }
        session = (AppDelegate.theDelegate().mxSessions.first as? MXSession)!
        super.init(coder: coder)
    }
    
    static func nib() -> UINib! {
        UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    func registerReuseIdentifierForTableView(_ tableView: UITableView) {
        preconditionFailure("Override in deriving class")
    }
    
    var currentTheme: Theme!
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        registerReuseIdentifierForTableView(tableView)
        
        currentTheme = ThemeService.shared().theme
        if BuildSettings.settingsScreenOverrideDefaultThemeSelection != "" {
            currentTheme = ThemeService.shared().theme(withThemeId: BuildSettings.settingsScreenOverrideDefaultThemeSelection as String)
        }
        
        tableView.tintColor = currentTheme.textPrimaryColor
        tableView.backgroundColor = currentTheme.backgroundColor
    }
    
    func applyFilter(_ filter: String) {
        preconditionFailure("applyFilter must be overridden")
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = self.tableView(tableView, cellForRowAt: indexPath)
        guard let val = getUnderlyingValue(cell) else { return nil }
        if !selected.contains(where: {(x) in
            return x == val
        }) {
            if self.mode == .Multiple {
                selected.append(val)
                selectionDidChange(val, true)
            } else {
                selected = [val]
                selectionDidChange(val, true)
            }
        } else {
            selected.removeAll(where: {(x) in
                return x == val
            })
            selectionDidChange(val, false)
        }
        tableView.reloadRows(at: [indexPath], with: .fade)
        return nil
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = currentTheme.headerBackgroundColor
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = currentTheme.headerTextPrimaryColor
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDidScroll()
    }
    
    func getUnderlyingValue(_ tableViewCell: UITableViewCell) -> T? {
        preconditionFailure("getUnderlyingValue must be overridden")
    }
    
    func getTableviewCell(_ tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        preconditionFailure("getTableViewCell must be overridden")
    }
    
    func deselect(Item theItem: T) {
        selected.removeAll(where: {(x) in
            x == theItem
        })
        if let refreshLocation = getIndexPathFor(Item: theItem) {
            tableView.reloadRows(at: [refreshLocation], with: .fade)
        }
    }
    
    func getIndexPathFor(Item theItem: T) -> IndexPath? {
        preconditionFailure("Override in deriving class.")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = getTableviewCell(tableView, atIndexPath: indexPath)
        let data = getUnderlyingValue(cell)
        if selected.contains(where: {(e) in
            e == data
        }) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = currentTheme.selectedBackgroundColor
        return cell
    }
}
