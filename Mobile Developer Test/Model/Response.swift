//
//  NetworkReachability.swift
//  Mobile Developer Test
//
//  Created by kjoe on 12/28/20.
//

import Foundation
struct Response : Codable {
	let hits : [Hits]?
	let nbHits : Int?
	let page : Int?
	let nbPages : Int?
	let hitsPerPage : Int?
	let exhaustiveNbHits : Bool?
	let query : String?
	let params : String?
	let processingTimeMS : Int?

	enum CodingKeys: String, CodingKey {

		case hits = "hits"
		case nbHits = "nbHits"
		case page = "page"
		case nbPages = "nbPages"
		case hitsPerPage = "hitsPerPage"
		case exhaustiveNbHits = "exhaustiveNbHits"
		case query = "query"
		case params = "params"
		case processingTimeMS = "processingTimeMS"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		hits = try values.decodeIfPresent([Hits].self, forKey: .hits)
		nbHits = try values.decodeIfPresent(Int.self, forKey: .nbHits)
		page = try values.decodeIfPresent(Int.self, forKey: .page)
		nbPages = try values.decodeIfPresent(Int.self, forKey: .nbPages)
		hitsPerPage = try values.decodeIfPresent(Int.self, forKey: .hitsPerPage)
		exhaustiveNbHits = try values.decodeIfPresent(Bool.self, forKey: .exhaustiveNbHits)
		query = try values.decodeIfPresent(String.self, forKey: .query)
		params = try values.decodeIfPresent(String.self, forKey: .params)
		processingTimeMS = try values.decodeIfPresent(Int.self, forKey: .processingTimeMS)
	}

}
