//
//  LanguageModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 14/10/25.
//

struct LanguageModel: Decodable, Hashable {
  let languageCode: String
  let regionCode: String
  let displayName: String
  
  var localeIdentifier: String {
    "\(languageCode)-\(regionCode)"
  }
  
  static func localSupportedLanguages() -> [LanguageModel] {
    let data = ResourceJSON.from(fileName: "Languages", type: [LanguageModel].self)
    return data
  }
}
