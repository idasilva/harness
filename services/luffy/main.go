package main

import (
	"github.com/idasilva/luffy-services/cmd"
	"go.uber.org/zap"
)

func main() {
	logger, _ := zap.NewProduction()

	defer func() { _ = logger.Sync() }()
	logger.Info("Starting Luffy Service")
	cmd.Execute()
}
