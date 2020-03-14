// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// Generated with SwiftyMocky 3.5.0

import SwiftyMocky
#if !MockyCustom
    import XCTest
#endif
@testable import Demo
import Foundation
import SwiftyMocky

// MARK: - UserRepository

open class UserRepositoryMock: UserRepository, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    open func find(by id: Int) -> User? {
        addInvocation(.m_find__by_id(Parameter<Int>.value(id)))
        let perform = methodPerformValue(.m_find__by_id(Parameter<Int>.value(id))) as? (Int) -> Void
        perform?(id)
        var __value: User?
        do {
            __value = try methodReturnValue(.m_find__by_id(Parameter<Int>.value(id))).casted()
        } catch {
            // do nothing
        }
        return __value
    }

    fileprivate enum MethodType {
        case m_find__by_id(Parameter<Int>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case let (.m_find__by_id(lhsId), .m_find__by_id(rhsId)):
                guard Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher) else { return false }
                return true
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_find__by_id(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func find(by id: Parameter<Int>, willReturn: User?...) -> MethodStub {
            return Given(method: .m_find__by_id(id), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func find(by id: Parameter<Int>, willProduce: (Stubber<User?>) -> Void) -> MethodStub {
            let willReturn: [User?] = []
            let given: Given = { Given(method: .m_find__by_id(id), products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: (User?).self)
            willProduce(stubber)
            return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func find(by id: Parameter<Int>) -> Verify { return Verify(method: .m_find__by_id(id)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func find(by id: Parameter<Int>, perform: @escaping (Int) -> Void) -> Perform {
            return Perform(method: .m_find__by_id(id), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        #if Mocky
            guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
            SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}
