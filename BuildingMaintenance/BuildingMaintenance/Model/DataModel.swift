//
//  DataModel.swift
//  BuildingMaintenance
//
//  Created by Banerjee, Subhodip on 26/07/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

struct Items : Decodable {
    var value: Int
    var rt : String
    var status : String
}

struct Datas : Decodable {
    var devicename: String
    var model: String
    var data : [Items]
}

