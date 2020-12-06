package main

import (
	"github.com/gorilla/mux"
	"item-list-server/items"
	"log"
	"net/http"
)

func main() {
	router := mux.NewRouter().StrictSlash(true)
	subRouter := router.PathPrefix("/api/v1").Subrouter()
	subRouter.Methods("GET").Path("/items").HandlerFunc(items.GetItems)
	subRouter.Methods("GET").Path("/items/{id}").HandlerFunc(items.GetItem)
	subRouter.Methods("POST").Path("/items").HandlerFunc(items.CreateItem)
	subRouter.Methods("PUT").Path("/items/{id}").HandlerFunc(items.UpdateItem)
	subRouter.Methods("DELETE").Path("/items/{id}").HandlerFunc(items.DeleteItem)

	log.Fatal(http.ListenAndServe(":3000", router))
}
