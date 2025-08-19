# Installation

Since 4DIAC-IDE is a GUI application we are not going to use Docker to virtualize it, thus you need to install it from the official sources. In order to run 4DIAC-IDE you require `Java 1.9 SDK or later`. This installation tutorial uses Java Development Kit 21.

## 1. Install the Java Development Kit (JDK)

### For Linux (Ubuntu/Debian):

```bash
# 1. Update package list:
sudo apt update

# 2. Install OpenJDK:
sudo apt install openjdk-21-jdk

# 3. Verify installation:
java --version
```

### For Windows:
1. Download JDK 21 from [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
2. Run installer
   - Select installation directory
   - Choose components to install
   - Complete installation wizard
3. Set Environment Variables
   - Open System Properties
   - Click "Environment Variables"
   - Create new system variable:
     * Variable Name: `JAVA_HOME`
     * Variable Value: `C:\Program Files\Java\jdk-21`
   - Edit "Path" variable
   - Add `%JAVA_HOME%\bin`
4. Verify installation:
   - Open Command Prompt
   - Run `java --version`

For further details, you may refer to the [official documentation](https://docs.oracle.com/en/java/javase/21/install/installation-jdk-microsoft-windows-platforms.html) regarding the installation on Windows.

### For macOS:

1. Download JDK 21 from [Oracle JDK](https://www.oracle.com/java/technologies/downloads/).

    Depending on your Mac's CPU architecture, select one of the following options:
    a) **macOS/AArch64**: Choose this if your Mac is equipped with an Apple chip (Apple Silicon).
    b) **macOS/x64**: Opt for this if your Mac is powered by an Intel CPU.

 2. Extract the downloaded tar.gz file to your preferred directory by running the following command:
    ```bash
    tar -xf openjdk-21.0.1_macos-aarch64_bin.tar.gz -C $HOME/OpenJDK
    ```

 3. Double-click the JDK 21.pkg icon to launch the installation application, and follow the on-screen instructions to complete the installation.

 4. After installing Java
    ```
    $ export JAVA_HOME=`/usr/libexec/java_home -v 21`
    ```

For further details, you may refer to the [official documentation](https://docs.oracle.com/en/java/javase/21/install/installation-jdk-macos.html) regarding the installation on macOS.

## 2. Install Docker

### For Linux (Ubuntu/Debian):

```bash
# Update package index
sudo apt-get update

# Install dependencies
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Set up the Docker repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install Docker CE
sudo apt-get update
sudo apt-get install docker-ce docker-compose

# Add your user to the docker group (optional, allows running docker without sudo)
sudo usermod -aG docker $USER
```

**Disclaimer**: These installation instructions might be outdated, please check the [official source](https://docs.docker.com/engine/install/ubuntu/) for updated content.

### For Windows:

$\rightarrow$ **Use Windows Subsystem for Linux (WSL).**

> WSL is Windows feature that enables developers to operate a Linux environment directly on Windows, avoiding the overhead associated with a conventional virtual machine.

Please follow the [official installation tutorial](https://learn.microsoft.com/en-us/windows/wsl/install). Just make sure to run Ubuntu 24.04 within WSL (tutorial on [How to Setup a WSL Development Environment](https://learn.microsoft.com/en-us/windows/wsl/setup/environment)).

1. Download Docker Desktop from the [official website](https://docs.docker.com/desktop/setup/install/windows-install/).
2. Run the installer and follow the installation wizard.
3. Once installed, launch Docker Desktop.
4. Go to `Settings - Resources - Network`. Activate host networking.
5. Verify the installation on WSL by running the command:

```bash
# Check docker and compose versions
docker --version
docker compose --version
```

For further details, you may refer to the [official documentation](https://docs.docker.com/desktop/setup/install/windows-install/) regarding the installation on Windows.

### For MacOS:

1. Select the correct version for your system and download Docker Desktop from the [official website](https://docs.docker.com/desktop/setup/install/mac-install/).

2. Double-click **Docker.dmg** to open the installer

3. Drag the Docker icon to the Applications folder. By default, Docker Desktop is installed at `/Applications/Docker.app`.

If you're experiencing malware detection issues, follow install Docker via brew using the following steps (as documented in [docker/for-mac#7527](https://github.com/docker/for-mac/issues/7527)):
```
brew update && brew upgrade --cask docker
```

For further details, you may refer to the [official documentation](https://docs.docker.com/desktop/setup/install/mac-install/) regarding the installation on macOS.

## 3. Installing Python

For this course, you'll need to have the following software installed on your computer:

- Python 3 (e.g. via Anaconda, local installation/virtual environment)
- Build-essential packages/tools to compile software (i.e., build-essential deb package in Ubuntu)

It is advisable to use **virtual environments** for installing your project's dependencies. This practice isolates your project's dependencies from the system installation and helps to prevent conflicts with dependencies from other projects.

> The command `$ python3 -m venv <venv_name>` creates a folder in the current directory with your VE. The VE can be "activated" using a script in its binary directory (bin on Linux; Scripts on Windows). This will prepend that directory to your PATH, so that running python or python3 will invoke the VE's interpreter. Subsequently, all installed packages will be located in this folder.

### For Linux (Ubuntu/Debian):

1. Install Python3 and build-essential: `$ sudo apt install python3 python3-venv build-essential`
2. Navigate to the project folder: `$ cd <project_folder>`
3. Create a virtual environment (VE) using Python's venv module: `$ python3 -m venv <venv_name>`
4. Activate your virtual environment using: `$ source <venv-folder>\bin\activate`
5. Install requirements (you need to activate your virtual environment) using: `pip install -r <path_to_requirements.txt>`

### For Windows:

> **Follow Ubuntu's instructions on WSL.**

1. Install Python as illustrated on the Linux installation (**step 1.**).
2. Follow **steps 2 through 4** on the Linux instructions.
3. Install requirements (you need to activate your virtual environment) using: `pip install -r <path_to_requirements.txt>`

### For macOS:

Python 3.x comes pre-installed on macOS and it comes with the `venv` module by default. No additional installation is required.

1. Navigate to the project folder: `$ cd <project_folder>`
2. Create a virtual environment (VE) using Python's venv module: `$ python3 -m venv <venv_name>`
3. Activate your virtual environment using: `$ source <venv-folder>\bin\activate`
4. Install requirements (you need to activate your virtual environment) using: `pip install -r <path_to_requirements.txt>`

## 4. Download the Project (sinf-template)

All docker configurations are stored in the `docker/` directory.
So, start by cloning the template repository for SINF.

```bash
# Clone the repository or download the files
git clone git@gitlab.up.pt:sinf/sinf-template.git
cd sinf-template
```

## 5. Downloading and Installing 4DIAC-IDE

Download 4DIAC-IDE version 1.11.0 from the following [link](https://drive.google.com/drive/folders/1Vzk5gPqLEdzNYRh07CeF5kyupZAS7RZL?usp=sharing).

Select the version specific for your operating system and unpack the file to your project's root directory. You will end with the following directory structure:

```text
sinf-template/
 - 4diac-ide/
 - docker/
 - docs/
 - project/
 - scripts/
 ...
```