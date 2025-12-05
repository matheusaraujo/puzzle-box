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

	# 1. Build image with version tag
	docker build . -t $(IMAGE_NAME):$(TAG)

	# 2. Tag as latest
	docker tag $(IMAGE_NAME):$(TAG) $(IMAGE_NAME):latest

	# 3. Push both tags
	docker image tag $(IMAGE_NAME):$(TAG) $(REMOTE_IMAGE):$(TAG)
	docker push $(REMOTE_IMAGE):$(TAG)
	docker image tag $(IMAGE_NAME):latest $(REMOTE_IMAGE):latest
	docker push $(REMOTE_IMAGE):latest

	# 4. Update README.md
	sed -i "s/version-.*-blue/version-$(TAG)-blue/g" README.md 2>/dev/null || \
	sed -i '' "s/version-.*-blue/version-$(TAG)-blue/g" README.md

	# 5. Update version.sh
	sed -i "s/puzzle-box@.*\"/\"puzzle-box@${TAG}\"/g" core/version.sh 2>/dev/null || \
	sed -i '' "s/puzzle-box@.*\"/\"puzzle-box@${TAG}\"/g" core/version.sh

	@echo "Published successfully:"
	@echo "  $(REMOTE_IMAGE):$(TAG)"
	@echo "  $(REMOTE_IMAGE):latest"
