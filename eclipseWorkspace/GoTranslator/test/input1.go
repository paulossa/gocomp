package main

import "fmt"

const a int = 3

var a [5]int

type pessoa struct {
    T1        // field name is T1
    *T2       // field name is T2
    P.T3      // field name is T3
    *P.T4     // field name is T4
    x, y int  // field names are x and y
    z float64
}

type vazio struct {}

type (
    // nodeList = []*Node  // nodeList and []*Node are identical types
    Polar    = polar    // Polar and polar denote identical types
    MIZERA = DDA
)

type NewMutex Mutex

func plus(j int, b int) int {
    var x int = 1
    var k, z float64 = -1, -2
    var(k uint)
    var (
        u, v, s = 2.0, 3.0, "bar"
        i, j int
        ih float64
        re, dskao, jdihs = 2.0, 3.0, "bar"
    )
    x = 3
    return x
}

func plusPlus(a, b, c int) int {
    1 << 3
    x = 1
    return a + b - c
}

func main() {


    if x := f(); x < (y >> 3) {
        // return x
    } 
    else if kkk {

    }
    	

    yo = calc
    (1+3) >> 3
    yo = calc()
    x
    x.o
    classe.metodo(classe2.metodo2(a))
    int(a)
    x.b()
    lkk(1)
    lkk(1,2,3)
    const x int = 1

    carlos += 1<<3 + (4 * 1)
    xd,lol = po,x.calc()
    // calc(1,2,3)

    // res := plus(1, 2)
    // fmt.Println("1+2 =", res)

    // res = plusPlus(1, 2, 3)
    // fmt.Println("1+2+3 =", res)
    // return k + 10
}
