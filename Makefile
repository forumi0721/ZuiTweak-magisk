# Makefile for creating install.zip and cleaning up

.PHONY: all clean

all:
	@echo "Set permissions..."
	@find . -name ".git" -prune -o -type d -exec chmod 755 {} \;
	@find . -name ".git" -prune -o -type f -exec chmod 644 {} \;
	@find . -name ".git" -prune -o -type f -name \*.sh -exec chmod 755 {} \;
	@echo "Creating install.zip..."
	@rm -f install.zip
	@zip -q -r -D install.zip *
	@echo "install.zip created successfully."

clean:
	@rm -f install.zip
	@echo "install.zip deleted."

