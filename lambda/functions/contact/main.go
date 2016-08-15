package main

import (
	"encoding/json"

	"github.com/apex/go-apex"
	lambdaHandson "github.com/k-nishijima/lambda-handson-golang-201608"
)

func main() {
	apex.HandleFunc(func(event json.RawMessage, ctx *apex.Context) (interface{}, error) {
		var request lambdaHandson.AddValueRequest
		var dao lambdaHandson.DynamoDBClient

		if err := json.Unmarshal(event, &request); err != nil {
			return nil, err
		}

		// valiadte
		err := dao.ValidateRequest(request)
		if err != nil {
			return nil, err
		}

		// call dao
		err = dao.Put(request)
		if err != nil {
			return nil, err
		}

		return "ok", nil
	})
}
