import UIKit

var str = "Hello, this is exercise 4"
print(str)

//: Question 1. Write a function called siftBeans(fromGroceryList:) that takes a grocery list (as an array of strings) and “sifts out” the beans from the other groceries. The function should take one argument that has a parameter name called list, and it should return a named tuple of the type (beans:[String], otherGroceries: [String]).

let groceryList: [String] =  ["green beans","milk","black beans","pinto beans","apples"]
var beans: [String] = []
var otherGroceryItems: [String] = []
func siftBeans(fromGroceryList: [String]) -> (beans:[String],otherItems:[String]) {
    
    for item in fromGroceryList {
        if ( item.contains("beans") ) {
          beans.append(item)
         }
        else {
            otherGroceryItems.append(item)
        }
    }
    return (beans, otherGroceryItems)
}

let result = siftBeans(fromGroceryList: groceryList)
print("\n Question 1. Sif Beans from grocery")
print("-------------------------------------------------------------")
print("\n beans")
print(result.beans)
print("\n other grocery items")
print(result.otherItems)


//:  Question 2.(Part 1). Make a calculator class with a function name “equals” that take a enum case as value like multiply, subtraction, addition, square root, division.

class Calculator {
    
    var oneOperand: Double, anotherOperand: Double
    init(oneOperand: Double, anotherOperand: Double) {
        self.oneOperand = oneOperand
        self.anotherOperand = anotherOperand
    }
    
enum Operations {
    case multiply(Double, Double)
    case subtraction(Double, Double)
    case addition(Double, Double)
    case squareRoot(Double)
    case division(Double,Double)
    }
    
    
    // function perfoming different operations
    func equals(operation: Operations ) -> Double {
        
        switch operation {
        case .multiply(let oneOperand,let anotherOperand):
            print("multiplication of two numbers:")
            return(oneOperand * anotherOperand)
        
        case .subtraction(let oneOperand, let anotherOperand):
            print("subtraction of two numbers:")
            return(oneOperand - anotherOperand)
        
        case .addition(let oneOperand, let anotherOperand):
            print("addition of two numbers:")
            return(oneOperand + anotherOperand)
        
        case .squareRoot(let oneOperand):
           print("sqaureRoot:")
           return(oneOperand.squareRoot())
        
        case .division(let oneOperand,let anotherOperand):
            
            if(anotherOperand > 0)
            {
                print("division: ")
                return(oneOperand / anotherOperand)
            }
        
            else {
             print("division by zero error")
               return 0
            }
        
//        default:
//            print("not a an operation")
//            return 0
//
        }
  }
}


let calObj = Calculator(oneOperand: 2.0, anotherOperand: 4.0)
print("\n Question 2. Calculator")
print("-------------------------------------------------------------\n")
print("perfroming an operation by calcultor...")

let resultCal = calObj.equals(operation: .multiply(calObj.oneOperand, calObj.anotherOperand))
print(resultCal)

//:  Question 2.(Part 2) using function as argunments, in struct

class ApnaCalculator {
    
    var operand1: Double, operand2: Double
    init(operand1: Double, operand2: Double) {
        self.operand1 = operand1
        self.operand2 = operand2
    }
    
    func calEquals(_ calcFunc: (Double, Double) -> Double, _ operand1: Double, _ operand2: Double ) -> Double {
        
        
        return calcFunc(operand1, operand2)
    }

 struct CalculatorStruct {
    
     func add(operand1: Double, operand2: Double) -> Double {
        return operand1 + operand2
    }
    
     func subtract(operand1: Double, operand2: Double) -> Double {
        return operand1 - operand2
   }
    
    func multiply(operand1: Double, operand2: Double) -> Double {
        if (operand1 > 0) {
          return operand1 / operand2
        }
        else {
        print("division by zero")
            return 0
       }
    }
         func sqrRoot(operand1: Double, operand2: Double) -> Double {
            return(operand1.squareRoot())
      }
}
}
var objCal = ApnaCalculator(operand1: 1, operand2: 2)
var structObj = ApnaCalculator.CalculatorStruct()
let result2 = objCal.calEquals(structObj.sqrRoot, objCal.operand1,  objCal.operand2)
print("-------------------------------------------------------------")
print("perfroming an operation by calcultor by passing fucntion as parameter... \n")
print("result of performed operation is: \(result2)")


//:   Question 3 was omitted

print("-------------------------------------------------------------")
print("Thank You 😊")
print("-------------------------------------------------------------")
