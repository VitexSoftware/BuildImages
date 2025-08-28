# Top-level Makefile to build Debian/Ubuntu images preconfigured with VitexSoftware APT repo

# Image namespace
NAMESPACE ?= vitexsoftware
# Common repo settings
REPO_URL ?= https://repo.vitexsoftware.com
# Provide KEY_URL to enable repository signing (left empty by default to avoid build failures if key URL is unavailable)
KEY_URL ?= https://repo.vitexsoftware.com/KEY.gpg

# Supported variants
DEBIAN_VARIANTS := bookworm trixie forky
UBUNTU_VARIANTS := jammy noble
ALL_VARIANTS := $(DEBIAN_VARIANTS) $(UBUNTU_VARIANTS)

# Image tags
define IMAGE_TAG
$(NAMESPACE)/$(if $(findstring $(1),$(DEBIAN_VARIANTS)),debian,ubuntu):$(1)
endef

.PHONY: all
all: $(ALL_VARIANTS)

# Generic single-variant build rules
$(DEBIAN_VARIANTS): %: debian/%/Dockerfile
	docker build \
	  -f $< \
	  --build-arg REPO_URL=$(REPO_URL) \
	  --build-arg KEY_URL=$(KEY_URL) \
	  -t $(call IMAGE_TAG,$@) \
	  .

$(UBUNTU_VARIANTS): %: ubuntu/%/Dockerfile
	docker build \
	  -f $< \
	  --build-arg REPO_URL=$(REPO_URL) \
	  --build-arg KEY_URL=$(KEY_URL) \
	  -t $(call IMAGE_TAG,$@) \
	  .

# Convenience explicit targets
.PHONY: $(ALL_VARIANTS)

# Multi-arch buildx
PLATFORMS ?= linux/amd64,linux/arm64

.PHONY: buildx buildx-%
buildx: $(addprefix buildx-, $(ALL_VARIANTS))

buildx-%: %
	docker buildx build \
	  --platform $(PLATFORMS) \
	  -f $(if $(findstring $*, $(DEBIAN_VARIANTS)),debian/$*/Dockerfile,ubuntu/$*/Dockerfile) \
	  --build-arg REPO_URL=$(REPO_URL) \
	  --build-arg KEY_URL=$(KEY_URL) \
	  -t $(call IMAGE_TAG,$*) \
	  --load \
	  .

# Push and publish
.PHONY: push publish
push:
	for v in $(DEBIAN_VARIANTS); do docker push $(NAMESPACE)/debian:$$v; done
	for v in $(UBUNTU_VARIANTS); do docker push $(NAMESPACE)/ubuntu:$$v; done

publish:
	for v in $(DEBIAN_VARIANTS); do docker buildx build \
		--platform $(PLATFORMS) \
		-f debian/$$v/Dockerfile \
		--build-arg REPO_URL=$(REPO_URL) \
		--build-arg KEY_URL=$(KEY_URL) \
		-t $(NAMESPACE)/debian:$$v \
		--push \
		.; done
	for v in $(UBUNTU_VARIANTS); do docker buildx build \
		--platform $(PLATFORMS) \
		-f ubuntu/$$v/Dockerfile \
		--build-arg REPO_URL=$(REPO_URL) \
		--build-arg KEY_URL=$(KEY_URL) \
		-t $(NAMESPACE)/ubuntu:$$v \
		--push \
		.; done

# Lint Dockerfiles with hadolint
.PHONY: lint
lint:
	@command -v hadolint >/dev/null 2>&1 || { echo "hadolint not found. Install from https://github.com/hadolint/hadolint/releases or your package manager." >&2; exit 127; }
	@find . -maxdepth 3 -type f -name 'Dockerfile' -o -name 'Dockerfile*' -print0 | xargs -0 -r hadolint

# Clean
.PHONY: clean reset
clean:
	-@for v in $(DEBIAN_VARIANTS); do docker rmi -f $(NAMESPACE)/debian:$$v 2> /dev/null || true; done
	-@for v in $(UBUNTU_VARIANTS); do docker rmi -f $(NAMESPACE)/ubuntu:$$v 2> /dev/null || true; done
	-@docker image prune -f 2> /dev/null || true

reset: clean all

