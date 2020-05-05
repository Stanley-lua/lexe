BUILD_DIR=./build
ENTRY_FILE=./executable.lua
OUTPUT=lexe

all:
	stanley install
	mkdir -p $(BUILD_DIR)
	lua $(ENTRY_FILE) -b $(BUILD_DIR) -o $(OUTPUT) -e $(ENTRY_FILE) build
	@$(BUILD_DIR)/$(OUTPUT) --version

clean:
	lua $(ENTRY_FILE) -b $(BUILD_DIR) clean

install: all
	cp $(BUILD_DIR)/$(OUTPUT) ~/.local/bin/$(OUTPUT)

uninstall: clean
	rm ~/.local/bin/$(OUTPUT)
