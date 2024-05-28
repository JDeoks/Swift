//
//  TodoViewModel.swift
//  voiceMemo
//

import Foundation

class TodoViewModel: ObservableObject {
    @Published var title: String
    @Published var time: Date
    @Published var day: Date
    @Published var isDisplayCalander: Bool
    
    init(
        title: String = "제목",
        time: Date = Date(),
        day: Date = Date(),
        isDisplayCalander: Bool = false
    ) {
        self.title = title
        self.time = time
        self.day = day
        self.isDisplayCalander = isDisplayCalander
    }
    
}

extension TodoViewModel {
    func setIsDisplayCalander(isDisplay: Bool) {
        isDisplayCalander = isDisplay
    }
}
