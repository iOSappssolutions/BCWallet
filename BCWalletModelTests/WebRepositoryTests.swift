//
//  WebRepositoryTests.swift
//  BCWalletModelTests
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import XCTest
import Combine

@testable import BCWalletModel

final class WebRepositoryTests: XCTestCase {
    
    private var sut: TestWebRepository!
    private var subscriptions = Set<AnyCancellable>()
    
    private typealias API = TestWebRepository.API
    typealias Mock = RequestMocking.MockedResponse

    override func setUp() {
        subscriptions = Set<AnyCancellable>()
        sut = TestWebRepository()
    }

    override func tearDown() {
        RequestMocking.removeAllMocks()
    }
    
    func test_webRepository_success() throws {
        let data = TestWebRepository.TestData()
        try mock(.test, result: .success(data))
        let exp = XCTestExpectation(description: "Completion")
        sut.load(.test).sinkToResult { result in
            XCTAssertTrue(Thread.isMainThread)
            result.assertSuccess(value: data)
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    func test_webRepository_httpCodeFailure() throws {
        let data = TestWebRepository.TestData()
        try mock(.test, result: .success(data), httpCode: 500)
        let exp = XCTestExpectation(description: "Completion")
        sut.load(.test).sinkToResult { result in
            XCTAssertTrue(Thread.isMainThread)
            result.assertFailure("Unexpected HTTP code: 500")
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    func test_webRepository_networkingError() throws {
        let error = NSError.test
        try mock(.test, result: Result<TestWebRepository.TestData, Error>.failure(error))
        let exp = XCTestExpectation(description: "Completion")
        sut.load(.test).sinkToResult { result in
            XCTAssertTrue(Thread.isMainThread)
            result.assertFailure(error.localizedDescription)
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    func test_webRepository_requestURLError() {
        let exp = XCTestExpectation(description: "Completion")
        sut.load(.urlError).sinkToResult { result in
            XCTAssertTrue(Thread.isMainThread)
            result.assertFailure(APIError.invalidURL.localizedDescription)
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    func test_webRepository_requestBodyError() {
        let exp = XCTestExpectation(description: "Completion")
        sut.load(.bodyError).sinkToResult { result in
            XCTAssertTrue(Thread.isMainThread)
            result.assertFailure(TestWebRepository.APIError.fail.localizedDescription)
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    
    func test_webRepository_noHttpCodeError() throws {
        let response = URLResponse(url: URL(fileURLWithPath: ""),
                                   mimeType: "example", expectedContentLength: 0, textEncodingName: nil)
        let mock = try Mock(apiCall: API.test, baseURL: sut.baseURL, customResponse: response)
        RequestMocking.add(mock: mock)
        let exp = XCTestExpectation(description: "Completion")
        sut.load(.test).sinkToResult { result in
            XCTAssertTrue(Thread.isMainThread)
            result.assertFailure(APIError.unexpectedResponse.localizedDescription)
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    // MARK: - Helper
    
    private func mock<T>(_ apiCall: API, result: Result<T, Swift.Error>,
                         httpCode: HTTPCode = 200) throws where T: Encodable {
        let mock = try Mock(apiCall: apiCall, baseURL: sut.baseURL, result: result, httpCode: httpCode)
        RequestMocking.add(mock: mock)
    }
}

private extension TestWebRepository {
    func load(_ api: API) -> AnyPublisher<TestData, Error> {
        call(endpoint: api)
    }
}

extension TestWebRepository {
    enum API: APICall {
        
        case test
        case urlError
        case bodyError
        case noHttpCodeError
        
        var path: String {
            if self == .urlError {
                return "###"
            }
            return "/test/path"
        }
        var method: String { "POST" }
        var headers: [String: String]? { nil }
        var queryItems: [URLQueryItem]? { nil }
        func body() throws -> Data? {
            if self == .bodyError { throw APIError.fail }
            return nil
        }
    }
}

extension TestWebRepository {
    enum APIError: Swift.Error, LocalizedError {
        case fail
        var errorDescription: String? { "fail" }
    }
}

extension TestWebRepository {
    struct TestData: Codable, Equatable {
        let string: String
        let integer: Int
        
        init() {
            string = "something"
            integer = 77
        }
    }
}

extension Publisher {
    func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                result(.failure(error))
            default: break
            }
        }, receiveValue: { value in
            result(.success(value))
        })
    }
}

