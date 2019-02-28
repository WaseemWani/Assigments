import UIKit

var str1 = "Hello, playground"

// Question 1:
// What is Error Protocol. Create a custom error conforming to error protocol.

//error portocol
protocol Error {
}

// creating a custom error conforming to error protocol


enum ErrorHandler: Error {
    case invalidId
    case invalidName
    switch let error:ErrorHandler {
    case invalidId:
    print("invalid Id")
    case invalidName:
    print("invalid Name")
    }
}

func display(name: String, Id: Int) {
    if (name.contains("@#")) {
        ErrorHandler.invalidName
    }
}
display(name: "waseem##", Id: 1)
