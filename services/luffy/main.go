package main

import (
	"crypto/md5"
	"encoding/hex"
	"github.com/idasilva/luffy-services/cmd"
	"go.uber.org/zap"
)

func main() {
	logger, _ := zap.NewProduction()

	defer func() { _ = logger.Sync() }()
	
	hash := md5.Sum([]byte("luffy-service-id"))
	serviceID := hex.EncodeToString(hash[:])
	
	logger.Info("Starting Luffy Service...", 
		zap.String("service_id", serviceID))
	
	cmd.Execute()
}