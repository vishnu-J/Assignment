/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Tasks : Codable {
	let taskCd : String?
	let type : String?
	let frequency : Int?
	let duration : Int?
	let scheduleList : [ScheduleList]?
	let drug : Drug?
    let video:Video?

	enum CodingKeys: String, CodingKey {

		case taskCd = "taskCd"
		case type = "type"
		case frequency = "frequency"
		case duration = "duration"
		case scheduleList = "scheduleList"
		case drug = "drug"
        case video = "video"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		taskCd = try values.decodeIfPresent(String.self, forKey: .taskCd)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		frequency = try values.decodeIfPresent(Int.self, forKey: .frequency)
		duration = try values.decodeIfPresent(Int.self, forKey: .duration)
		scheduleList = try values.decodeIfPresent([ScheduleList].self, forKey: .scheduleList)
		drug = try values.decodeIfPresent(Drug.self, forKey: .drug)
        video = try values.decodeIfPresent(Video.self, forKey: .video)
	}

}
