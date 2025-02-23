CODE_BUCKET_NAME = lambda-code-bucket-name # Change this

setup:
	cd code && \
	uv venv && \
	source .venv/bin/activate && \
	uv pip install -r requirements-dev.txt && \
	cd ..

build:
	docker run --rm -v $(PWD)/code:/code -w /code amazonlinux:latest \
	bash -c "yum install -y python3-pip && pip3 install --no-cache-dir -r requirements.txt -t package/"
	cd code && cd package && zip -r ../../lambda.zip . && cd .. && zip -g ../lambda.zip lambda_function.py && cd ..
	cp lambda.zip infra/lambda.zip

init:
	terraform -chdir=infra init

plan:
	terraform -chdir=infra plan

apply:
	terraform -chdir=infra apply

destroy:
	terraform -chdir=infra destroy

deploy:
	aws s3 cp lambda.zip s3://${CODE_BUCKET_NAME}/pdfsplitter/lambda.zip && \
	aws lambda update-function-code \
	--function-name pdf_splitter_lambda \
	--s3-bucket ${CODE_BUCKET_NAME} \
	--s3-key pdfsplitter/lambda.zip

cleanup:
	aws s3 rm --recursive s3://${CODE_BUCKET_NAME}
	terraform -chdir=infra destroy
