resource "aws_s3_bucket" "reminder-bucket-gal" {
  bucket = "reminder-bucket-gal"
  acl    = "public-read"
  policy = data.aws_iam_policy_document.website_policy.json
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket       = aws_s3_bucket.reminder-bucket-gal.id
  key          = "index.html"
  source       = "${path.module}/static_website/index.html"
  acl          = "public-read"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "error" {
  bucket       = aws_s3_bucket.reminder-bucket-gal.id
  key          = "error.html"
  source       = "${path.module}/static_website/error.html"
  acl          = "public-read"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "cat" {
  bucket = aws_s3_bucket.reminder-bucket-gal.id
  key    = "cat.png"
  source = "${path.module}/static_website/cat.png"
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "formlogic" {
  bucket = aws_s3_bucket.reminder-bucket-gal.id
  key    = "formlogic.js"
  source = "${path.module}/static_website/formlogic.js"
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "img" {
  bucket = aws_s3_bucket.reminder-bucket-gal.id
  key    = "IMG_0991.jpg"
  source = "${path.module}/static_website/IMG_0991.jpg"
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "main" {
  bucket = aws_s3_bucket.reminder-bucket-gal.id
  key    = "main.css"
  source = "${path.module}/static_website/main.css"
  acl    = "public-read"
}
