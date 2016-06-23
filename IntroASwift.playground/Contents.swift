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

//: ## Funciones de alto nivel

typealias IntToIntFunc = (Int)->Int

var z : IntToIntFunc

// Funciones como parámetros
func apply(f: IntToIntFunc, n:Int)->Int{
    return f(n)
}

func doubler(a:Int)->Int{
    return a * 2
}

func add42(a:Int) -> Int{
    return a+42
}

apply(doubler,n:4)
apply(add42,n:3)

// Funciones como valores de retorno

func compose(f: IntToIntFunc,
             _ h:IntToIntFunc) -> IntToIntFunc{
    // funciones dentro de funciones
    func comp(a:Int) -> Int{
        return f(h(a))
    }
    return comp
}

compose(add42,doubler)(8)

let comp = compose(add42,doubler)

comp(8)

// Funciones del mismo tipo en un array
let funcs = [add42,doubler,comp]

for f in funcs{
    f(33)
}

//: ## Closure Syntax (representacion literal de funciones)

func g(a:Int)->Int{
    return a+42;
}
// Literal
let gg = {(a:Int) -> Int in
    return a+42
}

g(1)
gg(1)

// Sintaxis simplificada de clausuras
let closures = [g,
                {(a:Int)->Int in return a - 42},
                {a in return a+45},
                {a in a/42},
                {$0 * 42}
]

//: Operadores

typealias BinaryFunc = (Int,Int)->Int
let applier = {(f: BinaryFunc, m: Int, n:Int) -> Int
                    in
    return f(m,n)
}

applier(*,2,4)

//Trailing closure

func applierInv(m:Int,_ n:Int,f:BinaryFunc) ->Int{
    return applier(f,m,n)
}

let c = applierInv (2, 4, f: {$0 * 2+$1*3})

// 100% equivalente a :
let cc=applierInv(2,4){
    return $0 * 2+$1*3
}

//:  ## Optionals

//empaqueto algo dentro de un opcional
var maybeAString: String? = "I'm boxed!"
var maybeInt: Int?
print(maybeAString)
print(maybeInt)

// Desempaquetado seguro

if let certainlyAString = maybeAString{
    print("Ya te decia yo que era una cadena")
    print(certainlyAString)
}

// desempaquetado por cojones
//var allaVoy = maybeInt!



//: Aggregate types: enums, structs, classes, tuples
enum LightSabreColor{
    case Blue, Red, Green, Purple
}

struct LightSabre{
    
    // static or "class" property (stored)
    static let quote = "An elegant weapon for a more civilized time"
    
    // Instance properties
    var color: LightSabreColor = .Blue {
        // Property observer
        willSet(newValue){
            print("About to change color to \(newValue)")
        }
    }
    
    var isDoubleBladed = false
}

class Jedi : CustomStringConvertible {
    // Si puedes dar valor por defecto, hazlo
    // Si no, crea un init
    // solo usa opcionales cuando sea indispensable
    // Stored properties
    var lightSabre = LightSabre()
    
    var name : String
    var midichlorians =  1_000
    
    var master  : Jedi?
    var padawan : Jedi?
    
    var description: String{
        get{
            return "Prueba"
        }
    }
    
    //computed property
    var fullName: String{
        get{
            var full = name
            if let m = master{
                full = full + " padawan of \(m.name)"
            }
            return full
        }
    }
    
    // Inicializadores
    init(name: String, midichlorians : Int, lightSabre: LightSabre,
         master: Jedi?, padawan: Jedi?){
        
        // Usando patern matching
        (self.name,self.midichlorians,self.lightSabre)=(name,midichlorians,lightSabre)
        self.master = master
        self.padawan = padawan;
    }
    
    convenience init(name: String){
        self.init(name:name, midichlorians: 1000,
                  lightSabre: LightSabre(), master:nil,padawan: nil)
    }
    
    convenience init(masterName name: String){
        self.init(name: name,midichlorians: 10_000,
                  lightSabre: LightSabre(color: .Green,isDoubleBladed:false),
                  master: nil, padawan: nil)
    }
    
    // Regular method
    func totalMidichlorians() -> Int{
        var total = midichlorians
        
        //Optional chaining
        if let masterMidichlorians = master?.midichlorians{
            total = total + masterMidichlorians
        }
        return total
    }
}

let luke = Jedi(masterName: "Luke Skywalker")

// Inheritance

class Sith : Jedi{
    convenience init(name: String){
        self.init(name:name, midichlorians: 1000,
                  lightSabre: LightSabre(color: .Red, isDoubleBladed: true),
                  master:nil,padawan: nil)
    }

}

//: Extensions
typealias Euro = Double
extension Euro{
    var €: Double{return self}
    var $: Double{return self*0.7}
}

var totalEuros = 123.€ + 45.09.$

typealias Task = () -> ()
extension Int{
    func times(task: Task){
        for _ in 1...self{
            task()
        }
    }
}

4.times({
    print("My name is Groot")
})


//: Nil y la tupla

// 2-tuples
(2,"hola")

// tuplas 3-tupla dentro de tuplas
(45,("Hola", NSDate()),45)

//¿hay tupla con un elemento? Es el elemento
(2) == 2

//¿Cual es la tupla vacia?
// Representa a nil
//() también se representa como void
// Void -> No hay valor
// nil -> Existe el valor pero no lo tengo o es incorrecto
func p(){
    print("Hola mundo")
}

func pp()->(){
    print("Hola Mundo")
}

//: Averiguar tipo en tiempo de ejecucion
43.9.dynamicType

//: ## Gestión de errores
// Palabrejas: try,throw, catch, do

// Toda función que pueda generar un error, está marcada con throw
// Toda función que lanza un error, se llama con try

let err : ErrorType

func inverse(n: Double) throws -> Double{
   guard n != 0 else {
        throw NSError(domain: "Divide by Zero", code: 42, userInfo: nil)
    }
    
    return 1/n
}

do{
    let inv = try inverse(4)
    print("\(inv)")
    
}catch{
    print("La cagamos")
}
// Variaciones deltro del try
// Que lo haga por cojones
//try! inverse(0)
// opcional
try? inverse(20)

