package main

import (
	"log"
	"time"

	"golang.org/x/sync/singleflight"
)

func jeSuisSlow() string {
	log.Println("Calling Mr. Slow....")
	time.Sleep(5 * time.Second)
	return "banana"
}

func main() {
	var execG singleflight.Group
	var waitChs []<-chan singleflight.Result

	for i, _ := range [3]int{} {
		log.Printf("Launching execution %d\n", i)

		waitChs = append(waitChs, execG.DoChan("slow", func() (interface{}, error) {
			return jeSuisSlow(), nil
		}))

		log.Println("Waiting for one second...")
		time.Sleep(1 * time.Second)
	}

	for {
		select {
		case result := <-waitChs[0]:
			log.Printf("1 got the result! %s", result)
		case result := <-waitChs[1]:
			log.Printf("2 got the result! %s", result)
		case result := <-waitChs[2]:
			log.Printf("3 got the result! %s", result)
		}
	}
}
