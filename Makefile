# Belajar Docker
#
# Copyright (c) 2023 Devetek Tech. https://devetek.com. MIT License
# Repo: https://github.com/devetek/belajar-docker

# Global variables
MSG_PREFIX="[belajar-docker]"

# Required binaries
$(eval WHICH_DOCKER := $(strip $(shell which docker)))
docker_found = $(strip $(findstring docker, $(WHICH_DOCKER)))

$(eval WHICH_GAWK := $(strip $(shell which gawk)))
gawk_found = $(strip $(findstring gawk, $(WHICH_GAWK)))

################################################################################
##@ GENERIC
################################################################################

help: .bin-validator ## Show available commands
	@echo " ____       _        _                 ____             _"
	@echo "| __ )  ___| | __ _ (_) __ _ _ __     |  _ \\  ___   ___| | _____ _ __"
	@echo "|  _ \\ / _ \\ |/ _\` || |/ _\` | '__|____| | | |/ _ \\ / __| |/ / _ \\ '__|"
	@echo "| |_) |  __/ | (_| || | (_| | | |_____| |_| | (_) | (__|   <  __/ |"
	@echo "|____/ \\___|_|\\__,_|/ |\\__,_|_|       |____/ \\___/ \\___|_|\\_\\___|_|"
	@echo "                  |__/"
	@echo ""
	@echo "Copyright (c) $(shell date +"%Y") Devetek Tech. https://devetek.com."
	@echo "Repo: https://github.com/devetek/belajar-docker"
	@echo ""
	@gawk 'function fix_value(value, str) { \
		padding=sprintf("%50s",""); \
		ret=gensub("([^ ]+)", "\\1"padding"\n ", "g", "  "value); \
		ret=gensub("(^|\n)(.{53}) *", "\\1\\2\033[0m"str"  \033[36m", "g", ret); \
		ret=substr(ret, 3, length(ret)-16-length(str)); \
		return ret; \
	} \
	BEGIN { \
		FS = ":.*##"; \
		printf "Use: make \033[36m<target>\033[0m\n"; \
	} /^\$$?\(?[a-zA-Z0-9_-]+\)?:.*?##/ { \
		printf "  \033[36m%-50s\033[0m %s\n", $$1, $$2 \
	} /^##@/ { \
		printf "\n\033[1m%s\033[0m\n", substr($$0, 5) \
	}' $(MAKEFILE_LIST)



################################################################################
##@ DEVELOPMENT
################################################################################

run: .bin-validator ## Run playground
	@docker build -t devetek/belajar-docker:latest .
	@docker run -it devetek/belajar-docker:latest bash -c "echo 'Hello World!'"

# Hidden target, for contributors only
git-clean:
	@git branch | grep -v "main" | xargs git branch -D

.bin-validator: ## validate required binaries exist
# exit status code 126 - Command invoked cannot execute
ifneq ($(docker_found),docker)
	@echo "$(MSG_PREFIX) Install docker https://docs.docker.com/engine/install/"
	@exit 126
endif

ifneq ($(gawk_found),gawk)
	@echo "$(MSG_PREFIX) Install gawk for macOS https://formulae.brew.sh/formula/gawk"
	@echo "$(MSG_PREFIX) Install gawk for Ubuntu https://howtoinstall.co/en/gawk"
	@exit 126
endif
