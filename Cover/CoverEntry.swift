//
//  CoverEntry.swift
//  TonCells
//
//  Created by Кирилл Кириленко on 03.03.2023.
//

import Intents
import UIKit
import WidgetKit

struct CoverEntry: TimelineEntry {
    var date: Date = Date()
    let image: UIImage?
    let configuration: ConfigurationIntent
}
