//
//  HuCaChat_DevTests.swift
//  HuCaChat_DevTests
//
//  Created by chau nguyen on 6/16/20.
//  Copyright © 2020 HungNV. All rights reserved.
//

import Nimble
import Quick
import UIKit
import Kingfisher

@testable import HuCaChat_Dev

class MyMovieTests : QuickSpec {
    override func spec() {
        //Unit test for screen movie
        describe("MoviesTableViewControllerSpec") {
            
            //Test data from API
            context("Test data API") {
                
                //Test api get list top rate with page 1
                it("topRated") {
                    var listMovie : [Movie]?
                    MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.topRated.rawValue) { (movieList) in
                        listMovie = movieList
                    }
                    expect(listMovie?.count).toEventually(equal(20), timeout: 5)
                }
                
                //Test api get list popular with page 1
                it("popular") {
                    var listMovie : [Movie]?
                    MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.popular.rawValue) { (movieList) in
                        listMovie = movieList
                    }
                    expect(listMovie?.count).toEventually(equal(19), timeout: 5)
                }
                
                //Test api get list now playing with page 1
                it("nowPlaying") {
                    var listMovie : [Movie]?
                    MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.nowPlaying.rawValue) { (movieList) in
                        listMovie = movieList
                    }
                    expect(listMovie?.count).toEventually(equal(20), timeout: 5)
                }
                
                //Test api get list up coming with page 1
                it("upComing") {
                    var listMovie : [Movie]?
                    MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.upComing.rawValue) { (movieList) in
                        listMovie = movieList
                    }
                    expect(listMovie?.count).toEventually(equal(20), timeout: 5)
                }
            }
            
            //Unit test: Check data of image -> if url fail -> image null.
            context("Unit test for check content of image from api") {
                
                //Test content image of now playing api
                it("nowPlaying") {
                    var numberImage = 0
                    let imgMoviePoster = UIImageView()
                    MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.nowPlaying.rawValue) { (movieList) in
                        for item in movieList ?? [] {
                            if let url = URL(string: item.poster_path) {
                                let resource = ImageResource(downloadURL: url, cacheKey: item.poster_path)
                                DispatchQueue.main.async {
                                    imgMoviePoster.kf.setImage(with: resource) { (image, error, type, url) in
                                        if let _ = image {
                                            numberImage += 1
                                        }
                                    }
                                }
                            }
                        }
                    }
                    expect(numberImage).toEventually(equal(20), timeout: 60)
                }
                
                //Test content image of popular api
                it("popular") {
                    var numberImage = 0
                    let imgMoviePoster = UIImageView()
                    MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.popular.rawValue) { (movieList) in
                        for item in movieList ?? [] {
                            if let url = URL(string: item.poster_path) {
                                let resource = ImageResource(downloadURL: url, cacheKey: item.poster_path)
                                DispatchQueue.main.async {
                                    imgMoviePoster.kf.setImage(with: resource) { (image, error, type, url) in
                                        if let _ = image {
                                            numberImage += 1
                                        }
                                    }
                                }
                            }
                        }
                    }
                    expect(numberImage).toEventually(equal(19), timeout: 60)
                }
                
                //Test content image of top rated api
                it("topRated") {
                    var numberImage = 0
                    let imgMoviePoster = UIImageView()
                    MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.topRated.rawValue) { (movieList) in
                        for item in movieList ?? [] {
                            if let url = URL(string: item.poster_path) {
                                let resource = ImageResource(downloadURL: url, cacheKey: item.poster_path)
                                DispatchQueue.main.async {
                                    imgMoviePoster.kf.setImage(with: resource) { (image, error, type, url) in
                                        if let _ = image {
                                            numberImage += 1
                                        }
                                    }
                                }
                            }
                        }
                    }
                    expect(numberImage).toEventually(equal(20), timeout: 60)
                }
                
                //Test content image of up coming api
                it("upComing") {
                    var numberImage = 0
                    let imgMoviePoster = UIImageView()
                    MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.upComing.rawValue) { (movieList) in
                        for item in movieList ?? [] {
                            if let url = URL(string: item.poster_path) {
                                let resource = ImageResource(downloadURL: url, cacheKey: item.poster_path)
                                DispatchQueue.main.async {
                                    imgMoviePoster.kf.setImage(with: resource) { (image, error, type, url) in
                                        if let _ = image {
                                            numberImage += 1
                                        }
                                    }
                                }
                            }
                        }
                    }
                    expect(numberImage).toEventually(equal(20), timeout: 60)
                }
            }
            
            //Unit test: Test Local database
            context("Get Local Music") {
                
                //Test get list music of local database
                it("Test local music equal 7") {
                    var arrSong: [MusicInfo]?
                    LocalDB.shared().getMusicInLocalDB { (musics) in
                        if let musics = musics {
                            arrSong = musics
                        }
                    }
                    expect(arrSong?.count).toEventually(equal(7), timeout: 5)
                }
            }
            
            //Test remove music in local database
            context("Remove Local Music") {
                it("Test remove local music equal with incorrect id") {
                    var resultRemove: Bool = false
                    LocalDB.shared().removeMusicInLocalDB(id: "10") { (result) in
                        resultRemove = result
                    }
                    expect(resultRemove).toEventually(equal(false), timeout: 5)
                }

                it("Test remove local music equal with correct id") {
                    var resultRemove: Bool = false
                    LocalDB.shared().removeMusicInLocalDB(id: "0002") { (result) in
                        resultRemove = result
                    }
                    expect(resultRemove).toEventually(equal(true), timeout: 5)
                }
            }
            
            //Test change name music in local database and test correct name after change.
            context("Change Local Music") {
                it("Change name music and check result after change") {
                    let newName: String = "Name of music 1"
                    var result = false
                    LocalDB.shared().changeNameMusicLocalDB(id: "0002", name: newName) { (_) in
                        if let song = LocalDB.shared().getMusicById(id: "0002") {
                            if (song.title == newName) {
                                result = true
                            }
                        }
                    }
                    expect(result).toEventually(equal(true), timeout: 5)
                }
            }
        }
    }
}
