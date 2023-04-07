EXECUTABLE=rikka
WINDOWS=$(EXECUTABLE)_$(VERSION)_windows_amd64.exe
WINDOWS_ARM64=$(EXECUTABLE)_$(VERSION)_windows_arm64.exe
LINUX=$(EXECUTABLE)_$(VERSION)_linux_amd64
LINUX_ARM64=$(EXECUTABLE)_$(VERSION)_linux_arm64
DARWIN=$(EXECUTABLE)_$(VERSION)_darwin_amd64
DARWIN_ARM64=$(EXECUTABLE)_$(VERSION)_darwin_arm64
VERSION=$(shell git tag  | awk 'END{print}')

# Directory of compiled output archive
OUT_DIRECTOR=dist

build: clean windows windows_arm64 linux linux_arm64 darwin darwin_arm64 ## Build binaries
	@echo version: $(VERSION)

windows: $(WINDOWS) ## Build for Windows

windows_arm64: $(WINDOWS_ARM64) ## Build for Windows ARM64

linux: $(LINUX) ## Build for Linux

linux_arm64: $(LINUX_ARM64) ## Build for Linux ARM64

darwin: $(DARWIN) ## Build for Darwin (macOS)

darwin_arm64: $(DARWIN_ARM64) ## Build for Darwin ARM64


clean:
	rm -f $(OUT_DIRECTOR)/$(EXECUTABLE)*

$(WINDOWS):
	env GOOS=windows GOARCH=amd64 go build -v -o $(OUT_DIRECTOR)/$(WINDOWS) -ldflags="-s -w -X main.version=$(VERSION)"  ./main.go

$(WINDOWS_ARM64):
	env GOOS=windows GOARCH=arm64 go build -v -o $(OUT_DIRECTOR)/$(WINDOWS_ARM64) -ldflags="-s -w -X main.version=$(VERSION)"  ./main.go

$(LINUX):
	env GOOS=linux GOARCH=amd64 go build -v -o $(OUT_DIRECTOR)/$(LINUX) -ldflags="-s -w -X main.version=$(VERSION)"  ./main.go

$(LINUX_ARM64):
	env GOOS=linux GOARCH=arm64 go build -v -o $(OUT_DIRECTOR)/$(LINUX_ARM64) -ldflags="-s -w -X main.version=$(VERSION)"  ./main.go

$(DARWIN):
	env GOOS=darwin GOARCH=amd64 go build -v -o $(OUT_DIRECTOR)/$(DARWIN) -ldflags="-s -w -X main.version=$(VERSION)"  ./main.go

$(DARWIN_ARM64):
	env GOOS=darwin GOARCH=arm64 go build -v -o $(OUT_DIRECTOR)/$(DARWIN_ARM64) -ldflags="-s -w -X main.version=$(VERSION)"  ./main.go
