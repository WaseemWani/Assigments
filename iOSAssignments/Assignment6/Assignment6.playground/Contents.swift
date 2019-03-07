import UIKit

//var str1 = "Hello, playground"
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
do {
    let person1 = try Person("Nitin", -1)
}
catch Initialisation.initialisationFailed {
     print("not able to initailise the object")
}


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

   
  do {
            let student1 = try Student("waseem",-22, email: "abc")
        }
        catch PotentialErrors.invalidEmailId {
            print("invalid email ID")
        }
     catch PotentialErrors.invalidAge {
    print("age can not be less than or equal to zero")
}

 let student2 = try? Student( "akhil mittal", -2, email: "abc")

//:  try! is used without an do - catch block. It returns a normal type. If the code throws an error, it will crash. Because the returned type will be nil and a normal type cannot handle nil.
 let student33 = try! Student( "wani", 3, email: "abcc@example.com" )


//: Question3. Write a program which loads the data from a datasource of 10 employees looks like below, Program would help to give salary bonus to employees. Which is based on some conditions but if employee is not able to satisfy the condition program should throw the error with specific error condition and its description should be printed.
enum BonusError: Error {
    case absentOnDay(str: String)
    case notEightyPercent(str: String)
    case notCompletedYear(str: String)
    case noHotcompetency(str: String)
}

struct Employee {
        
        var empID: Int
        var empName: String
        var empEmail: String
        var joiningDate: Int
        var competency: String
        var attendancePercent: Float
        var isPresent:Bool
}
        
class BonusProgram {
    
            let  employees: [Employee] = [ Employee(empID: 320, empName: "Muskan", empEmail: "muskaan@tothenew.com", joiningDate: 2019, competency: "iOS", attendancePercent: 90, isPresent: true),
            Employee(empID: 321, empName: "Mithlesh", empEmail: "mithlesh@tothenew.com", joiningDate: 2017, competency: "java", attendancePercent: 80, isPresent: true),
            Employee(empID: 323, empName: "Ankit", empEmail: "ankit@tothenew.com", joiningDate: 2017, competency: "Android", attendancePercent: 80, isPresent: true),
            Employee(empID: 324, empName: "Sachin", empEmail: "sachin@tothenew.com", joiningDate: 2019, competency: "iOS", attendancePercent: 81, isPresent: true) ,
            Employee(empID: 325, empName: "Muskan", empEmail: "muskaan@tothenew.com", joiningDate: 2018 , competency: "iOS", attendancePercent: 89, isPresent: false) ,
            Employee(empID: 326, empName: "Merry", empEmail: "merry@tothenew.com", joiningDate: 2015 , competency: "iOS", attendancePercent: 95, isPresent: true) ]
        
    func allowedForBonus( email: String) throws{
        var eligibility: Bool = true, currentYear = 2019
        
        for emp in employees
        {
            if (emp.empEmail == email)
            {

               if (emp.isPresent != true)  {
                     eligibility = false
                  print(emp.empName)
                throw BonusError.absentOnDay(str: emp.empName)
                
                 }
               else {
                  eligibility = true
                 }
        
               if (emp.attendancePercent < 80) {
                     eligibility = false
                throw BonusError.notEightyPercent(str: emp.empName)
                 }
               else {
                 eligibility = false
                }
        
               if(currentYear - emp.joiningDate <= 0 ) {
                   eligibility = false
                throw BonusError.notCompletedYear(str: emp.empName)
                
                }
               else {
               eligibility = true
               }
        
        
              if(emp.competency == "iOS" || emp.competency == "Bigdata" || emp.competency == "Android" || emp.competency == "AI") {
                    eligibility = true
                
                }
              else {
                 eligibility = false
                 throw BonusError.noHotcompetency(str: emp.empName)
                }
            
        
              if(eligibility == true) {
              print(emp.empName,"eligible for bonus")
                }
              }
        }
    }
 }

print("\n--------------------------------------------------------------------")
print("Question 3. Error handling. Bonus Program")
print("--------------------------------------------------------------------")

let bonusProg = BonusProgram()

do {
    try bonusProg.allowedForBonus(email: "muskaan@tothenew.com")
  }
 catch BonusError.absentOnDay(let name) {
      print("\(name)is absent today")
}

catch BonusError.notCompletedYear(let name) {
    print("\(name) has not completed a year yet")
}

catch BonusError.notEightyPercent(let name) {
    print("\(name) has not 80% attendence")
}
catch BonusError.noHotcompetency(let name) {
    print("\(name) is not in a comptency falling under bonus program")
}

do {
    try bonusProg.allowedForBonus(email: "ankit@tothenew.com")
}
catch BonusError.notEightyPercent(let name){
        print("\(name) has not 80% attendence")
}
catch BonusError.notCompletedYear(let name){
    //print(error)
    print("\(name) has not completed a year yet")
}
catch BonusError.absentOnDay(let name) {
    print("\(name)is absent today")
}
catch BonusError.noHotcompetency(let name) {
    print("\(name) is not in a comptency falling under bonus program")
}


do
 {
    try bonusProg.allowedForBonus(email: "mithlesh@tothenew.com")
 }
catch BonusError.absentOnDay(let name) {
    print("\(name)is absent today")
}
catch BonusError.notCompletedYear(let name){
    //print(error)
    print("\(name) has not completed a year yet")
}
catch BonusError.notEightyPercent(let name) {
    print("\(name) has not 80% attendence")
}
catch BonusError.noHotcompetency(let name) {
    print("\(name) is not in a comptency falling under bonus program")
}
