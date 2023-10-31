//
//  LL2Model.swift
//  Launch Feed
//
//  Created by Dylan Hawley on 10/30/23.
//

import Foundation


struct Launch: Hashable, Decodable {
    var id: String
    var name: String
    var last_updated: String
    var net: String
    var window_end: String
    var window_start: String
    var holdreason: String
    var failreason: String
    var rocket: Rocket
    var mission: Mission
    var pad: Pad
    var image: String
    
    struct Rocket: Hashable, Decodable {
        var configuration: RocketConfiguration
        
        struct RocketConfiguration: Hashable, Decodable {
            var url: String
            var name: String
            var family: String
            var full_name: String
            var variant: String
        }
    }
    
    struct Mission: Hashable, Decodable {
        var name: String
        var description: String
        var type: String
        
        struct Orbit: Hashable, Decodable {
            var name: String
            var abbrev: String
        }
    }

    struct Pad: Hashable, Decodable {
        var name: String
        var map_url: String
        var latitude: String
        var longitude: String
        var location: Location
        
        struct Location: Hashable, Decodable {
            var name: String
            var country_code: String
            var timezone_name: String
        }
    }
}

struct LL2Response: Decodable {
    var results: [Launch]
}
