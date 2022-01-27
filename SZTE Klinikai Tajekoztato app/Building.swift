//
//  Building.swift
//  SZTE Klinikai Tajekoztato app
//
//  Created by Bálint on 2022. 01. 18..
//

import Foundation

class Building {
    
    var name: String = ""
    var phonenumber: String = ""
    var coordinate: String = ""
    var imageUrl: String = ""
    
    init(name: String, phonenumber:String, coordinate: String, imageUrl: String) {
        self.name = name
        self.phonenumber = phonenumber
        self.coordinate = coordinate
        self.imageUrl = imageUrl
    }
    
}
