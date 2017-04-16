//
//  main.swift
//  ExtDomainModel
//
//  Created by Vicky Juan on 4/14/17.
//  Copyright © 2017 Vicky Juan. All rights reserved.
//

import Foundation

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

protocol CustomStringConvertible {
    var description: String { get }
}

protocol Mathematics {
    func add(_ add : Money) -> Money
    func subtract(_ remove: Money) -> Money
}

extension Double {
    var USD: Money {return Money(amount: Int(self), currency: "USD")}
    var EUR: Money {return Money(amount: Int(self), currency: "EUR")}
    var GBP: Money {return Money(amount: Int(self), currency: "GBP")}
    var CAN: Money {return Money(amount: Int(self), currency: "CAN")}
}

////////////////////////////////////
// Money
//
public struct Money {
    public var amount : Int
    public var currency : String
    
    var description: String { return "\(currency)\(Double(amount))" }
    
    public func convert(_ to: String) -> Money {
        if currency == "USD"{
            if to == "GBP" {
                return Money(amount: self.amount * 5 / 10, currency: "GBP");
            }else if to == "EUR" {
                return Money(amount: self.amount * 15 / 10, currency: "EUR");
            }else {
                return Money(amount: self.amount * 125 / 100, currency: "CAN");
            }
        }else if currency == "GBP"{
            if to == "USD" {
                return Money(amount: self.amount * 2, currency: "USD");
            }else if to == "EUR" {
                return Money(amount: self.amount * 3, currency: "EUR");
            }else {
                return Money(amount: self.amount * 25 / 10, currency: "CAN");
            }
        }else if currency == "EUR"{
            if to == "USD" {
                return Money(amount: self.amount / 3 * 2, currency: "USD");
            }else if to == "GBP" {
                return Money(amount: self.amount / 3, currency: "GBP");
            }else {
                return Money(amount: self.amount * 8 / 15, currency: "CAN");
            }
        }else if currency == "CAN"{
            if to == "USD" {
                return Money(amount: self.amount / 5 * 4, currency: "USD");
            }else if to == "GBP" {
                return Money(amount: self.amount / 5 * 2, currency: "GBP");
            }else {
                return Money(amount: self.amount / 5 * 6, currency: "EUR");
            }
        }
        return Money(amount: 0, currency: "")
    }
    
    public func add(_ to: Money) -> Money {
        if self.currency == to.currency {
            return Money(amount: (to.amount + self.amount), currency: to.currency)
        }
        return Money(amount: (to.amount + self.convert(to.currency).amount), currency: to.currency)
    }
    
    public func subtract(_ from: Money) -> Money {
        if self.currency == from.currency {
            return Money(amount: (self.amount - from.amount), currency: from.currency)
        }
        return Money(amount: (self.convert(from.currency).amount - from.amount), currency: from.currency)
    }
}

////////////////////////////////////
// Job
//
open class Job {
    fileprivate var title : String
    fileprivate var type : JobType
    
    var description: String {
        switch type {
        case .Hourly(let income) :
            return "\(title)\(income)"
        case .Salary(let income) :
            return "\(title)\(income)"
        }
    }

    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    open func calculateIncome(_ hours: Int) -> Int {
        switch self.type {
        case JobType.Hourly(let income):
            return Int(income * Double(hours))
        case JobType.Salary(let income):
            return income
        }
    }
    
    open func raise(_ amt : Double) {
        switch self.type {
        case JobType.Hourly(let originHourly):
            self.type = JobType.Hourly(amt + originHourly)
        case JobType.Salary(let originYearly):
            self.type = JobType.Salary(Int(amt) + originYearly)
        }
    }
}

////////////////////////////////////
// Person
//
open class Person {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    var description : String {
        return "\(firstName)\(lastName)\(age)"
    }
    
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get {
            return _job
        }
        set(value) {
            if self.age >= 16 {
                self._job = value
            }
        }
    }
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get {
            return _spouse
        }
        set(value) {
            if self.age >= 18 {
                self._spouse = value
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    open func toString() -> String {
        return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(job) spouse:\(spouse)]"
    }
}

////////////////////////////////////
// Family
//
open class Family {
    fileprivate var members : [Person] = []
    
    var description: String {
        var des = ""
        for member in members {
            des.append(member.description + " ")
        }
        return des
    }
    
    public init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            members.append(spouse1)
            members.append(spouse2)
        }
    }
    
    open func haveChild(_ child: Person) -> Bool {
        var legal = false
        for member in members {
            if member.age > 21 {
                legal = true
            }
        }
        if legal{
            members.append(child)
            return true
        }
        return false
    }
    
    open func householdIncome() -> Int {
        var totalIncome = 0
        for member in members {
            if member.job != nil {
                totalIncome += (member.job?.calculateIncome(2000))!
            }
        }
        return totalIncome
    }
}

