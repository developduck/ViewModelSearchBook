//
//  Book.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/19.
//  Copyright © 2020 example. All rights reserved.
//

struct BookItem: Codable {
    let items: [Book]?
}

struct Book: Codable, Identifiable {
    let id: String
    let volumeInfo: VolumeInfo?
}

struct VolumeInfo: Codable {
    let title: String?
    let authors: [String]?
    let description: String?
    let imageLinks: ImageLinks?
    let industryIdentifiers: [[String:String]]?
}

struct ImageLinks: Codable {
    let thumbnail: String?
}
