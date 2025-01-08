#!/bin/bash

# Variables
ARTEMIS_VERSION="2.39.0"
ARTEMIS_TAR="apache-artemis-${ARTEMIS_VERSION}-bin.tar.gz"
ARTEMIS_URL="https://archive.apache.org/dist/activemq/activemq-artemis/${ARTEMIS_VERSION}/${ARTEMIS_TAR}"
KEYS_URL="https://downloads.apache.org/activemq/KEYS"
SIGNATURE_URL="${ARTEMIS_URL}.asc"
SHA512_URL="${ARTEMIS_URL}.sha512"

# Update the system
echo "Updating the system..."
sudo apt update -y
sudo apt upgrade -y

# Check Java version
JAVA_VERSION=$(java -version 2>&1 | grep -E -o '[0-9]+\.[0-9]+' | head -n 1)

if [[ -z "$JAVA_VERSION" ]]; then
    echo "Java is not installed. Installing OpenJDK 17..."
    sudo apt install openjdk-17-jdk -y

    # Configure Java alternatives to set Java 17 as default
    echo "Configuring Java 17 as default..."
    sudo update-alternatives --set java /usr/lib/jvm/java-17-openjdk-amd64/bin/java
    sudo update-alternatives --set javac /usr/lib/jvm/java-17-openjdk-amd64/bin/javac
else
    # Check if the installed version is less than 17
    if (( $(echo "$JAVA_VERSION < 17" | bc -l) )); then
        echo "Java version is less than 17. Installing OpenJDK 17..."
        sudo apt install openjdk-17-jdk -y

        # Configure Java alternatives to set Java 17 as default
        echo "Configuring Java 17 as default..."
        sudo update-alternatives --set java /usr/lib/jvm/java-17-openjdk-amd64/bin/java
        sudo update-alternatives --set javac /usr/lib/jvm/java-17-openjdk-amd64/bin/javac
    else
        echo "Java version $JAVA_VERSION is already installed and is compatible."
    fi
fi

# Verify Java installation
java -version

# Download ActiveMQ Artemis
echo "Downloading ActiveMQ Artemis..."
wget ${ARTEMIS_URL} -O ${ARTEMIS_TAR}
wget ${KEYS_URL}
wget ${SIGNATURE_URL}
wget ${SHA512_URL}

# Verify the SHA-512 checksum
echo "Verifying SHA-512 checksum..."
sha512sum -c ${ARTEMIS_TAR}.sha512

if [ $? -ne 0 ]; then
    echo "SHA-512 checksum verification failed!"
    exit 1
fi

# Verify the GPG signature
echo "Importing GPG keys..."
gpg --import KEYS

echo "Verifying GPG signature..."
gpg --verify ${SIGNATURE_URL} ${ARTEMIS_TAR}

if [ $? -ne 0 ]; then
    echo "GPG signature verification failed!"
    exit 1
fi

# Extract the downloaded file
echo "Extracting ActiveMQ Artemis..."
tar -xzf ${ARTEMIS_TAR}
rm ${ARTEMIS_TAR} KEYS ${SIGNATURE_URL} ${SHA512_URL}

# Create a broker
cd "apache-artemis-${ARTEMIS_VERSION}"
echo "Creating the broker..."
./bin/artemis create mybroker --user admin --password admin --require-login

# Start the broker
echo "Starting ActiveMQ Artemis..."
cd mybroker
./bin/artemis start

# Display the management console URL
echo "ActiveMQ Artemis is running."
echo "You can access the management console at: http://localhost:8161/console"
echo "Username: admin"
echo "Password: admin"

# End of script
echo "Installation and configuration of ActiveMQ Artemis completed."