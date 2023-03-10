
kubectl --insecure-skip-tls-verify create secret tls gp9-agent-certs \
  --cert=./agent-cert.crt \
  --key=./agent-key.key

kubectl --insecure-skip-tls-verify create secret tls gp9-mongos-certs \
  --cert=./mongos-cert.crt \
  --key=./mongos-key.key
