//
//  NetworkClientError.swift
//  Services
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//


public enum NetworkClientError: Error {
    case failedToGenerateURL(String)
    case unrecognizedError
    case invalidStatusCode(Int)
    case responseSerializationError(Error)
    case requestSerializer(Error)
}
