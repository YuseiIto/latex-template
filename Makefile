SOURCE := src/*.tex

.PHONY: test
test:
	npm run lint $(SOURCE)

.PHONY: format
format:
	npm run lint:fix $(SOURCE)
