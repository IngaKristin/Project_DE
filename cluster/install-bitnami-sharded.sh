helm install gp9-sharded bitnami/mongodb-sharded --debug --kube-insecure-skip-tls-verify --debug --set shards=5  \
    --set configsrv.persistence.enabled=true \
    --set configsvr.persistence.size=8Gi \
    --set configsvr.persistence.storageClass="local-path" \
    --set common.persistence.storageClass="local-path" \
    --set shardsvr.persistence.storageClass="local-path" \
    --set shardsvr.persistence.size=20Gi \
    --set persistence.storageClass="local-path" \
    --set global.storageClass="local-path" \
    --set auth.rootPassword="fg3259prf91fni239dduSGh245" \
    --set volumePermissions.enabled=true \
    --set shardsvr.persistence.mountPath="/home/ubuntu/" \
    --set configsvr.persistence.mountPath="/home/ubuntu/" \
    --set common.persistence.mountPath="/home/ubuntu/" \
    --set global.persistence.mountPath="/home/ubuntu/" \
    --set global.mountPath="/home/ubuntu/" \

