// Copyright (c) 2015 FactomProject/FactomCode Systems LLC.
// Use of this source code is governed by an ISC
// license that can be found in the LICENSE file.
package main

import (
	"encoding/hex"
	"encoding/json"
	"flag"
	"fmt"
	"io/ioutil"
	"net/http"
	"net/url"
	"os"
)

type jsonentry struct {
	ChainID string
	ExtIDs  []string
	Data    string
}

type extids []string

func (e *extids) String() string {
	return fmt.Sprint(*e)
}

func (e *extids) Set(s string) error {
	*e = append(*e, s)
	return nil
}

func put(args []string) error {
	os.Args = args
	
	var (
		cid  = flag.String("c", "", "hex encoded chainid for the entry")
		serv = flag.String("s", "localhost:8088", "path to the factomclient")
		eids extids
	)
	flag.Var(&eids, "e", "external id for the entry")
	flag.Parse()
	
	server := "http://" + *serv + "/v1/submitentry"

	e := new(jsonentry)

	e.ChainID = *cid
	e.ExtIDs = append(e.ExtIDs, eids...)
//	for _, v := range eids {
//		e.ExtIDs = append(e.ExtIDs, string(v))
//	}
//
//	// need to find some way to read multiple lines (like from a file)
//	p := make([]byte, 1024)
//	n, err := os.Stdin.Read(p)
//	if err != nil {
//		return err
//	}
//	p = p[:n]

	p, err := ioutil.ReadAll(os.Stdin)
	if err != nil {
		return err
	}
	if size := len(p); size > 10240 {
		return fmt.Errorf("Entry of %d bytes is too large", size)
	}
	e.Data = hex.EncodeToString(p)

	b, err := json.Marshal(e)
	if err != nil {
		return err
	}
	
	data := url.Values{
		"datatype": {"entry"},
		"format":   {"json"},
		"entry":    {string(b)},
	}
	
	_, err = http.PostForm(server, data)
	if err != nil {
		return err
	}

	return nil
}
