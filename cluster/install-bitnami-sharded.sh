helm delete gp9-sharded --kube-insecure-skip-tls-verify
kubectl --insecure-skip-tls-verify delete pvc --all
kubectl --insecure-skip-tls-verify delete pv --all
helm install gp9-sharded bitnami/mongodb-sharded --version=5.1.4 --kube-insecure-skip-tls-verify --set shards=3  \
    --set configsrv.persistence.enabled=true \
    --set configsvr.persistence.storageClass="local-path" \
    --set configsvr.persistence.mountPath=/home/ubuntu/ \
    --set common.persistence.mountPath=/home/ubuntu/ \
    --set common.persistence.storageClass="local-path" \
    --set shardsvr.persistence.mountPath=/home/ubuntu/ \
    --set shardsvr.persistence.storageClass="local-path" \
    --set persistence.storageClass="local-path" \
    --set auth.rootPassword="fg3259prf91fni239dduSGh245"
