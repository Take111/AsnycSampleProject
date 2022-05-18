//
//  SampleRepository.swift
//  AsyncSampleProject
//
//  Created by Takenouchi-Chikato on 2022/05/18.
//

import Foundation

enum SampleError: Error {
    case failure
}

protocol SampleRepository {
    func createTitleText() async throws -> String
}

struct SampleRepositoryImpl: SampleRepository {

    func createTitleText() async throws -> String {
        if Bool.random() {
            return "エラーじゃないよ"
        } else {
            throw SampleError.failure
        }
    }
}
