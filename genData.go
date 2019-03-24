package main

import (
	"math/rand"
	"os"
	"strconv"
	"sync"
	"time"
)

const (
	ten  = 10
	oneM = 1000000
	oneB = 1000000000
)

func init() {
	rand.Seed(time.Now().UnixNano())
}

var wg sync.WaitGroup

func main() {

	for i := 0; i < 10; i++ {
		wg.Add(1)
		go makeOneM(i * oneM)
	}
	wg.Wait()
}

func makeOneM(start int) {
	f, err := os.Create("fake" + strconv.Itoa(start/oneM) + ".csv")
	if err != nil {
		panic(err)
	}

	for i := start; i < start+oneM; i++ {
		record := strconv.Itoa(i) + ",\"" + randStringRunes(10) + "\"," + strconv.Itoa(rand.Intn(oneM)) + "\n"
		f.WriteString(record)
	}
	f.Sync()
	wg.Done()
}

var letterRunes = []rune("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

func randStringRunes(n int) string {
	b := make([]rune, n)
	for i := range b {
		b[i] = letterRunes[rand.Intn(len(letterRunes))]
	}
	return string(b)
}
