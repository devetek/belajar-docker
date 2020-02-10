TAG := cmdentry

.PHONY: build
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


.PHONY: test-cmdentry
test-cmdentry:
	@ echo "Info:"
	@ echo "\n"
	@ echo "Test ini akan terjadi error, karena secara default ENTRYPOINT image akan mengarah pada binary /bin/ping. Parameter sh yang dikirimkan akann dianggap sebagai host yanng harus diping."
	@ docker run -it prakasa1904/tps-about-entry:cmdentry sh

.PHONY: test-cmd
test-cmd:
	@ echo "Info:"
	@ echo "\n"
	@ echo "Test ini akan berhasil, karena tidak ada yang melakukan override ENTRYPOINT pada base image alpine, dan hanya melakukan eksekusi command default pwd."
	@ echo "ENTRYPOINT base image alpine dapat dilihat disini https://hub.docker.com/layers/alpine/library/alpine/latest/images/sha256-4d5c5951669588e23881c158629ae6bac4ab44866d5b4d150c3f15d91f26682b"
	@ docker run -it prakasa1904/tps-about-entry:cmd sh

.PHONY: test-entry
test-entry:
	@ echo "Info:"
	@ echo "\n"
	@ echo "Test ini akan berhasil, karena meskipun melakukan override ENTRYPOINT pada base image alpine, parameter host yang dikirimkan dapat dicapai oleh binary /bin/ping karena menuju ke localhost."
	@ docker run -it prakasa1904/tps-about-entry:entry localhost
