package io.fnproject.kafkaconnect.sink;

import com.oracle.bmc.auth.BasicAuthenticationDetailsProvider;
import org.apache.kafka.common.config.ConfigDef;
import org.apache.kafka.connect.connector.Task;
import org.apache.kafka.connect.sink.SinkConnector;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FnSinkConnector extends SinkConnector {
    private Map<String, String> configProperties;

    @Override
    public void start(Map<String, String> config) {
        this.configProperties = config;
        BasicAuthenticationDetailsProvider provider = IdentityOciProvider.provider;
        System.out.println("FnSinkConnector started with config " + config + " and identity "+ provider);
    }

    @Override
    public Class<? extends Task> taskClass() {
        return FnInvocationTask.class;
    }

    @Override
    public List<Map<String, String>> taskConfigs(int numOfMaxTasks) {
        System.out.println("Max Tasks is : " + numOfMaxTasks);

        List<Map<String, String>> taskConfigs = new ArrayList<>();
        Map<String, String> properties = new HashMap<>();
        properties.putAll(configProperties);
        for (int i = 0; i < numOfMaxTasks; i++) {
            taskConfigs.add(properties);
        }
        System.out.println("Task configuration complete..");
        return taskConfigs;
    }

    @Override
    public void stop() {
        System.out.println("Connector stopped");
    }

    @Override
    public ConfigDef config() {
        System.out.println("Fetching connector config");
        return FnInvocationConfig.getConfigDef();
    }

    @Override
    public String version() {
        return "v1.0";
    }

}
