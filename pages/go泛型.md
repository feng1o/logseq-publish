- ==doc==
	- [sg](https://segmentfault.com/a/1190000041634906)
	- [byteInner go generics](https://by.fs.cn/wiki/wikcn0BbfU0ra7Qc4rQOjiYJO6e)
	- [go泛型实现原理讲解1.8](https://www.bilibili.com/video/BV1We4y1y7VN/?p=2)
-
- #### go泛型指针接收器
  collapsed:: true
	- [code](https://go.dev/play/p/bxrUHnBPgQI)  [all-code](https://go.dev/play/p/ew5XoKzroM-)   [Using Generics with Pointer Receivers in Go](https://medium.com/@reetas/using-generics-with-pointer-receivers-in-go-39ee237d7475)
	- 在使用go泛型时，想实现一个能接收泛型实参，并能改变实参struct的值，即指针接收器的方法。先看一个简单例子，定义一个Adder加法器，返回int结果(不要纠结)。
		- ```go
		  // 一个加法interface，用于计算两个数的和
		  type Adder interface {
		  	Add() int
		  	Set(a, b any)
		  }
		  
		  // Adder的实现，整数
		  type IntAdder struct {
		  	A int
		  	B int
		  }
		  
		  // 实现Adder接口的Set方法
		  func (i *IntAdder) Set(a, b any) {
		  	i.A = a.(int)
		  	i.B = b.(int)
		  }
		  
		  func (i *IntAdder) Add() int {
		  	return i.A + i.B
		  }
		  
		  // Adder的实现，浮点数
		  type FloatAdder struct {
		  	A float64
		  	B float64
		  }
		  
		  // 实现Adder接口的Set方法
		  func (f *FloatAdder) Set(a, b any) {
		  	f.A = a.(float64)
		  	f.B = b.(float64)
		  }
		  
		  func (f *FloatAdder) Add() int {
		  	return int(f.A + f.B)
		  }
		  ```
	- 如果要实现一个泛型的add方法，看看有哪些直接的方法
		- ```
		  // 泛型创建一个通用的Add方法
		  func Add[T Adder, P any](a, b P) int {
		  	ad := new(T)
		  	ad.Set(a, b)
		  	return ad.Add()
		  }
		  
		  ./general-point-golang.go:69:5: ad.Set undefined (type *T is pointer to type parameter, not type parameter)
		  ./general-point-golang.go:70:12: ad.Add undefined (type *T is pointer to type parameter, not type parameter)
		  ```
		- ![image.png](../assets/image_1718370196253_0.png)
			- > 泛型形参是Adder，那Adder interface有定义[*Adder]Set/Add吗？ 没有
			- 这个报错是：Set/Add方法是被*T new(T)调用的，但这两个方法是被申明为Adder，而adder并没有[*Adder]Set/Add； 那我们改下，不用指针，解决编译错误
				- ```
				  // 通过非指针接收器，使用generic
				  // 不符合预期，set不会生效，结果是00
				  func AddNotPoint[T Adder, P any](a, b P) int {
				  	var av T
				  	av.Set(a, b)
				  	return av.Add()
				  }
				  ```
				- 但这部分代码并不能直接调用指针接收器的以上方法，无法实例化，类型实参传什么？(IntAdd, *IntAdd--和new效果类似了)
				- ```go
				  	fmt.Println(AddNotPoint[StringAdder, string]("1", "2"))
				  	//能调用，但是无效果， StringAdder，方法都是值作为接收器
				  
				  	fmt.Println(AddNotPoint[IntAdder, int](1, 2))
				      //IntAdder does not implement Adder (method Add has pointer receiver)compilerInvalidTypeArg
				  ```
	- 怎么解决以上问题呢？ 通过泛型接收器
		- > 实例化时：必须实例化出指针的IntAdd和FloatAdd
		  类型实参必须是包含Set/Add的方法，且非指针
		- ```go
		  // 泛型的interface
		  type AdderPoint[T any] interface {
		  	// 这个AdderPoint泛型interface，可接受一个指针的T或一个值类型的T
		      *T  
		  	// Adder，让这个interface继承Adder的接口
		  	// AddPoint就有了Add方法，Set方法，关键在new(Adder的具体实现)可直接转成AdderPoint[T]
		  	Adder
		  }
		  
		  type AddType interface {
		  	IntAdder | FloatAdder | StringAdder
		  }
		  
		  func AddPoint[T AddType, P any, ap AdderPoint[T]](a, b P) int {
		  	var tt ap = new(T) // 实例化出指针， 指针可调用Add, Set
		  	tt.Set(a, b)
		  	return tt.Add()
		  }
		  
		  int main() {
		    	fmt.Println(AddPoint[IntAdder, int](1, 2))
		  	fmt.Println(AddPoint[FloatAdder, float64](1.8, 2.8))
		  }
		  ```
-