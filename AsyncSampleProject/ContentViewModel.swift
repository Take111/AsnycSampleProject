//
//  ContentViewModel.swift
//  AsyncSampleProject
//
//  Created by Takenouchi-Chikato on 2022/05/18.
//

import Foundation

final class ContentViewModel: ObservableObject {

    private let repository: any SampleRepository = SampleRepositoryImpl()

    private let sampleActor = SampleActor()

    @Published private(set) var title = "初期値だよ"

    @MainActor
    func didTapButton() {
        // async await
        Task {
            do {
                title = try await repository.createTitleText()
            } catch {
                title = "エラー"
            }
        }
        // Actorの場合
//        Task.detached {
//            self.title = await self.sampleActor.getSampleValue()
//        }
    }
}

actor SampleActor {

    private let value: String = "Sample"

    func getSampleValue() -> String {
        return value
    }

}
