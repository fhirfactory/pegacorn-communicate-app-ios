//
//  RoleTableViewCell.swift
//  Riot
//
//  Created by Naurin Afrin on 2/8/20.
//  Copyright © 2020 matrix.org. All rights reserved.
//

import UIKit


protocol RoleCellDelegate: class, FavouriteActionReceiverDelegate {
    func expandButtonClick(cell: RoleTableViewCell, index: Int)
}

protocol SelectableRoleCellDelegate: class {
    func selectionChanged(cell: RoleTableViewCell, index: Int)
}


class RoleTableViewCell: UITableViewCell {
    //MARK: IBOutlets
    @IBOutlet weak var detailedView: UIView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactDescription: UILabel!
    @IBOutlet weak var RoleLabel: UILabel!
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var OrgUnitLabel: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var RoleIcon: MXKImageView!
    @IBOutlet weak var FavouriteButton: UIButton!
    @IBOutlet weak var VideoButton: UIButton!
    @IBOutlet weak var CallButton: UIButton!
    @IBOutlet weak var ChatButton: UIButton!
    @IBOutlet weak var RoleFilledLabel: UILabel!
    @IBOutlet weak var ActionContainer: UIView!
    @IBOutlet weak var SummaryView: UIStackView!
    
    var role: RoleModel?
    var roleSelectable: RoleSelectable?
    
    weak var delegate: RoleCellDelegate?
    weak var selectableDelegate: SelectableRoleCellDelegate?
    
    var index: Int = 0
    var isDisplayed = false {
        didSet {
            detailedView.isHidden = !isDisplayed
        }
    }
    
    var heightExpanded: CGFloat = 0
    var heightSummary: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        RoleIcon.layer.cornerRadius = RoleIcon.bounds.height / 2
        RoleIcon.clipsToBounds = true
        ThemeService.shared().theme.recursiveApply(on: contentView)
        VideoButton.setTitle(AlternateHomeTools.getNSLocalized("video", in: "Vector"), for: .normal)
        CallButton.setTitle(AlternateHomeTools.getNSLocalized("voice", in: "Vector"), for: .normal)
        ChatButton.setTitle(AlternateHomeTools.getNSLocalized("chat", in: "Vector"), for: .normal)
        layoutIfNeeded()
    }
    
    @IBAction private func expandButtonClick(_ sender: Any) {
        if isDisplayed {
            heightExpanded = frame.height
        } else {
            heightSummary = frame.height
        }
        if let delegate = delegate {
            delegate.expandButtonClick(cell: self, index: index)
        }
    }
    
    @IBAction private func FavouriteToggled(_ sender: Any) {
        if let theRole = role {
            theRole.Favourite = !theRole.Favourite
            if #available(iOS 13.0, *) {
                FavouriteButton.setImage(UIImage(systemName: (theRole.Favourite ? "star.fill" : "star")), for: .normal)
            }
            delegate?.FavouritesUpdated(favourited: theRole.Favourite)
        } else if let selectable = roleSelectable {
            selectable.isSelected = !selectable.isSelected
            if #available(iOS 13.0, *) {
                FavouriteButton.setImage(UIImage(systemName: (selectable.isSelected ? "xmark.circle" : "plus.circle")), for: .normal)
            }
            selectableDelegate?.selectionChanged(cell: self, index: index)
        }
    }
    
    private func roleCommon(role: Role) {
        contactName.text = role.Name
        contactDescription.text = role.OfficialName
        RoleIcon.image = AvatarGenerator.generateAvatar(forText: contactName.text)
        RoleLabel.text = String(format: AlternateHomeTools.getNSLocalized("role_detail_role", in: "Vector"), role.Title)
        CategoryLabel.text = String(format: AlternateHomeTools.getNSLocalized("role_detail_category", in: "Vector"), role.Category)
        OrgUnitLabel.text = String(format: AlternateHomeTools.getNSLocalized("role_detail_org_unit", in: "Vector"), role.OrgUnit)
        LocationLabel.text = String(format: AlternateHomeTools.getNSLocalized("role_detail_location", in: "Vector"), role.Location)
    }
    
    func setActionsHidden(to: Bool) {
        ChatButton.isHidden = to
        CallButton.isHidden = to
        VideoButton.isHidden = to
        RoleFilledLabel.isHidden = to
    }
    
    func bindModel(role: RoleSelectable, index: Int) {
        self.roleSelectable = role
        self.isDisplayed = role.isExpanded
        self.index = index
        setActionsHidden(to: true)
        
        roleCommon(role: role.innerRole)
        
        if #available(iOS 13.0, *) {
            FavouriteButton.setImage(UIImage(systemName: (role.isSelected ? "xmark.circle" : "plus.circle")), for: .normal)
        }
        
    }
    
    func bindModel(role: RoleModel, index: Int) {
        self.role = role
        self.isDisplayed = role.isExpanded
        self.index = index
        setActionsHidden(to: false)
        
        roleCommon(role: role.innerRole)
        
        if role.isFilled {
            RoleFilledLabel.text = AlternateHomeTools.getNSLocalized("filled", in: "Vector")
            RoleFilledLabel.textColor = ThemeService.shared().theme.tintColor
        } else {
            RoleFilledLabel.text = AlternateHomeTools.getNSLocalized("unfilled", in: "Vector")
            RoleFilledLabel.textColor = ThemeService.shared().theme.warningColor
        }
        
        if #available(iOS 13.0, *) {
            FavouriteButton.setImage(UIImage(systemName: (role.Favourite ? "star.fill" : "star")), for: .normal)
        }
    }
}
