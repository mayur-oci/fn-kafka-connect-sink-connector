package io.fnproject.kafkaconnect.sink;

import com.oracle.bmc.ConfigFileReader;
import com.oracle.bmc.auth.AuthenticationDetailsProvider;
import com.oracle.bmc.auth.BasicAuthenticationDetailsProvider;
import com.oracle.bmc.auth.ConfigFileAuthenticationDetailsProvider;

import java.io.File;
import java.io.IOException;

public class IdentityOciProvider {
    // OCI Auth provider is needed for accessing Object Storage
    final static BasicAuthenticationDetailsProvider provider = (AuthenticationDetailsProvider) getOciAuthProvider();

    private static BasicAuthenticationDetailsProvider getOciAuthProvider() {
        final BasicAuthenticationDetailsProvider provider = null;
        try {
            int a = 10 / 0;
            //provider = InstancePrincipalsAuthenticationDetailsProvider.builder().build();
            //return provider;
        } catch (Exception e) {
            try {
                File file = new File("/oci/config");
                final ConfigFileReader.ConfigFile configFile;
                configFile = ConfigFileReader.parse(file.getAbsolutePath(), "MAYUR_ADMIN_PHX");
                return new ConfigFileAuthenticationDetailsProvider(configFile);
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
            throw e;
        }
        return null;
    }
}
