build:
	docker build -t sheepdoge/pup-apt .

test: build
	docker run sheepdoge/pup-apt /bin/bash -c "./test.sh"

interactive: build
	docker run -it sheepdoge/pup-apt /bin/bash
