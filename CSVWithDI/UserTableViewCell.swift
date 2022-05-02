//
//  UserTableViewCell.swift
//  CSVWithDI
//
//  Created by C879403 on 29/04/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    fileprivate let  cellAutoLayoutConstant = 16.0
    
    fileprivate let userFullName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = .label
        name.numberOfLines = defaultZeroValue
        name.adjustsFontForContentSizeCategory = true
        name.font = UIFont.preferredFont(forTextStyle: .headline)
        return name
    }()
    
    fileprivate let issueCount: UILabel = {
        let issue = UILabel()
        issue.translatesAutoresizingMaskIntoConstraints = false
        issue.textColor = .label
        issue.numberOfLines = defaultZeroValue
        issue.adjustsFontForContentSizeCategory = true
        issue.font = UIFont.preferredFont(forTextStyle: .body)
        return issue
    }()
    
    fileprivate let userDOB: UILabel = {
        let dob = UILabel()
        dob.translatesAutoresizingMaskIntoConstraints = false
        dob.textColor = .label
        dob.numberOfLines = defaultZeroValue
        dob.adjustsFontForContentSizeCategory = true
        dob.font = UIFont.preferredFont(forTextStyle: .body)
        return dob
    }()
    
    var userInfoViewModel: UserDataViewModel? {
        didSet{
            userFullName.text = userInfoViewModel?.fullName
            issueCount.text = userInfoViewModel?.issueCount
            userDOB.text = userInfoViewModel?.dob
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(userFullName)
        addSubview(issueCount)
        addSubview(userDOB)
        setUpAutoLayOut()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpAutoLayOut() {
        let constraints = [userFullName.topAnchor.constraint(equalTo: topAnchor, constant: cellAutoLayoutConstant),
                           userFullName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: cellAutoLayoutConstant),
                           userFullName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -cellAutoLayoutConstant),
                           issueCount.topAnchor.constraint(equalTo: userFullName.bottomAnchor, constant: cellAutoLayoutConstant),
                           issueCount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: cellAutoLayoutConstant),
                           issueCount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -cellAutoLayoutConstant),
                           userDOB.topAnchor.constraint(equalTo: issueCount.bottomAnchor, constant: cellAutoLayoutConstant),
                           userDOB.leadingAnchor.constraint(equalTo: leadingAnchor, constant: cellAutoLayoutConstant),
                           userDOB.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -cellAutoLayoutConstant),
                           userDOB.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -cellAutoLayoutConstant)]
        NSLayoutConstraint.activate(constraints)
    }

}
