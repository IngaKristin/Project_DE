helm upgrade gp9-sharded bitnami/mongodb-sharded --debug --kube-insecure-skip-tls-verify --debug  \
    --set common.persistence.mountPath="/home/ubuntu/" \
    --set common.persistence.storageClass="local-path" \
    --set global.persistence.mountPath="/home/ubuntu/" \
    --set global.mountPath="/home/ubuntu/" \
    --set global.storageClass="local-path" \
    --set persistence.storageClass="local-path" \
    --set configsvr.persistence.enabled=true \
    --set configsvr.persistence.size=8Gi \
    --set configsvr.persistence.mountPath="/home/ubuntu/" \
    --set configsvr.persistence.storageClass="local-path" \
    --set shardsvr.persistence.storageClass="local-path" \
    --set shardsvr.persistence.size=20Gi \
    --set shardsvr.persistence.mountPath="/home/ubuntu/" \
    --set auth.rootPassword="fg3259prf91fni239dduSGh245" \
    --set volumePermissions.enabled=true \
    --set mongos.persistence.mountPath="/home/ubuntu/" \
    --set mongos.replicaCount=2 \
    --set shards=7

