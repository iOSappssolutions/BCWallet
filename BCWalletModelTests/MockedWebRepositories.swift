//
//  MockedWebRepositories.swift
//  BCWalletModelTests
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import XCTest
import Combine
@testable import BCWalletModel

class TestWebRepository: WebRepository {
    let session: URLSession = .mockedResponsesOnly
    let baseURL = "https://test.com"
    let bgQueue = DispatchQueue(label: "test")
}

// MARK: - Wallet data web repository

final class MockedCountriesWebRepository: TestWebRepository, Mock, XPubAPI {
    
    func fetchWalletData(xPub: String) -> AnyPublisher<XPubData, Error> {
        register(.fetchWalletData)
        return fetchWalletResponse.publish()
    }
    
    
    enum Action: Equatable {
        case fetchWalletData
    }
    var actions = MockActions<Action>(expected: [])
    
    var fetchWalletResponse: Result<XPubData, Error> = .failure(MockError.valueNotSet)
    
}


