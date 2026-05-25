IMAGE_NAME=puzzle-box
REGISTRY=maraujo127

LOCAL_IMAGE=$(IMAGE_NAME):$(TAG)
REMOTE_IMAGE=$(REGISTRY)/$(IMAGE_NAME)

.PHONY: build-local publish

build-local:
	docker build . -t ${IMAGE_NAME}:local

publish:
ifndef TAG
	$(error You must provide a TAG, e.g. 'make publish TAG=0.0.2')
endif
	@echo "--- Starting Publish for Tag: $(TAG) ---"

	# 1. Record the version (single source of truth, read by core/version.sh)
	echo "$(TAG)" > VERSION

	# 2. Build image with version tag, stamping the version into the image
	docker build . --build-arg PUZZLE_BOX_VERSION=$(TAG) -t $(IMAGE_NAME):$(TAG)

	# 3. Tag as latest
	docker tag $(IMAGE_NAME):$(TAG) $(IMAGE_NAME):latest

	# 4. Push both tags
	docker image tag $(IMAGE_NAME):$(TAG) $(REMOTE_IMAGE):$(TAG)
	docker push $(REMOTE_IMAGE):$(TAG)
	docker image tag $(IMAGE_NAME):latest $(REMOTE_IMAGE):latest
	docker push $(REMOTE_IMAGE):latest

	@echo "Published successfully:"
	@echo "  $(REMOTE_IMAGE):$(TAG)"
	@echo "  $(REMOTE_IMAGE):latest"
