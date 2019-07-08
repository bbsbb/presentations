package main

import (
	"context"
	"fmt"
	"log"
	"time"

	"golang.org/x/sync/errgroup"
)

type work interface {
	Do(ctx context.Context) error
}

type executor struct{}

func (e *executor) RunAll(ctx context.Context, cf context.CancelFunc, workload []work) error {
	errG, gctx := errgroup.WithContext(ctx)
	for _, task := range workload {
		task := task
		errG.Go(func() error {

			if err := task.Do(gctx); err != nil {
				cf()
				return err
			}
			return nil
		})
	}
	return errG.Wait()
}

type printer struct{}

func (p printer) Do(ctx context.Context) error {
	log.Println("I print and hang....")
	select {
	case <-ctx.Done():
		fmt.Println("...then I get cancelled HARD!")
		return ctx.Err()
	}
}

type garcon struct{}

func (g garcon) Do(ctx context.Context) error {

	log.Println("I wait for 5 seconds.....")
	time.Sleep(5 * time.Second)
	log.Println("...then I error out")
	return fmt.Errorf("teehee, an error")
}

func main() {
	var workload = []work{printer{}, garcon{}}
	exService := &executor{}
	ctx, cf := context.WithTimeout(context.Background(), 10*time.Second)

	log.Printf("I exited with %v", exService.RunAll(ctx, cf, workload))
}
