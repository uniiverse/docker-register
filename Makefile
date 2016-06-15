login:
	`aws ecr get-login --region us-east-1`
	
docker: login
	docker build -t universe/register .
	docker tag -f universe/register:latest 130059590535.dkr.ecr.us-east-1.amazonaws.com/universe/register:latest
	docker push 130059590535.dkr.ecr.us-east-1.amazonaws.com/universe/register:latest

