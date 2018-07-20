package main

import "fmt"

// const a int = xxxx + yyy

// var x *[4]int = 2

// var a [5]int

// func sum(nums ...int) {
//     fmt.Print(nums, " ")
//     total := 0
//     for _.(int), num := range nums {
//         total += num
//     }
//     fmt.Println(total)
// }

func main() {

    var a int = 3 - 3 + 2 * 3 / 1

    // Variadic functions can be called in the usual way
    // with individual arguments.
    // sum(1, 2)
    // sum(1, 2, 3)

    // If you already have multiple args in a slice,
    // apply them to a variadic function using
    // `func(slice...)` like this.
    //nums := []int{1, 2, 3, 4} // TODO: Composite literal
    // sum(nums...)
}


// // Go has built-in support for _multiple return values_.
// // This feature is used often in idiomatic Go, for example
// // to return both result and error values from a function.

// // The `(int, int)` in this function signature shows that
// // the function returns 2 `int`s.
// func vals() (int, int) {
//     return 3, 7
// }

// func semCorpo(x int) int{} 

// func main() {

//     // Here we use the 2 different return values from the
//     // call with _multiple assignment_.
//     a, b := vals()
//     fmt.Println(a)
//     fmt.Println(b)

//     // If you only want a subset of the returned values,
//     // use the blank identifier `_`.
//     _, c := vals()
//     fmt.Println(c)
// }


// var x chan<- chan int    // same as chan<- (chan int)
// var x chan<- <-chan int  // same as chan<- (<-chan int)
// var x <-chan <-chan int  // same as <-chan (<-chan int)
// var x chan (<-chan int)   // can only be used to receive ints


// var x [32]byte
// var x [2*N] struct { x, y int32 }
// var x [1000]*float64
// var x [3][5]int
// var x [2][2][2]float64  // same as [2]([2]([2]float64))

// type action func(a, b, x int, c int, k ...float64,) int

// type teste interface {
//         Read(b Buffer) bool
//         Write(b Buffer) bool
//         Close(); // right nullable
//     }

// type pessoa struct {
//     T1        // field name is T1
//     *T2       // field name is T2
//     P.T3      // field name is T3
//     *P.T4     // field name is T4
//     x, y int  // field names are x and y
//     z float64
// }

// const (
// 	bit0, mask0 = 1 << iota, 1<<iota - 1  // bit0 == 1, mask0 == 0  (iota == 0)
// 	bit1, mask1                           // bit1 == 2, mask1 == 1  (iota == 1)
// 	_, _                                  //                        (iota == 2, unused)
// 	bit3, mask3                          // bit3 == 8, mask3 == 7  (iota == 3)
// )

// type vazio struct {}

// type (
//     nodeList = [2]*Node  // nodeList and []*Node are identical types
//     Polar    = polar    // Polar and polar denote identical types
//     MIZERA = DDA
// )

// type NewMutex Mutex

// func plus(j int, b int) int {


//     // We'll iterate over 2 values in the `queue` channel.
//     queue := make(chan string, 2)
//     queue <- "one"
//     queue <- "two"
//     close(queue)

//     // This `range` iterates over each element as it's
//     // received from `queue`. Because we `close`d the
//     // channel above, the iteration terminates after
//     // receiving the 2 elements.
//     for elem := range queue {
//         fmt.Println(elem)
//     }


//     x := 2
// 	a = a,b,c

// 	for a > b {
// 		x = a
// 	}

//     //ACEITARIA TAMBEM 1 + 1 := 0. Checar com acao semantica
// 	for i := 0; i < 10; i++ {

// 		L:
// 		f(i)

// 		continue ;
// 	}

// 	fallthrough

// 	defer a

// 	go a <- b

// 	go (a+3) <- 8 * 3

// 	for ; a > b ; {
// 		break ;
// 	}

// 	for {}

// 	for i, s := range a {
// 		// type of i is int
// 		// type of s is string
// 		// s == a[i]
// 		g(i, s)
// 	}

// 	for key, val = range m {
// 		h(key, val)
// 	}

//     var x int = 1
//     var k, z float64 = -1, -2
//     var(k uint)
//     var (
//         u, v, s = 2.0, 3.0, "bar"
//         i, j int
//         ih float64
//         re, dskao, jdihs = 2.0, 3.0, "bar"
//     )
//     x = 3
//     return x
// }

// func plusPlus(a, b, c int) int {
//     1 << 3
//     x = 1
//     return a + b - c
// }

// func main() {

// //TODO: nAO ESTA FUNCIONANDO
// // switch i := x.(type) {
// // case nil:
// //     printString("x is nil")                // type of i is type of x (interface{})
// // case int:
// //     printInt(i)                            // type of i is int
// // case float64:
// //     printFloat64(i)                        // type of i is float64
// // case func(a, b, x int, c int, k ...float64,) int:
// //     printFunction(i)                       // type of i is func(int) float64
// // case bool, string:
// //     printString("type is bool or string")  // type of i is type of x (interface{})
// // default:
// //     printString("don't know the type")     // type of i is type of x (interface{})
// // }

//     switch tag {
//         default: s3()
//         case 0, 1, 2, 3: s1()
//         case 4, 5, 6, 7: s2()
//     }

//     switch x := 1; {  // missing switch expression means "true"
//         case x < 0: return -x
//         default: return x
//     }

//     switch {
//         case x < y: f1()
//         case x < z: f2()
//         case x == 4: f3()
//     }

//     //empty select blocks thread forever
//     select {default:}

//     select {
//         case i1 = <-c1:
//             print("received ", i1, " from c1\n")
//         case c2 <- i2:
//             print("sent ", i2, " to c2\n")
//         case i3, ok := (<-c3):  // same as: i3, ok := <-c3
//             if ok {
//                 print("received ", i3, " from c3\n")
//             } else {
//                 print("c3 is closed\n")
//             }
//         case a[f()] = <-c4:
//             // same as:
//             // case t := <-c4
//             //  a[f()] = t
//         default:
//             print("no communication\n")
//     }


//     if x := f(); x < (y >> 3) {
//         // return x
//     } 
//     else if kkk {

//     }

//     if ;x > 3 {
//         //if empty_stmt expression block
//     }

//     // if {
//         //errado
//     // }
    	

//     yo = calc
//     (1+3) >> 3
//     yo = calc()
//     x
//     x.o
//     classe.metodo(classe2.metodo2(a))
//     int(a)
//     x.b()
//     lkk(1)
//     lkk(1,2,3)
//     const x int = 1

//     carlos += 1<<3 + (4 * 1)
//     xd,lol = po,x.calc()
//     return;
//     // calc(1,2,3)

//     // res := plus(1, 2)
//     // fmt.Println("1+2 =", res)

//     // res = plusPlus(1, 2, 3)
//     // fmt.Println("1+2+3 =", res)
//     // return k + 10
// }