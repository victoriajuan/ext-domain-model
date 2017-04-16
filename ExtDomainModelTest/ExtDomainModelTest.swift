//
//  ExtDomainModelTest.swift
//  ExtDomainModelTest
//
//  Created by Vicky Juan on 4/14/17.
//  Copyright © 2017 Vicky Juan. All rights reserved.
//

import XCTest
import ExtDomainModel

class ExtDomainModelTest: XCTestCase {
    
    func testCustomStringConvertible() {
        //Money
        let USDtest = 5.0.USD
        XCTAssert(USDtest.description == "USD5.0")
        let GBPtest = 10.0.GBP
        XCTAssert(GBPtest.description == "GBP10.0")
        let EURtest = 15.0.EUR
        XCTAssert(EURtest.description == "EUR15.0")
        let CANtest = 20.0.CAN
        XCTAssert(CANtest.description == "CAN20.0")
        //Job
        let JOBtest = Job(title: "Tutor", type: .Salary(50000))
        XCTAssert(JOBtest.description == "Tutor50000")
        //Person
        let Persontest = Person(firstName: "Vicky", lastName: "Juan", age: 20)
        XCTAssert(Persontest.description == "VickyJuan20")
        //Family
        let James = Person(firstName: "James", lastName: "Ho", age: 26)
        let Vicky = Person(firstName: "Vicky", lastName: "Juan", age: 20)
        let Familytest = Family(spouse1: James, spouse2: Vicky)
        XCTAssert(Familytest.description == "JamesHo26 VickyJuan20 ")
    }
    
    func testMathematics() {
        //add
        let USDtest = Money(amount: 55, currency: "USD").add(Money(amount: 66, currency: "USD"))
        XCTAssert(USDtest.amount == 121)
        XCTAssert(USDtest.currency == "USD")
        let GBPtest = Money(amount: 55, currency: "USD").add(Money(amount: 66, currency: "GBP"))
        XCTAssert(GBPtest.amount == Int(93.5))
        XCTAssert(GBPtest.currency == "GBP")
        //subtract
        let EURtest = Money(amount: 66, currency: "EUR").subtract(Money(amount: 55, currency: "EUR"))
        XCTAssert(EURtest.amount == 11)
        XCTAssert(EURtest.currency == "EUR")
        let CANtest = Money(amount: 160, currency: "CAN").subtract(Money(amount: 55, currency: "GBP"))
        XCTAssert(CANtest.amount == 9)
        XCTAssert(CANtest.currency == "GBP")
    }
    
    func testDouble() {
        let USDtest = 10.0.USD
        XCTAssert(USDtest.amount == 10)
        XCTAssert(USDtest.currency == "USD")
        let GBPtest = 33.29.GBP
        XCTAssert(GBPtest.amount == 33)
        XCTAssert(GBPtest.currency == "GBP")
        let EURtest = 54.4.EUR
        XCTAssert(EURtest.amount == 54)
        XCTAssert(EURtest.currency == "EUR")
        let CANtest = 33.2543.CAN
        XCTAssert(CANtest.amount == 33)
        XCTAssert(CANtest.currency == "CAN")
    }
    
}
