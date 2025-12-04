# ---- CONFIG ----
IMAGE_NAME=puzzle-box
REGISTRY=maraujo127

ifeq ($(TAG),)
$(error You must provide a TAG, e.g. 'make publish TAG=0.0.2')
endif

LOCAL_IMAGE=$(IMAGE_NAME):$(TAG)
REMOTE_IMAGE=$(REGISTRY)/$(IMAGE_NAME)

# ---- TARGETS ----

publish:
	# Build image with version tag
	docker build . -t $(IMAGE_NAME):$(TAG)

	# Tag as latest
	docker tag $(IMAGE_NAME):$(TAG) $(IMAGE_NAME):latest

	# Push both tags
	docker image tag $(IMAGE_NAME):$(TAG) $(REMOTE_IMAGE):$(TAG)
	docker push $(REMOTE_IMAGE):$(TAG)

	docker image tag $(IMAGE_NAME):latest $(REMOTE_IMAGE):latest
	docker push $(REMOTE_IMAGE):latest

	@echo "Published:"
	@echo "  $(REMOTE_IMAGE):$(TAG)"
	@echo "  $(REMOTE_IMAGE):latest"
