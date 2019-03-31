import UIKit

//var str = "Hello, playground"

//:   Q2: 'Self' in protocols is used for conditional adoption of protocols,  i.e. we can restrict a protocol to be applicable to certain types only using Self keyword. Here Self refers to types such as class, struct, enum, that conrom to a protocol.we can put this constraint on protocol by using Self and where keywords. Where as the self(lowercase) is used to refer to the value inside the type such as class, struct etc.


//: Q3: Write a generic function that takes two operand and combine them.  Example = add(1 + 1), add(1.0 + 1.0), add(Ankit + nigam)

protocol AddableProtocol {
    static func +(oneOperand: Self, anotherOperand: Self) -> Self
}

extension Int: AddableProtocol{}
extension Double: AddableProtocol{}
extension String: AddableProtocol{}

func add<T: AddableProtocol>(_ op1: T, _ op2: T ) -> T {
    return op1+op2
}

let firstName = "waseem", lastName = "Wani"

print(add(firstName, lastName))

print(add(1, 1))


print(add(1.0, 1.0))
