package main

import (
	"flag"
	"fmt"
	"github.com/fatih/color"
	"io"
	"net/http"
	"os"
	"strings"
	"sync"
	"strconv"
)

func download(baseurl, image string) error {

	url := baseurl + image
	file, err := os.Create(image)
	if err != nil {
		return err
	}
	defer file.Close()

	resp, err := http.Get(url)
	// fmt.Println(resp.ContentLength)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	_, err = io.Copy(file, resp.Body)
	if err != nil {
		return err
	}
	return nil
}

func main() {
	s := flag.Int("s", -1, "start")
	e := flag.Int("e", -1, "end")
	var baseurl string
	flag.StringVar(&baseurl, "b", "http://www.ibiblio.org/apollo/ScansForConversion/Comanche055/", "base url")
	flag.Parse()
	numbers := []int{}
	if *s < 0 || *e < 0 {
		fmt.Println(flag.Args())
		for _, s := range flag.Args() {
			n, err := strconv.Atoi(s)
			if err != nil {
				fmt.Println(err)
				os.Exit(2)
			}
			numbers = append(numbers, n)
		}
		fmt.Println(numbers)
	}else{
		for i:=0; i<(*e-*s); i++ {
			numbers = append(numbers, *s+i)
		}
	}
	yellow := color.New(color.FgYellow).SprintFunc()
	var wg sync.WaitGroup
	for _, num := range numbers {
		image := imgName(num)
		wg.Add(1)
		go func(image string) {
			fmt.Printf("%s%s\n", baseurl, yellow(image))
			if err := download(baseurl, image); err != nil {
				panic(err)
			}
			defer fmt.Println(image + " downloaded")
			defer wg.Done()
		}(image)
	}
	wg.Wait()
	fmt.Println("done")
}

func imgName(x int) string {
	tmp := fmt.Sprintf("%d", x)
	if len(tmp) < 4 {
		tmp = strings.Repeat("0", 4-len(tmp)) + tmp
	}
	return tmp + ".jpg"
}
