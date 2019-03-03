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




//:  Question 2: Write a failable initialiser for a class which throws a error  “Object not able to initialise” description a initialisationFailed case, Catch the error and print its error description.

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

class Student {
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
print("\n--------------------------------------------------------------------")
print("Question 2. Error handling, difference between try, try? and try!")
print("--------------------------------------------------------------------")

   
//  do {
//            let student1 = try Student("waseem",-22, email: "abc")
//        }
//        catch PotentialErrors.invalidEmailId {
//            print("invalid email ID")
//        }
//     catch PotentialErrors.invalidAge {
//    print("age can not be less tha n or equal to zero")
//}
// //print(Date())
////print(date)
let student2 = try? Student( "akhil mittal", -2, email: "abc")

 let student33 = try! Student( "wani", 3, email: "abcc@example.com" )


//: Question3. Write a program which loads the data from a datasource of 10 employees looks like below, Program would help to give salary bonus to employees. Which is based on some conditions but if employee is not able to satisfy the condition program should throw the error with specific error condition and its description should be printed.
enum BonusError: Error {
    case absentOnDay
    case notEightyPercent
    case notCompletedYear
    case noHotcompetency
}




class BonusProgram  {
    
    
    struct Employee {
        
        var empID: String
        var empName: String
        var empEmail: String
        var joiningDate: Date
        var competency: String
        var attendancePercent: Float
        var isPresent:Bool
        
        init(empID: String, empName: String, empEmail:String, joiningDate: Date, competency: String, attendancePercent: Float, isPresent: Bool) {
            self.empID = empID
            self.empName = empName
            self.empEmail = empEmail
            self.competency = competency
            self.joiningDate = joiningDate
            self.attendancePercent = attendancePercent
            self.isPresent = isPresent
            
        }
    }
    
    
    func allowedForBonus( _ email: String) throws -> Bool {
//        var currentDate = DateFormatter()
//        currentDate.dateFormat = "dd/MM/yyyy"
//        currentDate = DateFormatter.date(DateFormatter())
//
        
//        for emp in employees
//        {
            if (self.empEmail == email)
            {
              if (self.isPresent != true)  {
                throw BonusError.absentOnDay
              }
              else if (self.attendancePercent < 80) {
                 throw BonusError.notEightyPercent
             }
        
//        else if(self.joiningDate - Date() < 1) {
//            throw BonusError.notCompletedYear
//        }
//
            else {
              return true
            }      //if (self.joiningDate)
          }
         else {
           print(" employee not found by this mail")
            }
      }
  }


let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "dd/MM/yyyy"

let emp1 = BonusProgram.Employee(empID: "1", empName: "waseem", empEmail: "waseem.ahmed@tothenew.com", joiningDate: dateFormatter.date(from: "01/02/2012")!, competency: "iOS", attendancePercent: 90, isPresent: true)
let emp2 = BonusProgram.Employee(empID: "2", empName: "utkarsh", empEmail: "utkarsh@tothenew.com", joiningDate: dateFormatter.date(from: "01/02/2019")!, competency: "iOS", attendancePercent: 70, isPresent: true)
let emp3 = BonusProgram.Employee(empID: "3", empName: "abhishek", empEmail: "abhishek@tothenew.com", joiningDate: dateFormatter.date(from: "01/02/2018")!, competency: "iOS", attendancePercent: 70, isPresent: true)

let employees = [emp1, emp2, emp3]

print("\n--------------------------------------------------------------------")
print("Question 3. Error handling.Bonus Program")
print("--------------------------------------------------------------------")

let bonusProg = BonusProgram()
print(bonusProg)
do {
    try bonusProg.allowedForBonus("waseem.ahmed@tothenew.com")
}
   
    catch BonusError.absentOnDay {
        print("\(bonusProg.empName)not presen today")
}
    catch BonusError.notEightyPercent {
        print("\(bonusProg.empName) has not 80% attendence")
}

catch BonusError.notCompletedYear {
    print("\(bonusProg.empName) has not completed a year yet")
}
