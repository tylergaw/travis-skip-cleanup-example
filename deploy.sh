export NODE_ENV=production
npm run build # This works in Precise, but fails in Trusty.
# This is where we'd deploy the artifacts from npm run build above. (usually to S3)
