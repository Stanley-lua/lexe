BUILD_DIR=build
ENTRY_FILE=executable.lua
OUTPUT=lexe

COMPILED=$(BUILD_DIR)/$(OUTPUT)
BUILD_OPTIONS=-b $(BUILD_DIR) -e $(ENTRY_FILE) -o $(OUTPUT)

default: all

lib:
	stanley install

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(COMPILED).lua: lib $(BUILD_DIR)
	@lua $(ENTRY_FILE) $(BUILD_OPTIONS) bundle

$(COMPILED).luac: $(COMPILED).lua
	@lua $(ENTRY_FILE) $(BUILD_OPTIONS) build

all: $(COMPILED).luac
	@$(COMPILED) --version

clean:
	@lua $(ENTRY_FILE) -b $(BUILD_DIR) clean

install: default
	cp -f $(COMPILED) ~/.local/bin/$(OUTPUT)

uninstall: clean
	rm ~/.local/bin/$(OUTPUT)
