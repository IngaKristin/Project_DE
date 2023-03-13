helm delete gp9-sharded --kube-insecure-skip-tls-verify --debug
kubectl --insecure-skip-tls-verify delete pvc --all
kubectl --insecure-skip-tls-verify delete pv --all
