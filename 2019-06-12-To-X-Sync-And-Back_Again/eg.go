package main

import (
	"context"
	"fmt"
	"log"
	"time"

	"golang.org/x/sync/errgroup"
)

func main() {

	ctx, _ := context.WithTimeout(context.Background(), 5*time.Second)

	g, gctx := errgroup.WithContext(ctx)
	for _, wait := range [3]int{2, 4, 10} {
		id := wait

		g.Go(func() error {
			log.Println("Starting the sleep")
			for {
				select {
				case <-time.After(1 * time.Second):
					fmt.Printf("%d waited for a second\n", id)
				case <-gctx.Done():
					fmt.Printf("%d cancelled\n", id)
					return gctx.Err()
				}
			}
		})
	}

	log.Println("All routines up and running...")

	if err := g.Wait(); err == nil {
		log.Printf("The group ended without an error, which would be surprising.")
	} else {
		log.Printf("Oops. We did poo-poo: [%v]", err)
	}
}
