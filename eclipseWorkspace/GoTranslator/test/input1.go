package main
import "fmt"

//declaracao de variavel

//int 
var a,b,c int = 1,2,3
var d = 2312333
var e int

//float
var f,g,h float = 1.2, 3.3, 213132.4123123
var i float = 1.651341232


//string
var j,k = "xxx", "12333"
var l string = ""


//variado
var m,n,o = a, "cc", 2.2
var p string = "sss2"
var q = "sss2"


//func
func main(argc int, argv string) int {
	return 1
}

func x() func() d {
	return func() int {
		return 1
	}
}