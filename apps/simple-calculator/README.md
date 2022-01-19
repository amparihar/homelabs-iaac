curl -X GET [URL]

curl -X POST -H "Content-Type: application/json" \
-d '{"operand1": 10, "operand2": 20}' \
[URL]

docker run -d --rm -p 9001:9001 -v ~/environment/mydata:/data -e DATA_PATH=/data/count.txt --name calc simple-calc