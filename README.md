# Elasticsearch with Step CLI and Certificate Renewal

This Docker image extends the official Elasticsearch image with the Step CLI installed for certificate management and a cron job to check for certificate renewal every 5 minutes. The version of the contain is tied to the version of elasticsearch. If you need a different version, clone the repo, and update the Dockerfile.

Certificate renewal depends upon already having a Step CA running and available: [Step-CA](https://smallstep.com/docs/step-ca/)

## Getting Started

To use this image, you can pull it from Docker Hub or build it locally.



Four Variables must be defined for the TLS certificates to function. Set these values to where the nodes certificates will reside:
```
CERT_LOCATION=certs/es.crt # path to es node certificate
KEY_LOCATION=certs/es.key  # path to es node certificate key
CA_URL=https://your-ca-server:port # URL to certificate authority
CA_CERT=certs/ca.pem # path to CA certificate
```

Regular elasticsearch setting will still need to be set: [Elasticsearch](https://hub.docker.com/_/elasticsearch)

### Pulling from Docker Hub

```bash
docker pull featherjr/elasticsearch-step:8.12.1
```

### Building Locally

Clone this repository and navigate to the directory containing the Dockerfile:

```bash
git clone https://github.com/exile1340/elasticsearch-step.git
cd elasticsearch-step
```

Build the Docker image:

```bash
docker build -t elasticsearch-step:8.12.1 .
```

### Running the Container

To run the Elasticsearch container with Step CLI and certificate renewal:

```bash
docker run -d --name elasticsearch-step -p 9200:9200 -v /path/to/certs:/usr/share/elasticsearch/certs featherjr/elasticsearch-step:8.12.1
```

## Certificate Renewal

The container includes a cron job that checks for certificate renewal every 5 minutes using the `cert-renewal.sh` script. Ensure that the script is correctly configured for your certificate renewal process.

## Customization

You can customize the certificate renewal script and cron job to fit your specific requirements.

## License

This project is licensed under the [GNU v3](LICENSE).

## Acknowledgments

- [Elasticsearch Docker Image](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)
- [Smallstep CLI](https://smallstep.com/docs/step-cli)