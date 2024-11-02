# Check CLI version
.PHONY: version
version:
	@echo "Zenn  CLI: v$$(npx zenn -v)" && echo "Qiita CLI: v$$(npx qiita version)"

# CLI Update
.PHONY: update
update:
	npm install zenn-cli@latest && npm install @qiita/qiita-cli@latest

# Sync GitHub repository and Qiita articles
.PHONY: pull
pull:
	git pull && npx qiita pull

# Create a new article
.PHONY: new
new:
	npx zenn new:article && npx qiita new

# View help
.PHONY: help
help:
	@echo "Zenn help =================================" && \
	npx zenn --help && \
	echo "\nQiita help ===============================\n" && \
	npx qiita help
