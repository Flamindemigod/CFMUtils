NAME = "CarriesForMemesGroupUtils"
LUA_FORMAT = stylua
SRC_DIR = . # Directory containing Lua files
LUA_FILES = $(shell find $(SRC_DIR) -name "*.lua")
all: format zip

# Format all Lua files
format:
	@echo "Formatting Lua files..."
	@for file in $(LUA_FILES); do \
		echo "Formatting $$file"; \
		$(LUA_FORMAT) $$file; \
	done
	@echo "Done."

zip:
	@echo "Exporting Addon"
	git archive HEAD --prefix=$(NAME)/ --format=zip -o $(NAME).zip
	@echo "Done."
