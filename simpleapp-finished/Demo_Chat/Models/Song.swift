//
//  Song.swift
//  HuCaChat
//
//  Created by HungNV on 6/14/20.
//  Copyright © 2020 HungNV. All rights reserved.
//

import Foundation
import RealmSwift

class Song: Object {
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var artist = ""
    @objc dynamic var avatar = ""
    @objc dynamic var urlJunDownload = ""
    @objc dynamic var lyricsUrl = ""
    @objc dynamic var urlSource = ""
    @objc dynamic var siteId = ""
    @objc dynamic var hostName = ""
    @objc dynamic var musicDownloadState = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
