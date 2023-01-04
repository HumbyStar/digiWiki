//
//  DigiInfo.swift
//  DigiWIki
//
//  Created by Humberto Rodrigues on 29/11/22.
//

import Foundation

class DigiSeries: Codable {
    var DigimonSeries: [Info]
}

class Info: Codable {
    var name: String
    var year: String
    var episodes: Int
    var description: String
    var watchEpisodes: [Episode]
}

struct Episode: Codable {
    var name: String
    var episodio: String
    var title: String
    var URL: String
}

//MARK: FOI ADAPTADO PARA COREDATA
/*class DigiInfo: Codable {
    var digimon:[About]
}

class About: Codable {
    var name: String
    var Age: String
    var Description: String?
    var secondImage: String?

}*/



