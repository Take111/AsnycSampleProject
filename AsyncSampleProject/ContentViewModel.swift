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
    func didTapSyncButton() {
        Task {
            do {
                let seconds = try await waitSomeWithSync(seconds: [3, 1, 4, 5, 2])
                seconds.forEach {
                    print("second", $0)
                }
            } catch {
                print("error")
            }
        }
    }

    @MainActor
    func didTapAsyncButton() {
        Task {
            do {
                let seconds = try await waitSomeWithAsync(seconds: [3, 1, 4, 5, 2])
                seconds.forEach {
                    print("second", $0)
                }
            } catch {
                print("error")
            }
        }
    }

    private func wait(second: Int) async -> String {
        try! await Task.sleep(nanoseconds: UInt64(second * 1_000_000_000))
        return "\(second)秒後"
    }

    private func waitSomeWithSync(seconds: [Int]) async throws -> [String] {

        // N個の処理を直列に走らせる場合
        var values: [String] = []
        for second in seconds {
            let value = await self.wait(second: second)
            values.append(value)

//             こうやっても書けるが、awaitはこのスコープないでしか使えないため、直列の実行になる
//            async let value = self.wait(second: second)
//            values.append(await value)
        }
        return values
    }

    func waitSomeWithAsync(seconds: [Int]) async throws -> [String] {
        // N個の処理を並列に走らせる場合
        // withTaskGroupでもよい
        try await withThrowingTaskGroup(of: String.self, body: { group in
            for second in seconds {
                group.addTask {
                    // 何かしらのasyncなAPIなど
                    return await self.wait(second: second)
                }
            }

            var secondStrings: [String] = []
            for try await value in group {
                secondStrings.append(value)
            }
            return secondStrings
        })
    }
}

actor SampleActor {

    private let value: String = "Sample"

    func getSampleValue() -> String {
        return value
    }

}
