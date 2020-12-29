//
//  NetworkReachability.swift
//  Mobile Developer Test
//
//  Created by kjoe on 12/28/20.
//

import Foundation
struct StoryTitle : Codable {
	let value : String?
	let matchLevel : String?
	let fullyHighlighted : Bool?
	let matchedWords : [String]?

	enum CodingKeys: String, CodingKey {

		case value = "value"
		case matchLevel = "matchLevel"
		case fullyHighlighted = "fullyHighlighted"
		case matchedWords = "matchedWords"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		value = try values.decodeIfPresent(String.self, forKey: .value)
		matchLevel = try values.decodeIfPresent(String.self, forKey: .matchLevel)
		fullyHighlighted = try values.decodeIfPresent(Bool.self, forKey: .fullyHighlighted)
		matchedWords = try values.decodeIfPresent([String].self, forKey: .matchedWords)
	}

}
