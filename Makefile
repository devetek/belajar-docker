TAG := cmdentry

build:
ifeq ($(TAG),cmdentry)
		$(eval FILE := $(shell echo "EntryAndCMD.Dockerfile"))
endif

ifeq ($(TAG),cmd)
		$(eval FILE := $(shell echo "OnlyCMD.Dockerfile"))
endif

ifeq ($(TAG),entry)
		$(eval FILE := $(shell echo "OnlyEntry.Dockerfile"))
endif

	@ docker build -f $(FILE) -t prakasa1904/tps-about-entry:$(TAG) .
	@ docker push prakasa1904/tps-about-entry:$(TAG)