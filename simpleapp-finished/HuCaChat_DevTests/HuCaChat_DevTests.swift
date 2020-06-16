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
        describe("MoviesTableViewControllerSpec") {
        /// Test call Movie API is Failed with key authentation
            context("API topRated") {
                it("api not nil") {
                    var listMovie : [Movie]?
                    MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.topRated.rawValue) { (movieList) in
                        listMovie = movieList
                    }
                    expect(listMovie?.count).toEventually(equal(20), timeout: 5)
                }
            }
            context("API popular") {
                it("api not nil") {
                    var listMovie : [Movie]?
                    MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.popular.rawValue) { (movieList) in
                        listMovie = movieList
                    }
                    expect(listMovie?.count).toEventually(equal(19), timeout: 5)
                }
            }
            context("API nowPlaying") {
                it("api not nil") {
                    var listMovie : [Movie]?
                    MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.nowPlaying.rawValue) { (movieList) in
                        listMovie = movieList
                    }
                    expect(listMovie?.count).toEventually(equal(20), timeout: 5)
                }
            }
            context("API upComing") {
                it("api not nil") {
                    var listMovie : [Movie]?
                    MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.upComing.rawValue) { (movieList) in
                        listMovie = movieList
                    }
                    expect(listMovie?.count).toEventually(equal(20), timeout: 5)
                }
            }
            context("Image nowPlaying Ranking") {
                it("api not nil") {
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
            }
            context("Image popular Ranking") {
                it("api not nil") {
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
            }
            context("Image topRated Ranking") {
                it("api not nil") {
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
            }
            context("Image upComing Ranking") {
                it("api not nil") {
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
        }
    }
}
