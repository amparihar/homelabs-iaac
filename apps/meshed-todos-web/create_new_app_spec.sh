#!/bin/bash
if [ $# -lt 2 ]; then
    echo "Command line contains $# arguments. Please specify both ContainerName and ContainerPort."
    exit 1
fi
appspec_json=$(cat <<EOF
{
  "version": 0.0,
  "Resources": [
    {
      "TargetService": {
        "Type": "AWS::ECS::Service",
        "Properties": {
          "TaskDefinition": <TASK_DEFINITION>,
          "LoadBalancerInfo": {
            "ContainerName": "$1",
            "ContainerPort": $2
          }
        }
      }
    }
  ]
}
EOF
)
echo "$appspec_json";
echo "$appspec_json" > appspec.json