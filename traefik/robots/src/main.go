/*
 * Copyright (C) 2016 wikiwi.io
 *
 * This software may be modified and distributed under the terms
 * of the MIT license. See the LICENSE file for details.
 */

package main

import (
	"fmt"
	"net/http"
	"os"
	"regexp"

	"github.com/jessevdk/go-flags"
)

var version = "0.2.1-dev"
var content = "User-agent: *\nDisallow: /\n"

var opts struct {
	Listen  string `long:"listen" description:"address to listen on" default:"0.0.0.0:8080" env:"ROBOTS_DISALLOW_LISTEN"`
	Version bool   `long:"version" short:"v" description:"show version number"`
}

type handler struct {
	PathPattern  *regexp.Regexp
	MetaImport   string
	RedirectName string
	RedirectTo   string
}

func (h *handler) ServeHTTP(rw http.ResponseWriter, req *http.Request) {
	_, err := rw.Write([]byte(content))
	if err != nil {
		http.Error(rw, err.Error(), http.StatusInternalServerError)
	}
}

func main() {
	parser := flags.NewParser(&opts, flags.Default)
	parser.Name = "robots-disallow"
	_, err := parser.Parse()
	if err != nil {
		if e2, ok := err.(*flags.Error); ok && e2.Type == flags.ErrHelp {
			os.Exit(0)
		}
		os.Exit(1)
	}

	if opts.Version {
		fmt.Println(version)
	} else {
		h := &handler{}
		fmt.Println("Listening on " + opts.Listen + "...")
		panic(http.ListenAndServe(opts.Listen, h))
	}
}