.PHONY: build, run

build:
	docker build -t nonchalant/stockkit:4.1 .

run:
	docker run nonchalant/stockkit:4.1
