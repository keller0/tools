package main

import (
	"flag"
	"log"
	"net/http"
)

var (
	dir  string
	port string
)

func main() {
	flag.StringVar(&dir, "d", "/usr/share/doc", "doc dir")
	flag.StringVar(&port, "p", "7777", "listen port")

	flag.Parse()
	log.Fatal(http.ListenAndServe(":"+port, http.FileServer(http.Dir(dir))))
}
