log:clean
	pipenv run python -u hello.py
clean:
	-rm txt*
requirements:
	pipenv lock -r > requirements.txt
build:requirements
	docker build -t 
