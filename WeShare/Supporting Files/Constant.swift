//
//  Constant.swift
//  WeShare
//
//  Created by Emmanuel George on 16/09/22.
//

import Foundation
struct K {
    static let appName =  "WeShare"
    static let userDefaultKey = "isUserLoggedIn"
    static let cfBundleKey = "CFBundleVersion"
    static let dashboardCellId = "Cell"
    static let cellNibName = "MessageCell"
    static let detailedCellId = "CommentsTableViewCell"
    static let postCommentCellID = "PostCommentTableViewCell"

    struct ImageName {
        static let appIcon = "WeShare"
        static let closedEyeIcon = "eye.slash.fill"
        static let openedEyeIcon = "eye.fill"
        static let postButtonIcon = "square.and.pencil"
        static let deleteIcon = "trash.fill"
    }
    
    struct NavigationId {
        static let homeSegue = "HomeNVC"
        static let dashboardStoryboardId = "dashboardVc"
        static let registerSegue = "registerToDashboard"
        static let loginSegue = "loginToDashboard"
        static let detailedTableSegue = "showDetails"
    }
}
