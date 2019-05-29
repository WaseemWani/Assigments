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
    case absentOnDay(String)
    case notEightyPercent(String)
    case notCompletedYear(String)
    case noHotcompetency(String)
    
   var errorDiscription: String {
        switch self {
         case .notEightyPercent(let name): return("\(name) has not eighty percent attendance")

         case .notCompletedYear(let name): return ("\(name) has not completed a year with us")

         case .noHotcompetency(let name): return ("\(name) is in the competency that does not fall in bonus program")

         case .absentOnDay(let name): return ("\(name) is absent today")
    }
  }
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
    
           let  employees: [Employee] = [ Employee(empID: 320, empName: "Muskan", empEmail: "muskaan@tothenew.com", joiningDate: 2019, competency: "iOS", attendancePercent: 40, isPresent: false),
            Employee(empID: 321, empName: "Mithlesh", empEmail: "mithlesh@tothenew.com", joiningDate: 2017, competency: "java", attendancePercent: 80, isPresent: true),
            Employee(empID: 323, empName: "Ankit", empEmail: "ankit@tothenew.com", joiningDate: 2017, competency: "Android", attendancePercent: 80, isPresent: true),
            Employee(empID: 324, empName: "Sachin", empEmail: "sachin@tothenew.com", joiningDate: 2019, competency: "iOS", attendancePercent: 81, isPresent: true) ,
            Employee(empID: 326, empName: "Merry", empEmail: "merry@tothenew.com", joiningDate: 2015 , competency: "java", attendancePercent: 95, isPresent: true) ]
        
    func allowedForBonus( email: String) throws {
        let currentYear = 2019
        let employee = employees.filter { $0.empEmail == email }
        //print(employee)
        
               if (employee[0].isPresent != true)  {
                  //print(employee[0].empName)
                  throw BonusError.absentOnDay(employee[0].empName)
               }
        
               if (employee[0].attendancePercent < 80) {
                   throw BonusError.notEightyPercent(employee[0].empName)
               }
     
               if(currentYear - employee[0].joiningDate <= 0 ) {
                   throw BonusError.notCompletedYear(employee[0].empName)
               }
     
        
               if((employee[0].competency != "iOS" || employee[0].competency != "Bigdata" || employee[0].competency != "Android" || employee[0].competency != "AI")) {
                   print("eligible for bonus")
                 throw BonusError.noHotcompetency(employee[0].empName)
               }
        
         else {
                print("\(employee[0].empName) is eligible for bonus")
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
 catch {
    
    if let er = error as? BonusError{
        
        switch er {
        case .absentOnDay:
            print(er.errorDiscription)
        case .notEightyPercent:
            print(er.errorDiscription)
        case .notCompletedYear:
            print(er.errorDiscription)
        case .noHotcompetency:
            print(er.errorDiscription)
        }
    }
}

do {
    try bonusProg.allowedForBonus(email: "merry@tothenew.com")
}
catch {
    if let er = error as? BonusError {
    switch er {
    case BonusError.notEightyPercent:
        print(er.errorDiscription)
        
    case .notCompletedYear:
    print(er.errorDiscription)

    case .absentOnDay:
    print(er.errorDiscription)
    
    case .noHotcompetency:
        print(er.errorDiscription)
      }
   }
}

do
 {
    try bonusProg.allowedForBonus(email: "mithlesh@tothenew.com")
 }
catch {
    if let er = error as? BonusError {
        switch er {
        case BonusError.notEightyPercent:
            print(er.errorDiscription)
            
        case .notCompletedYear:
            print(er.errorDiscription)
            
        case .absentOnDay:
            print(er.errorDiscription)
            
        case .noHotcompetency:
            print(er.errorDiscription)
        }
    }
}

