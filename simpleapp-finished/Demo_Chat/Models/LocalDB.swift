//
//  LocalDB.swift
//  Demo_Chat
//
//  Created by HungNV on 8/30/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

import Foundation

class LocalDB {
    private static let localInastance: LocalDB = LocalDB()
    static func shared() -> LocalDB {
        return localInastance
    }
    
    init() {
        let lastVersion: String = Helper.shared.lastVersion()
        let currentVersion: String = Helper.shared.getVersionOfApp()
        
        if currentVersion.compare(lastVersion, options: .numeric) == .orderedDescending {
            Helper.shared.saveUserDefault(key: kLastVersion, value: currentVersion)
        }
    }
    
    func getMusicInLocalDB(response: @escaping (_ musics:[MusicInfo]?)->()) {
        var musics: [MusicInfo] = [MusicInfo]()
        let songs : [Song] = DBHelper.share.getDataFromRealm(type: Song.self)
        for song in songs {
            let musicInfo = MusicInfo()
            musicInfo.id = song.id
            musicInfo.title = song.title
            musicInfo.artist = song.artist
            musicInfo.avatar = song.avatar
            musicInfo.urlJunDownload = song.urlJunDownload
            musicInfo.lyricsUrl = song.lyricsUrl
            musicInfo.urlSource = song.urlSource
            musicInfo.siteId = song.siteId
            musicInfo.hostName = song.hostName
            musicInfo.musicDownloadState = Int(song.musicDownloadState)
            musicInfo.isPlaying = false
            musics.append(musicInfo)
        }
        response(musics)
    }
    
    func addMusicInLocalDB(obj: Music, response: @escaping(Bool) -> Void) {
        let song = Song()
        song.id = obj.id
        song.title = obj.title
        song.artist = obj.artist
        song.avatar = "\(obj.id).jpg"
        song.urlJunDownload = "\(obj.id).mp3"
        song.urlSource = obj.urlSource
        song.siteId = obj.siteId
        song.hostName = obj.hostName
        song.musicDownloadState = 0
        DBHelper.share.addObject(value: song)
        response(true)
    }
    
    func removeMusicInLocalDB(id: String, response: @escaping(Bool) -> Void) {
        let result = DBHelper.share.removeObject(type: Song.self, id: id)
        response(result)
    }
    
    func getMusicById(id: String) -> Song? {
        return DBHelper.share.filterById(objectType: Song.self, value: id)
    }
    
    func changeNameMusicLocalDB(id: String, name: String, response: @escaping (Bool) -> ()) {
        DBHelper.share.updateObject(id: id, type: Song.self) { (item) in
            item.title = name
            response(true)
        }
    }
    
    func addSongInLocalDB(obj: SongModel) {
        let song = Song()
        song.id = obj.id
        song.title = obj.title
        song.artist = obj.singer
        song.avatar = "\(obj.fileName).png"
        song.urlJunDownload = "\(obj.fileName).mp3"
        song.lyricsUrl = "\(obj.fileName).lrc"
        DBHelper.share.addObject(value: song)
    }
}
