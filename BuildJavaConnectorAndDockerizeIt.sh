
docker build --build-arg PRIVATE_KEY_NAME=private_key.pem -t kafka-connect-fn-sink .


docker run --rm -it  \
  --name=kafka-connect \
  --net=host \
  -e CONNECT_BOOTSTRAP_SERVERS=streaming.us-phoenix-1.oci.oraclecloud.com:9092 \
  -e CONNECT_REST_PORT=8082 \
  -e CONNECT_GROUP_ID="quickstart" \
  -e CONNECT_CONFIG_STORAGE_TOPIC="ocid1.connectharness.oc1.phx.amaaaaaauwpiejqai6tacsbd2v4azp6ltnbuqtlvbzrmxvtv26mnumoouoaq-config" \
  -e CONNECT_OFFSET_STORAGE_TOPIC="ocid1.connectharness.oc1.phx.amaaaaaauwpiejqai6tacsbd2v4azp6ltnbuqtlvbzrmxvtv26mnumoouoaq-offsets" \
  -e CONNECT_STATUS_STORAGE_TOPIC="ocid1.connectharness.oc1.phx.amaaaaaauwpiejqai6tacsbd2v4azp6ltnbuqtlvbzrmxvtv26mnumoouoaq-status" \
  -e CONNECT_KEY_CONVERTER="org.apache.kafka.connect.json.JsonConverter" \
  -e CONNECT_VALUE_CONVERTER="org.apache.kafka.connect.json.JsonConverter" \
  -e CONNECT_INTERNAL_KEY_CONVERTER="org.apache.kafka.connect.json.JsonConverter" \
  -e CONNECT_INTERNAL_VALUE_CONVERTER="org.apache.kafka.connect.json.JsonConverter" \
  -e CONNECT_REST_ADVERTISED_HOST_NAME="localhost" \
  -e CONNECT_LOG4J_ROOT_LOGLEVEL="INFO" \
  -e CONNECT_PLUGIN_PATH="/usr/share/java" \
                                         \
  -e CONNECT_SASL_MECHANISM=PLAIN \
  -e CONNECT_SECURITY_PROTOCOL=SASL_SSL \
  -e CONNECT_SASL_JAAS_CONFIG="org.apache.kafka.common.security.plain.PlainLoginModule required username=\"intrandallbarnes/mayur.raleraskar@oracle.com/ocid1.streampool.oc1.phx.amaaaaaauwpiejqactzuddgmegg42gkhwpz24wy6k7ka3n24nc52mpzqfvua\" password=\"2m{s4WTCXysp:o]tGx4K\";" \
  -e CONNECT_PRODUCER_SASL_MECHANISM=PLAIN \
  -e CONNECT_PRODUCER_SECURITY_PROTOCOL=SASL_SSL \
  -e CONNECT_PRODUCER_SASL_JAAS_CONFIG="org.apache.kafka.common.security.plain.PlainLoginModule required username=\"intrandallbarnes/mayur.raleraskar@oracle.com/ocid1.streampool.oc1.phx.amaaaaaauwpiejqactzuddgmegg42gkhwpz24wy6k7ka3n24nc52mpzqfvua\" password=\"2m{s4WTCXysp:o]tGx4K\";" \
  -e CONNECT_CONSUMER_SASL_MECHANISM=PLAIN \
  -e CONNECT_CONSUMER_SECURITY_PROTOCOL=SASL_SSL \
  -e CONNECT_CONSUMER_SASL_JAAS_CONFIG="org.apache.kafka.common.security.plain.PlainLoginModule required username=\"intrandallbarnes/mayur.raleraskar@oracle.com/ocid1.streampool.oc1.phx.amaaaaaauwpiejqactzuddgmegg42gkhwpz24wy6k7ka3n24nc52mpzqfvua\" password=\"2m{s4WTCXysp:o]tGx4K\";" \
  kafka-connect-fn-sink:latest


sleep 5

curl -X POST \
  http://localhost:8082/connectors \
  -H 'content-type: application/json' \
  -d '{
  "name": "FnSinkConnector",
  "config": {
    "connector.class": "io.fnproject.kafkaconnect.sink.FnSinkConnector",
    "tasks.max": "2",
    "topics": "test-sink-topic",
    "tenant_ocid": "<tenant_ocid>",
    "user_ocid": "<user_ocid>",
    "public_fingerprint": "<public_fingerprint>",
    "private_key_location": "/etc/kafka-connect/secrets/<private_key_name>",
    "function_url": "<FUNCTION_URL>"
  }
}'