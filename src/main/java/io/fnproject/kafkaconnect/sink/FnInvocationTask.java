package io.fnproject.kafkaconnect.sink;

import org.apache.kafka.common.TopicPartition;
import org.apache.kafka.connect.sink.SinkRecord;
import org.apache.kafka.connect.sink.SinkTask;

import java.util.Collection;
import java.util.Map;

public class FnInvocationTask extends SinkTask {

    private Map<String, String> config;

    @Override
    public void start(Map<String, String> config) {
        System.out.println("Task started with config... " + config);
        this.config = config;
    }

    @Override
    public void open(Collection<TopicPartition> partitions) {
        super.open(partitions);
        this.context.assignment().stream()
                .forEach((tp) -> System.out.println("Task assigned partition " + tp.partition() + " in topic " + tp.topic()));
    }


    @Override
    public void put(Collection<SinkRecord> records) {
        System.out.println("No. of records " + records.size());

        for (SinkRecord record : records) {
            System.out.println("Got record from offset " + record.kafkaOffset() + " in partition " + record.kafkaPartition() + " of topic " + record.topic());
            System.out.println("Message with value " + (String) record.value());
        }
    }

    @Override
    public void stop() {
        System.out.println("Task stopped... ");
    }

    @Override
    public String version() {
        System.out.println("Getting Task version...");
        return "v1.0";
    }
}
