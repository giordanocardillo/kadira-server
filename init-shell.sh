# DB settings
export APP_MONGO_URL="mongodb://localhost/kadiraApps"
export APP_MONGO_OPLOG_URL="mongodb://localhost/local"
export DATA_MONGO_URL="mongodb://localhost/kadiraData"
export MAIL_URL="smtp://postmaster%40kadira.io:9jx4fqhdfbg5@smtp.mailgun.org:587"

# Engine settings
export ENGINE_PORT=11011

# UI settings
export UI_PORT=4000
export UI_URL="http://localhost:$UI_PORT"
# CPU Profiler needs a s3 bucket
export AWS_DEFAULT_REGION="eu-central-1"
export AWS_ACCESS_KEY_ID="AWSID"
export AWS_SECRET_ACCESS_KEY="AWSKEY"
# Monitoring Setup

export LIBRATO_EMAIL
export LIBRATO_TOKEN
