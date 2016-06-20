/*:
 # Intro a Swift
 
 */
import Foundation

//: ## variables y constantes
var size : Float = 42.0
var answer = 42

let name = "Anakin"

//: ## Todo es un objeto
Int.max
Double.abs(-42.0);

//: ## conversiones

let a = Int(size)
let ans = String(answer)

//: ## typealias: sirve para dar otros nombres a un tipo
typealias Integer = Int

let a1: Integer = 45

//: ## Colecciones
var swift = "Nuevo lenguaje de Apple"
swift = swift + "!"

var words = ["uno","dos","tres","cuatro"]
words[0]
let numberNames = [1: "uno",2: "dos"]
numberNames[1]

//: ## Iterar

var total = ""
for element in [1,2,3,4,5,6,7]{
    total = "\(total) \(element)"
}
print (total)

for (key,value) in numberNames{
    print("\(key) -- \(value)")
}

// Tupla
let pair = (1,"one")
pair.0
pair.1

// Range
for i in 1...5 {
    print(i)
}

for i in 1..<5{
    print(i)
}

//: ## Funciones

// Esto es lo recomendado
func h(perico a:Int, deLosPalotes b:Int) -> Int{
    return (a + b) * a
}

h(perico:3,deLosPalotes:4)

func f(a:Int, _ b:Int) -> Int{
    return (a + b)
}

f(3,4)

// Ejemplo real, suma dos numeros y multiplica por un tercero

func sum(a:Int, _ b:Int, thenMultiplyBy c:Int) -> Int{
    return (a+b)*c
}

sum(3,4,thenMultiplyBy: 5)

// Default values
func addSuffixTo(a:String, suffix:String = "ingly") ->String{
    return a + suffix
}

addSuffixTo("pepito")
addSuffixTo("Objetive-",suffix: "C")

// Return values
func namesOfNumbers(a:Int) -> (Int,String,String){
    var val: (Int,String,String)
    switch a {
    case 1:
        val = (1,"one","uno")
    case 2:
        val = (2,"two","dos")
    default:
        val = (a, "Go check Google Translator","vete a google a buscar")
    }
    return val
}

let r = namesOfNumbers(3)

let (_,en,es)=namesOfNumbers(1)
print(en,es)














