//
//  Localization+Landing.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import SwiftUI

extension Localization {
    enum Landing {
        public static var title: LocalizedStringKey {
            return "landing.title"
        }
        public static var searchTitle: LocalizedStringKey {
            return "landing.search.title"
        }
        public static var temperature:(_ hight: String,_ low: String) -> LocalizedStringKey = { hight, low in
            return "landing.temp.high.\(hight).low.\(low)"
        }
    }
}
