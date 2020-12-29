//
//  NetworkReachability.swift
//  Mobile Developer Test
//
//  Created by kjoe on 12/28/20.
//

import Foundation
struct Hits : Codable {
	let createdAt : String?
	let title : String?
	let url : String?
	let author : String?
	let points : Int?
	let storyText : String?
	let commentText : String?
	let numComments : Int?
	let storyId : Int?
	let storyTitle : String?
	let storyUrl : String?
	let parentId : Int?
	let createdAtI : Int?
	let tags : [String]?
	let objectID : String?
	let highlightResult : HighlightResult?

	enum CodingKeys: String, CodingKey {

		case createdAt = "created_at"
		case title = "title"
		case url = "url"
		case author = "author"
		case points = "points"
		case storyText = "story_text"
		case commentText = "comment_text"
		case numComments = "num_comments"
		case storyId = "story_id"
		case storyTitle = "story_title"
		case storyUrl = "story_url"
		case parentId = "parent_id"
		case createdAtI = "created_at_i"
		case tags = "_tags"
		case objectID = "objectID"
		case highlightResult = "_highlightResult"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		author = try values.decodeIfPresent(String.self, forKey: .author)
		points = try values.decodeIfPresent(Int.self, forKey: .points)
		storyText = try values.decodeIfPresent(String.self, forKey: .storyText)
		commentText = try values.decodeIfPresent(String.self, forKey: .commentText)
		numComments = try values.decodeIfPresent(Int.self, forKey: .numComments)
		storyId = try values.decodeIfPresent(Int.self, forKey: .storyId)
		storyTitle = try values.decodeIfPresent(String.self, forKey: .storyTitle)
		storyUrl = try values.decodeIfPresent(String.self, forKey: .storyUrl)
		parentId = try values.decodeIfPresent(Int.self, forKey: .parentId)
		createdAtI = try values.decodeIfPresent(Int.self, forKey: .createdAtI)
		tags = try values.decodeIfPresent([String].self, forKey: .tags)
		objectID = try values.decodeIfPresent(String.self, forKey: .objectID)
		highlightResult = try values.decodeIfPresent(HighlightResult.self, forKey: .highlightResult)
	}

}
