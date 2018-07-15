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

const (
	bit0, mask0 = 1 << iota, 1<<iota - 1  // bit0 == 1, mask0 == 0  (iota == 0)
	bit1, mask1                           // bit1 == 2, mask1 == 1  (iota == 1)
	_, _                                  //                        (iota == 2, unused)
	bit3, mask3                          // bit3 == 8, mask3 == 7  (iota == 3)
)

type vazio struct {}

type (
    // nodeList = []*Node  // nodeList and []*Node are identical types
    Polar    = polar    // Polar and polar denote identical types
    MIZERA = DDA
)

type NewMutex Mutex

func plus(j int, b int) int {


	a = a,b,c

	for a > b {
		x = a
	}

	for i := 0; i < 10; i++ {

		L:
		f(i)

		continue ;
	}

	fallthrough

	defer a

	go a <- b

	go (a+3) <- 8 * 3

	for ; a > b ; {
		break ;
	}

	for {}

	for i, s := range a {
		// type of i is int
		// type of s is string
		// s == a[i]
		g(i, s)
	}

	for key, val = range m {
		h(key, val)
	}

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
