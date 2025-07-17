NAME = kueblerit/container-baseimage
VERSION = 12.1.0

.PHONY: build build-nocache test tag-latest push push-latest release git-tag-version

build:
	docker build -f image/Dockerfile -t $(NAME):$(VERSION) --rm image --platform linux/amd64,linux/arm64

build-nocache:
	docker build -f image/Dockerfile -t $(NAME):$(VERSION) --no-cache --rm image --platform linux/amd64,linux/arm64

test:
	env NAME=$(NAME) VERSION=$(VERSION) bats test/test.bats

tag:
	docker tag $(NAME):$(VERSION) $(NAME):$(VERSION)

tag-latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest

push:
	docker push $(NAME):$(VERSION)

push-latest:
	docker push $(NAME):latest

release: build test tag-latest push push-latest

git-tag-version: release
	git tag -a v$(VERSION) -m "v$(VERSION)"
	git push origin v$(VERSION)
