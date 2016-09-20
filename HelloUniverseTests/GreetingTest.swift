//
//  GreetingTest.swift
//  HelloUniverse
//
//  Created by James Campagno on 8/3/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Quick
import Nimble
@testable import HelloUniverse

class GreetingTest: QuickSpec {
    override func spec() {
        
        describe("Greeting Class") { 
        
            let testGreeting = Greeting()
            
            describe("helloUniverse()") {
                it("Should return back the string 'Hello Universe'") {
                    
                    let actualResponse = testGreeting.helloUniverse()
                    let expectedResponse = "Hello Universe!"
                    
                    expect(actualResponse).to(equal(expectedResponse))
                    
                }
            }
        }
    }
}
