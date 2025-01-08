```markdown
# ActiveMQ Artemis Installation Script

This repository contains a shell script for installing and configuring Apache ActiveMQ Artemis version 2.39.0 on Ubuntu 24. The script ensures that Java 17 is installed and set as the default version or retains a higher version if present.

## Prerequisites

- Ubuntu 24
- Internet connection

## Features

- Automatically installs OpenJDK 17 if it's not already installed.
- Sets OpenJDK 17 as the default Java version if no higher version is present.
- Downloads and verifies the integrity of ActiveMQ Artemis.
- Creates a broker with default credentials.
- Starts the ActiveMQ Artemis server.

## Installation Instructions

1. **Clone the Repository** (or create a new script file):
   ```bash
   git clone <repository_url>
   cd <repository_directory>
   ```

   Or create a new script file:
   ```bash
   nano install_artemis.sh
   ```

2. **Copy the Script**: Paste the installation script into `install_artemis.sh` file.

3. **Make the Script Executable**:
   ```bash
   chmod +x install_artemis.sh
   ```

4. **Run the Script**:
   ```bash
   ./install_artemis.sh
   ```

## Accessing the Management Console

Once the script has completed successfully, you can access the ActiveMQ Artemis management console at:

```
http://localhost:8161/console
```

- **Username**: `admin`
- **Password**: `admin`

## Integrity Verification

The script verifies the integrity of the downloaded ActiveMQ Artemis files using SHA-512 checksum and GPG signatures. It will exit if any verification fails.

## Troubleshooting

If you encounter issues during installation:

- Ensure you have an active internet connection.
- Check for any error messages provided by the script.
- Make sure you have sufficient permissions (run the script with `sudo` if necessary).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Feel free to submit issues or pull requests if you want to contribute to this project or suggest improvements.

## Author

This script was created for easy installation and setup of ActiveMQ Artemis. For more information, visit the [Apache ActiveMQ Artemis website](https://activemq.apache.org/components/artemis/).
```
