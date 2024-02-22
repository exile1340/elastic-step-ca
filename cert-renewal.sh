#!/bin/bash

# Source environment variables
source /etc/environment

# Function to print a message with a timestamp
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Check if environment variables are set
if [ -z "$CERT_LOCATION" ] || [ -z "$CA_URL" ] || [ -z "$KEY_LOCATION" ] || [ -z "$CA_CERT" ]; then
    log "Error: Required environment variables (CERT_LOCATION, CA_URL, KEY_LOCATION, CA_CERT) are not set."
    exit 1
fi

# Check if the certificate needs renewal
if step certificate needs-renewal "$CERT_LOCATION"; then
    log "Certificate is expiring soon. Renewing..."
    step ca renew $CERT_LOCATION $KEY_LOCATION --ca-url $CA_URL --root $CA_CERT -f
    log "Certificate renewed."
    log "Converting certificate to pkcs12 format"
    step certificate p12 certs/es.p12 $CERT_LOCATION $KEY_LOCATION --ca $CA_CERT --no-password --insecure -f
    log "Successfully converted to pkcs12 format"
else
    log "Certificate does not need renewal."
fi