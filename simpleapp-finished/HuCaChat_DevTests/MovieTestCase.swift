//
//  MovieTestCase.swift
//  HuCaChat_DevTests
//
//  Created by chau nguyen on 6/30/20.
//  Copyright © 2020 HungNV. All rights reserved.
//

import XCTest
import Kingfisher
@testable import HuCaChat_Dev

class MovieTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp();
    }
    
    override func tearDown() {
        super.tearDown();
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func testListtopRated() {
        let exp = expectation(description: "Test after 5 seconds")
        var listMovie : [Movie]?
        MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.topRated.rawValue) { (movieList) in
            listMovie = movieList
            exp.fulfill()
        }
        self.wait(for: [exp], timeout: 5)
        XCTAssert(listMovie?.count == 20, "Number of element is \(listMovie?.count)")
    }
    
//    func testListtopPopular() {
//        let exp = expectation(description: "Test after 5 seconds")
//        var listMovie : [Movie]?
//        MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.popular.rawValue) { (movieList) in
//            listMovie = movieList
//            DispatchQueue.main.async {
//                exp.fulfill()
//            }
//        }
//        waitForExpectations(timeout: 5) { (error) in
//            if let error = error {
//
//            }
//        }
//        XCTAssert(listMovie?.count == 19, "Number of element is \(listMovie?.count)")
//    }
//
//    func testListtopNowPlaying() {
//        let exp = expectation(description: "Test after 5 seconds")
//        var listMovie : [Movie]?
//        MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.nowPlaying.rawValue) { (movieList) in
//            listMovie = movieList
//            DispatchQueue.main.async {
//                exp.fulfill()
//            }
//        }
//        waitForExpectations(timeout: 5) { (error) in
//            if let error = error {
//
//            }
//        }
//        XCTAssert(listMovie?.count == 20, "Number of element is \(listMovie?.count)")
//    }
//
//    func testListtopUpComing() {
//        let exp = expectation(description: "Test after 5 seconds")
//        var listMovie : [Movie]?
//        MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.upComing.rawValue) { (movieList) in
//            listMovie = movieList
//            DispatchQueue.main.async {
//                exp.fulfill()
//            }
//        }
//        waitForExpectations(timeout: 5) { (error) in
//            if let error = error {
//
//            }
//        }
//        XCTAssert(listMovie?.count == 20, "Number of element is \(listMovie?.count)")
//    }
//
//    func testNumberOfImageNowPlaying() {
//        let exp = expectation(description: "Test after 5 seconds")
//        var numberImage = 0
//        var numberPage = 1;
//        let imgMoviePoster = UIImageView()
//        MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.nowPlaying.rawValue) { (movieList) in
//            for item in movieList ?? [] {
//                if let url = URL(string: item.poster_path) {
//                    let resource = ImageResource(downloadURL: url, cacheKey: item.poster_path)
//                    DispatchQueue.main.async {
//                        imgMoviePoster.kf.setImage(with: resource) { (image, error, type, url) in
//                            numberPage += 1;
//                            if let _ = image {
//                                numberImage += 1
//                            }
//                            if (numberPage == movieList?.count) {
//                                exp.fulfill()
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        waitForExpectations(timeout: 30) { (error) in
//            if let error = error {
//
//            }
//        }
//        XCTAssert(numberImage == 19, "Number of element is \(numberImage)")
//    }
//
//    func testNumberOfImageTopRated() {
//        let exp = expectation(description: "Test after 5 seconds")
//        var numberImage = 0
//        var numberPage = 1;
//        let imgMoviePoster = UIImageView()
//        MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.topRated.rawValue) { (movieList) in
//            for item in movieList ?? [] {
//                if let url = URL(string: item.poster_path) {
//                    let resource = ImageResource(downloadURL: url, cacheKey: item.poster_path)
//                    DispatchQueue.main.sync {
//                        imgMoviePoster.kf.setImage(with: resource) { (image, error, type, url) in
//                            numberPage += 1;
//                            if let _ = image {
//                                numberImage += 1
//                            }
//                            if (numberPage == movieList?.count) {
//                                exp.fulfill()
//                            }
//                        }
//                    }
//                }
//            }
//            exp.fulfill()
//        }
//        waitForExpectations(timeout: 30) { (error) in
//            if let error = error {
//
//            }
//        }
//        XCTAssert(numberImage == 20, "Number of element is \(numberImage)")
//    }
//
//    func testNumberOfImageUpComing() {
//        let exp = expectation(description: "Test after 5 seconds")
//        var numberImage = 0
//        var numberPage = 1;
//        let imgMoviePoster = UIImageView()
//        MainDB.shared.getListMovie(page: 1, type: TypeOfMovie.upComing.rawValue) { (movieList) in
//            for item in movieList ?? [] {
//                if let url = URL(string: item.poster_path) {
//                    let resource = ImageResource(downloadURL: url, cacheKey: item.poster_path)
//                    DispatchQueue.main.async {
//                        imgMoviePoster.kf.setImage(with: resource) { (image, error, type, url) in
//                            if let _ = image {
//                                numberPage += 1;
//                                if let _ = image {
//                                    numberImage += 1
//                                }
//                                if (numberPage == movieList?.count) {
//                                    exp.fulfill()
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        waitForExpectations(timeout: 30) { (error) in
//            if let error = error {
//
//            }
//        }
//        XCTAssert(numberImage == 20, "Number of element is \(numberImage)")
//    }
////
//    func getLocalMusic() {
//        let exp = expectation(description: "Test after 5 seconds")
//        var arrSong: [MusicInfo]?
//        LocalDB.shared().getMusicInLocalDB { (musics) in
//            if let musics = musics {
//                arrSong = musics
//            }
//            exp.fulfill()
//        }
//        waitForExpectations(timeout: 30) { (error) in
//            if let error = error {
//
//            }
//        }
//        XCTAssert(arrSong?.count == 7, "Number of element is \(arrSong?.count)")
//    }
}
