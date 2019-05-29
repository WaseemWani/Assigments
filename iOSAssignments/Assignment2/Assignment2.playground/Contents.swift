import UIKit

var str = "Hello! this is swift Exercise 2"
print(str)
//:##  Exercise 2

//  structure employee for personal information
struct EmpPersonal{
    var employeeID : Int
    var name :    String
    var country : String
    var address : String
    var hobbies : String?
    
    
}

// declaring an array of type EmpPersonal Struct
var empPersonalArray: [EmpPersonal] = []

// adding entries into the empPersnalArray
empPersonalArray.append(EmpPersonal(employeeID: 101, name: "Utkarsh", country: "India", address: "Varanasi", hobbies: "cooking"))
empPersonalArray.append(EmpPersonal(employeeID: 102, name: "Ashish",  country: "China", address: "Beijing", hobbies: "cricket"))
empPersonalArray.append(EmpPersonal(employeeID: 103, name: "Shinzo", country:  "Japan", address: "Kyoto", hobbies: "reading"))
empPersonalArray.append(EmpPersonal(employeeID: 104, name: "Abhishek", country: "America", address: "Chicago", hobbies: "writing"))
empPersonalArray.append(EmpPersonal(employeeID: 106, name: "Taran Singh", country: "Japan", address: "Tokyo", hobbies: nil))


 //   creating employee professional structure
struct EmpProfessional{
    var employeeID:  Int
    var name:        String
    var department:  String
    var branch:      String
    var experience : String
}


//  declaring an array of type EmpProfessional struct
var empProfessionalArray: [EmpProfessional] = []

//   adding data enries into EmpProfessionalArray
empProfessionalArray.append(EmpProfessional(employeeID: 101, name: "Utkarsh", department: "iOS", branch: "India", experience: "1year"))
empProfessionalArray.append(EmpProfessional(employeeID: 102, name: "Ashish", department: "JVM", branch: "China", experience: "2year"))
empProfessionalArray.append(EmpProfessional(employeeID: 104, name: "Abhishek", department: "Android", branch: "America", experience: "1year"))
empProfessionalArray.append(EmpProfessional(employeeID: 106, name: "Taran Singh", department: "DevOps", branch: "Japan", experience: "3year"))

//:Question 1. create a third employee structure that contains the information from both based on common id.
struct EmployeeCommon {
    var employeeID: Int
    var name: String
    var address: String
    var country: String
    var department: String
    var branch: String
    var experience: String
    var hobbies: String?
}

//  declaring an array of type EmployeeCommon struct
var empCommonArray: [EmployeeCommon] = []

//     adding entries into structure from the EmployeePersonal and EmployeeProfessional structures based on common ID
for empPersonalInfo in empPersonalArray {
    for empProfessionalInfo in empProfessionalArray {
        if (empPersonalInfo.employeeID == empProfessionalInfo.employeeID) {
            empCommonArray.append(EmployeeCommon(employeeID: empPersonalInfo.employeeID, name: empPersonalInfo.name, address: empPersonalInfo.address, country: empPersonalInfo.country, department: empProfessionalInfo.department, branch: empProfessionalInfo.branch, experience: empProfessionalInfo.experience, hobbies: empPersonalInfo.hobbies))
        }
    }
    
}

//   printing the results onto the console
print("\n ----------------------------------\n ")
print("answer to Question 1: employees from two structures having common ID")
print("\n ----------------------------------\n ")
for emp in empCommonArray {
    print(emp)
    print("\n")
}
//print("\n ----------------------------------\n ")




//:   Question 2. Write a function that takes the two structure and gives a list of all the employee that live in certain country
func findEmployeesByCountry(country: String) {
    print("\n ----------------------------------\n ")
    print("answer to Question 2: employees from two structures having common ID and live in a certain country")
    print("\n ----------------------------------\n ")
    for empPersonal in empPersonalArray {
        for empProfessional in empProfessionalArray {
            if (empPersonal.employeeID == empProfessional.employeeID && empPersonal.country == country) {
                print(empPersonal)
            }
        }
        
    }
}
findEmployeesByCountry(country:"Japan")



//:  Question3. write a function that give me list of all the employee that live in certain department
func findSameDepartment(department: String)  {
    print("\n ----------------------------------\n ")
    print("answer to Question 3: employees having a certain deprtment")
    print("\n ----------------------------------\n ")
    for employee in empCommonArray {
            if (employee.department == department) {
                print(employee)
            }
    }
}
findSameDepartment(department: "iOS")



//:  Question4. write a function that give me list of all the employee that live in same country and work in the same branch.

func findEmployeesBySameBranchCountry() {
    for employee in empCommonArray {
            if employee.branch == employee.country {
            print(employee)
        }
    }
  }

print("\n ----------------------------------\n ")
print("answer to Question 4: employees having a same branch and country")
print("\n ----------------------------------\n ")
findEmployeesBySameBranchCountry()



//:   Question 5. write a function that returns me list of all the employee name that has a hobby and with their experience
func findEmpHavingHobby() {
    for employee in empCommonArray {
        if employee.hobbies != nil {
            print("Name: \(employee.name)   ", "department:  \(employee.department)  ", "hobbies:    \(employee.hobbies!)   ")
            
        }
    }
    
}
print("\n ----------------------------------\n ")
print("answer to Question 5: employees having a hobby")
print("\n ----------------------------------\n ")
findEmpHavingHobby()



//:    Question 6. write a function that return me list of all the employee name that starts with any “S”

func empNameBeginWithS(prefix: String) {
    for employee in empCommonArray {
        if employee.name.prefix(1) == prefix {
            print(employee)
        }
        if employee.name.prefix(1) != prefix {
            print( "there is no employee whose name starts with 'S' in the available list" )
            break
        }
        }
    
}
print("\n ----------------------------------\n ")
print("answer to Question 6: employees name starting with S")
print("\n ----------------------------------\n ")

empNameBeginWithS(prefix: "S")

print("\n++++++++++++***********+++++++++++++++\n ")
print("\t\t THANK YOU 😊 ")
print("\n++++++++++++***********+++++++++++++++\n ")
