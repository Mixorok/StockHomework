//
//  GetStockDetailsTests.swift
//  UseCases
//
//  Created by Maksim Bezdrobnoi on 19.05.2025.
//

import GetStockDetails
@testable import GetStockDetailsImpl
import XCTest
import Combine
import Domain
@testable import StocksGateway

final class GetStockDetailsTests: XCTestCase {

    private let stocksGatewayFake = StocksGatewayFake()

    private lazy var getStockDetails = GetStockDetailsImpl(stocksGateway: stocksGatewayFake)

    var cancellable = Set<AnyCancellable>()

    func testReturnsCorrectStockDetails() {
        let dto = StockDetailsDTO(
            regularMarketPrice: 100,
            regularMarketPreviousClose: 99,
            regularMarketOpen: 101,
            regularMarketDayHigh: 105,
            regularMarketDayLow: 95,
            regularMarketVolume: 1000000,
            marketCap: 2000000000,
            fiftyTwoWeekLow: 80,
            fiftyTwoWeekHigh: 110
        )
        stocksGatewayFake.stockDetails = dto

        let exp = expectation(description: "Should return correct StockDetails")
        var result: StockDetails?

        getStockDetails(for: "AAPL")
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { details in
                      result = details
                      exp.fulfill()
                  }
            )
            .store(in: &cancellable)

        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(result?.openPrice, 101)
        XCTAssertEqual(result?.previousClose, 99)
        XCTAssertEqual(result?.volume, 1000000)
        XCTAssertEqual(result?.dayRange, "$95.00 - $105.00")
        XCTAssertEqual(result?.week52Range, "$80.00 - $110.00")
        XCTAssertEqual(result?.marketCap, 2000000000)
    }

    func testReturnsCantFindDetailsErrorIfNoResponse() {
        stocksGatewayFake.stockDetails = nil

        let exp = expectation(description: "Should return error if not found")
        var receivedError: GetStockDetailsError?

        getStockDetails(for: "AAPL")
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        receivedError = error
                        exp.fulfill()
                    }
                },
                receiveValue: { _ in XCTFail("Should not receive value")}
            )
            .store(in: &cancellable)

        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(receivedError, .cantFindDetails)
    }
}

extension GetStockDetailsError: Equatable {

    public static func == (lhs: GetStockDetailsError, rhs: GetStockDetailsError) -> Bool {
        switch (lhs, rhs) {
        case (.cantFindDetails, .cantFindDetails):
            return true
        case (.general(let lhsError), .general(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

private class StocksGatewayFake: StocksGateway {

    var stockDetails: StockDetailsDTO?

    func fetchStocks() -> AnyPublisher<[StockResultDTO], Error> {
        fatalError("Doesn't need to this test")
    }

    func fetchStockDetails(for stockName: String) -> AnyPublisher<StockDetailsDTO?, Error> {
        Just(stockDetails)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
