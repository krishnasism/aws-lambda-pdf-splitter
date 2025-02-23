import os
import json
import boto3
import PyPDF2
from io import BytesIO

s3 = boto3.client("s3")
DEST_BUCKET = os.environ["DEST_BUCKET"]


def lambda_handler(event, context):
    for record in event["Records"]:
        source_bucket = record["s3"]["bucket"]["name"]
        object_key = record["s3"]["object"]["key"]

        # Extract the document name (without .pdf extension)
        doc_name = object_key.split("/")[-1].replace(".pdf", "")

        # Get the PDF from S3
        response = s3.get_object(Bucket=source_bucket, Key=object_key)
        pdf_reader = PyPDF2.PdfReader(BytesIO(response["Body"].read()))

        for i, page in enumerate(pdf_reader.pages):
            page_number = i + 1
            pdf_writer = PyPDF2.PdfWriter()
            pdf_writer.add_page(page)

            # Generate output PDF name
            output_pdf_key = f"{doc_name}_page_{page_number}.pdf"

            # Save the page to a PDF
            output_stream = BytesIO()
            pdf_writer.write(output_stream)
            output_stream.seek(0)

            # Upload the split PDF page
            s3.put_object(Bucket=DEST_BUCKET, Key=output_pdf_key, Body=output_stream)

            # Generate metadata file for bedrock
            metadata = {
                "metadataAttributes": {
                    "originalDocument": doc_name,
                    "pageNumber": page_number,
                }
            }

            metadata_key = f"{output_pdf_key}.metadata.json"
            s3.put_object(
                Bucket=DEST_BUCKET, Key=metadata_key, Body=json.dumps(metadata)
            )

    return {"statusCode": 200, "body": "PDF pages and metadata uploaded successfully"}
