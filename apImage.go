package main

import (
	"flag"
	"fmt"
	"io"
	"net/http"
	"os"
	"strings"
	"sync"
)

func download(baseurl, image string) error {

	url := baseurl + image
	file, err := os.Create(image)
	if err != nil {
		return err
	}
	defer file.Close()

	resp, err := http.Get(url)
	fmt.Println(resp.ContentLength)
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
	s := flag.Int("s", 1, "start")
	e := flag.Int("e", 2, "end")
	var baseurl string
	flag.StringVar(&baseurl, "b", "http://www.ibiblio.org/apollo/ScansForConversion/Comanche055/", "base url")
	flag.Parse()
	len := *e - *s
	var wg sync.WaitGroup
	for i := 0; i < len; i++ {
		image := imgName(*s + i)
		wg.Add(1)
		go func(image string) {
			fmt.Println(baseurl+image)
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
		tmp = strings.Repeat("0", 4-len(tmp)) + tmp + ".jpg"
	}
	return tmp
}
