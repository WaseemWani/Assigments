import UIKit

var str1 = "Hello, playground"
//:## Exercise 6
//:  Question 1:
//:  What is Error Protocol. Create a custom error conforming to error protocol.

//error portocol

//protocol Error {
//}

// creating a custom error conforming to error protocol


enum ErrorHandler: Error {
    case invalidId
    case invalidName
}
//var error:ErrorHandler

//switch error {
//        case .invalidId:
//            print("invalid Id")
//
//        case .invalidName:
//            print("invalid Name")
//    }

func display(name: String, Id: Int) throws {
    
    if (name == "") {
       throw ErrorHandler.invalidName
    }
    
    else if (Id <= 0)
    {
        throw ErrorHandler.invalidId
    }
}

print("--------------------------------------------------------------------")
print("Question 1. Error handling")
print("--------------------------------------------------------------------")

do {
    try display(name: "Waseem", Id: 0)
}
catch ErrorHandler.invalidName {
    print("name can not be  empty")
}
catch ErrorHandler.invalidId {
    print("Id entered is not a valid ID")
}




//  Question 2: Write a failable initialiser for a class which throws a error  “Object not able to initialise” description a initialisationFailed case, Catch the error and print its error description.

enum Initialisation: Error {
    case initialisationFailed
}
// var switchinVar:Initialisation

class Person {
   var name: String
   var age: Int
   
    init?( _ name: String, _ age: Int) throws {
        if age < 0 {
       throw Initialisation.initialisationFailed
//        return nil
        }
        else {
            self.name = name
             self.age = age
        }
}
}
//do {
//    let person1 = try Person("Nitin", -1)
//}
//catch Initialisation.initialisationFailed {
//     print("not able to initailise the object")
//}


//: Question 3. Explain the difference try, try?, try! , make sure to write a program to explain the difference.
//:  try is used in do - catch block, with th potential error throwing code.

enum PotentialErrors: Error {
    case invalidEmailId
    case invalidAge
}

class Employee {
    var name: String
    var email: String
    var age: Int
    
    init?(_ name: String, _ age: Int, email: String) throws{
          //super.init(name, age)
        
        if (email.contains("@") && age > 0) {
            self.name = name
            self.age = age
            self.email = email
        }
        else if age < 0 {
            throw PotentialErrors.invalidAge
        }
            
        else {
            throw PotentialErrors.invalidEmailId
        }
    }
}
 
//: try? is used without do -  catch block. It retruns an optional type, if the code with try? throws an error it returns nil
        
   
  do {
            let emp1 = try Employee("waseem",-22, email: "abc")
        }
        catch PotentialErrors.invalidEmailId {
            print("invalid email ID")
        }
     catch PotentialErrors.invalidAge {
    print("age can not be less tha n or equal to zero")
}

let emp2 = try? Employee( "akhil mittal", -2, email: "abc")

 let emp3 = try! Employee( "wani", 3, email: "abcc@example.com" )


//: Question3. Write a program which loads the data from a datasource of 10 employees looks like below, Program would help to give salary bonus to employees. Which is based on some conditions but if employee is not able to satisfy the condition program should throw the error with specific error condition and its description should be printed.


