package main

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

var Version string

type versionResponse struct {
	Version string `json:"version"`
}

func main() {
	e := echo.New()

	e.GET("/api/version", func(c echo.Context) error {
		return c.JSON(http.StatusOK, versionResponse{
			Version: Version,
		})
	})

	_ = e.Start(":8080")
}
