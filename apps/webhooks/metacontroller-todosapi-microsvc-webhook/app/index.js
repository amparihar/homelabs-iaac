const express = require('express'),
    cors = require('cors');

const app = express();
app.set("port", 8001);
app.use(cors());
app.use(express.json());

app.post('/sync', (req, res, next) => {
    let syncHookReq = req.body.request,
        parent = syncHookReq.parent,
        children = syncHookReq.children;

    console.log(JSON.stringify(parent));
    console.log(JSON.stringify(children));

    let desired_status = {
        "services" : Object.keys(children["Service.v1"]).length,
        "deployments" : Object.keys(children["Deployment.apps/v1"]).length,
        "virtualnodes" : Object.keys(children["VirtualNode.appmesh.k8s.aws/v1beta2"]).length,
        "virtualservices" : Object.keys(children["VirtualService.appmesh.k8s.aws/v1beta2"]).length,
        "virtualrouter" : Object.keys(children["VirtualRouter.appmesh.k8s.aws/v1beta2"]).length,
        "gatewayroute" : Object.keys(children["GatewayRoute.appmesh.k8s.aws/v1beta2"]).length,
    };
    
    let name        = parent["spec"]["svcName"],
        port        = parent["spec"]["targetPort"];
    

    let desired_pods = [
        {
            "apiVersion": "v1",
            "kind": "Service",
            "metadata": {
                "name": name
            },
            "spec": {
                "ports": [{ "port": port }],
                "selector": { "app": name }
            }
        },
        {
            "apiVersion": "apps/v1",
            "kind": "Deployment",
            "metadata": {
              "name": name
            },
            "spec": {
                "replicas": 1,
                "selector": {
                    "matchLabels" : {
                        "app": name
                        "version" : "v1"
                    }
                },
                "template" : {
                    
                }
            }
              replicas: 1
              selector:
                matchLabels:
                  app: user
                  version: v1
              template:
                metadata:
                  labels:
                    app: user
                    version: v1
                 
                spec:
                  serviceAccountName: todos-api-pod
                  containers:
                    - name: user
                      image: aparihar/todos-user-microsvc:3.0
                      readinessProbe:
                        httpGet:
                          path: /api/user/health-check
                          port: 4096
                          scheme: HTTP
                        initialDelaySeconds: 5
                        periodSeconds: 10
                      imagePullPolicy: IfNotPresent
                      ports:
                        - containerPort: 4096
                      env:
                        - name: RDS_HOST
                          value: "database.todos-api.svc.cluster.local"
                        - name: RDS_PORT
                          valueFrom:
                            secretKeyRef:
                              name: database-connection-secret
                              key: RDS_PORT
                        - name: RDS_DB_NAME
                          valueFrom:
                            secretKeyRef:
                              name: database-connection-secret
                              key: RDS_DB_NAME
                        - name: RDS_USERNAME
                          valueFrom:
                            secretKeyRef:
                              name: database-connection-secret
                              key: RDS_USERNAME
                        - name: RDS_PASSWORD
                          valueFrom:
                            secretKeyRef:
                              name: database-connection-secret
                              key: RDS_PASSWORD
                        - name: RDS_CONN_POOL_SIZE
                          value: "2"
                        - name: JWT_ACCESS_TOKEN
                          valueFrom:
                            secretKeyRef:
                              name: auth-secret
                              key: JWT_ACCESS_TOKEN
                      resources:
                        limits:
                          cpu: 256m
                          memory: 64Mi
                        requests:
                          cpu: 256m
                          memory: 32Mi
        }
        
    ];
        
    

    res.status(200).send({ "status": desired_status, "children": desired_pods });

});


app.listen(app.get("port"), function() {
    console.log("meta controller sync started on port " + app.get("port"));
});