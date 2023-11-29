package main

import (
	"fmt"
	"time"
    "net/http"
)


func hello(w http.ResponseWriter, req *http.Request) {
	fmt.Printf("Got /hello\n")
	w.WriteHeader(200)
    w.Write([]byte("hello"))
}

func main() {
	go func() {
	    http.HandleFunc("/hello", hello)
    	http.ListenAndServe(":8080", nil)
	}()

	fmt.Printf("Hello world. Start.\n")
	for i := 0; true; i++ {
		fmt.Printf("Hello world. %d\n",i)	
		time.Sleep(5 * time.Second)
	}
}
