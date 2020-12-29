//
//  NetworkReachability.swift
//  Mobile Developer Test
//
//  Created by kjoe on 12/28/20.
//

import Foundation
struct StoryUrl : Codable {
	let value : String?
	let matchLevel : String?
	let matchedWords : [String]?

	enum CodingKeys: String, CodingKey {

		case value = "value"
		case matchLevel = "matchLevel"
		case matchedWords = "matchedWords"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		value = try values.decodeIfPresent(String.self, forKey: .value)
		matchLevel = try values.decodeIfPresent(String.self, forKey: .matchLevel)
		matchedWords = try values.decodeIfPresent([String].self, forKey: .matchedWords)
	}

}
