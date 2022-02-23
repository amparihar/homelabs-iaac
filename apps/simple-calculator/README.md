curl -X GET http://example.com

curl -X POST -H "Content-Type: application/json" \
     -d '{"operand1": 10, "operand2": 20}' \
    http://example.com

## add multiple headers
curl -H "Accept-Charset: utf-8" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -H "Connection: keep-alive"
      http://example.com

docker run -d --rm -p 9001:9001 -v ~/environment/mydata:/data -e DATA_PATH=/data/count.txt --name calc simple-calc