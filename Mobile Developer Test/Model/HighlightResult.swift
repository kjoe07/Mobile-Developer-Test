//
//  NetworkReachability.swift
//  Mobile Developer Test
//
//  Created by kjoe on 12/28/20.
//


import Foundation
struct HighlightResult : Codable {
	let author : Author?
	let commentText : Comment_text?
	let storyTitle : StoryTitle?
	let storyUrl : StoryUrl?

	enum CodingKeys: String, CodingKey {

		case author = "author"
		case commentText = "comment_text"
		case storyTitle = "story_title"
		case storyUrl = "story_url"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		author = try values.decodeIfPresent(Author.self, forKey: .author)
		commentText = try values.decodeIfPresent(Comment_text.self, forKey: .commentText)
		storyTitle = try values.decodeIfPresent(StoryTitle.self, forKey: .storyTitle)
		storyUrl = try values.decodeIfPresent(StoryUrl.self, forKey: .storyUrl)
	}

}
