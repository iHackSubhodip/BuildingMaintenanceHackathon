//
//  ImageAvatar.swift
//  BuildingMaintenance
//
//  Created by Banerjee, Subhodip on 26/07/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class OutgoingAvatar:NSObject, JSQMessageAvatarImageDataSource {
    func avatarImage() -> UIImage! {
        return #imageLiteral(resourceName: "bot_image")
    }
    func avatarHighlightedImage() -> UIImage! {
        return #imageLiteral(resourceName: "bot_image")
    }
    func avatarPlaceholderImage() -> UIImage! {
        return #imageLiteral(resourceName: "bot_image")
    }
}

class IncomingAvatar:NSObject, JSQMessageAvatarImageDataSource {
    func avatarImage() -> UIImage! {
        return #imageLiteral(resourceName: "user_image")
    }
    func avatarHighlightedImage() -> UIImage! {
        return #imageLiteral(resourceName: "user_image")
    }
    func avatarPlaceholderImage() -> UIImage! {
        return #imageLiteral(resourceName: "user_image")
    }
}
