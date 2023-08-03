//
//  SVMTests.swift
//  SVMTests
//
//  Created by Alex on 28/07/23.
//

import XCTest
@testable import SVM

final class SVMTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testClassReader() throws {
        
        let fileManager = FileManager.default
        
        // Get the URL of the desktop directory
        guard let desktopURL = fileManager.urls(for: .desktopDirectory, in: .userDomainMask).first else {
            print("Unable to access the desktop directory.")
            return
        }
        
        let jarUrl = desktopURL.appendingPathComponent("EscPosPrinter.jar")
        
        let loader = JarLoader()
        
        let result = loader.load(url: jarUrl)
        
        print("Load result: \(result)")
        
        
        for entry in loader.entries {
            
            if entry.package.isEmpty {
                continue
            }
            
            let clazz = entry.read()
            
            print("\(clazz.name) minor: \(clazz.minorVersion) mayor: \(clazz.mayorVersion)")
        }
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
