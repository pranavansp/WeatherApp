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
        public static var switchToFahrenheit: LocalizedStringKey {
            return "landing.switch.to.fahrenheit"
        }
        public static var switchToCelsius: LocalizedStringKey {
            return "landing.switch.to.celsius"
        }
        public static var settings: LocalizedStringKey {
            return "landing.error.location.settings"
        }
        public static var noThanks: LocalizedStringKey {
            return "landing.error.location.no.thanks"
        }
    }
}
