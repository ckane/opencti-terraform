#! /bin/bash -e

# Script: ubuntu_opencti_installer.sh
# Purpose: To automate the installation of OpenCTI. Based on this manual deployment: https://www.notion.so/Manual-deployment-b911beba44234f179841582ab3894bb1
# Disclaimer: This script is written for testing and runs as root. Check the code and use at your own risk! The author is not liable for any damages or unexpected explosions!
# License: Apache 2.0

# ####################
# Function definitions
# ####################

# Function: print_banner
# Print a massive OpenCTI banner.
# Parameters: None
function print_banner {
  echo -e "\n\n\x1B[1;49;34mMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMWK00000000000000000000000000000000000000000XWMWXKKKKKKNWMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMXdcccccccccccccccccccccccccccccccccccccccclxNMW0dooooo0WMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMXdccdkOOOOOOOOOOOOOOOOOOOOOOOOkkOOOOOOOOOOOKWWWNKOkdooOWMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMXdclkNMMMMMMMMMMMMMMMMMMMMMWN0k0WMMMMMMMMMMMMXXWMWKxooOWMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMXdclkNMMMMMMMMMMMMMMMMMMMMNOdodxkO0KXNWMMMMMWKOXMMXxooOWMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMXdcckNMMMMMMMMMMMMMMMMMMWKdldOKK00OkkkkO0KXXN0x0WWXxooOWMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMXdclkNMMMMMMMMMMMMMMMMMMXdldkkkkOO0KKKK0OOkkkxoONWXxooOWMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMXdclkNMMMMMMMMMMMMMMMMMWOlokKKKK0OOkkkkO00KKKkokNWKdooOWMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMXdclkNMMMMMMMMMMMMMMMMMNxcoxkkkkO00KKKK0OkkkkdoOWNOoooOWMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMXdclkNMMMMMMMMMMMMMMMMMNkcoOKKKK0OkkkkkO0KK0xoxXN0doooOWMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMXdclkNMMMMMMMMMMMMMMMMMWOllokkkOO0KKKK00OxddoxKNKxooooOWMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMXdclkNMMMMMMMMMMMMMMMMMMKdcd0KKK0OkkkkOOkdodOXXOddddooOWMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMXdclkNMMMMMMMMMMMMMMMMMMWOlloxkOO0K0kdooox0XNKxdkK0xooOWMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMXdclkNMMMMMMMMMMMMMMMWWWMXxllxkxooooodkOKNN0kkOXWWXxooOWMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMXdclkNMMMMMMMMMMWXXXNNWWWXklclooodkOKNWNXK00XNWMMMXxooOWMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMXdcckNMMMMMMWX0OO0XNWNKOxdoolclkKNWWWWNXXNWMMMMMMMXxooOWMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMXdclkNMMMWN0xdx0NWX0kdoolldkxlldXMMMWWWMMMMMMMMMMMXxooOWMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMXdcckNMMN0dld0WWXOdollx0KOkxdlclkNMMMMMMMMMMMMMMMMKxooOWMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMNxccxNMXkllkNMNOdldO0kxxk0KXKkdllOWMMMMMMMMMMMMMMWKdod0WMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMWOlco0NkllkNMNkodxdxO0KK0kxxk0OocdKMMMMMMMMMMMMMMNOooxXMMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMMXxclxOocxXMW0olxKX0OxxxOKXKOxdlclOWMMMMMMMMMMMMWKdooOWMMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMMW0ocllll0WMNkoxxxxk0KK0kxxk0KKOdcdXMMMMMMMMMMMWXkookXMMMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMMMWOlcccoKMMXxokKXKOxxxOKXKOkxxkdcoKMMMMMMMMMMWNkooxKWMMMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMMMMNOlccoKMMNkdxxxk0KK0kxxk0KK0kocdXMMMMMMMMMWXkooxKWMMMMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMMMMMNOlclkNMWNXWNKOkxxOKKK0kxxkOdlkNMMMMMMMMWXxooxKWMMMMMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMMMMMMW0oclxKWMMMMMMWNKOxxkOKXKxllxXMMMMMMMMN0dookXWMMMMMMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMMMMMMMWKxlcokXWMMMMMMMMWX0kxxkdokXMMMMMMMWKkoodONMMMMMMMMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMMMMMMMMMN0dlldOXWMMMMMMMMMW0ookKWMMMMMMWXOdookKWMMMMMMMMMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMMMMMMMMMMWXOolloOXWMMMMMWX0k0XWMMMMMWNKkdooxKWMMMMMMMMMMMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMMMMMMMMMMMMWXOdlcox0NMMWNXNWMMMMMWNXOxoodkKNWMMMMMMMMMMMMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMMMMMMMMMMMMMMWN0xod0NMMWNWWWMWNX0OxdooxOKWMMMMMMMMMMMMMMMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMWXNWWX0kxxkOOkxdoodxOKNWMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWX0kxdoooddkO0XNWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWNXKKXNWWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM OPENCTI INSTALLER MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
  echo -e "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM\x1B[0m\n\n"
}

# Function: log_section_heading
# Prints an obnoxious line, the time (with second precision), and the section heading. This visually separates the log and makes it more readable.
# Parameters:
# - $1: section heading
function log_section_heading {
  echo
  echo "###^^^###^^^###^^^###^^^###"
  date --iso-8601=seconds
  echo $1
  echo "###^^^###^^^###^^^###^^^###"
  echo
}

# Function: check_root
# Check if we are logged in as root (UID 0) and exit if not.
# Parameters: None
function check_root {
  echo "Checking if root..."
  if [ "$EUID" -ne 0 ]
  then
    echo "Elevated privileges required. Please run with sudo or as root."
    exit
  fi
}

# Function: warn_user
# Warn the user that the script is running with root privileges and to be cautious.
# Parameters: None
function warn_user {
  echo -e "\x1B[0;49;91mThis script runs with elevated access; check the code and use at your own risk!\x1B[0m"
  echo
}

# Function: quit_on_error
# On a failure, this function prints the reason for the failure and exits the script.
# Parameters: String containing exit reason
function quit_on_error {
  if [[ $? -gt 0 ]]
  then
    echo -e "\n\n $@ ...FAIL";
    exit 10
  else
    echo "$@ ...OK"
  fi
}

# Function: update_apt_pkg
# Non-interactive package management which updates the supplied package.
# Parameters: The package to update.
function update_apt_pkg {
  DEBIAN_FRONTEND=noninteractive apt-get -qq update
  quit_on_error "Checking packages"
}
function upgrade_apt_all {
  DEBIAN_FRONTEND=noninteractive apt-get -qq -y dist-upgrade
  quit_on_error "Checking packages"
}

# Function: check_apt_pkg
# Checks if a package is installed and updates it. If the package is not installed, it is installed.
# Parameters:
# - $1: package to install
# - $2: version to install
function check_apt_pkg {
  if [[ $(dpkg -l | grep $1) ]]
  then
    echo >&2 "$1 found, attempting upgrade: executing apt-get -y install --only-upgrade '$1''$2'";
    DEBIAN_FRONTEND=noninteractive apt-get -y install --only-upgrade "$1""$2"
    quit_on_error "Upgrading $1$2"
  else
    echo >&2 "$1 missing, attempting install: executing apt-get -y install '$1''$2'";
    DEBIAN_FRONTEND=noninteractive apt-get -y install "$1""$2"
    quit_on_error "Installing $1$2"
  fi
}

# Function: check_service
# Checks if a service is active or nah. Matches TypeDB service output.
# Parameters:
# - $1: service to check
function check_service {
  if [[ $(systemctl show -p ActiveState --value "$1") == "active" ]]
  then
    echo "$1: RUNNING"
  else
    echo "$1: NOT RUNNING"
  fi
}

# Function: enable_service
# Checks if a service is disabled and enables it. If the service is already running, restart it. Otherwise, start the service.
# Parameters:
# - $1: service name
function enable_service {
  if [[ $(systemctl is-enabled "$1") == "disabled" ]]
  then
    echo "$1 service not enabled."
    systemctl enable --now "$1"
    quit_on_error "Enabling $1"
  elif [[ $(systemctl show -p SubState --value "$1") == "running" ]]
  then
    echo "$1 service already running."
    systemctl restart "$1"
    quit_on_error "Restarting $1"
  else
    echo "$1 service not running."
    systemctl start "$1"
    quit_on_error "Starting $1"
  fi
}

# Function: disable_service
# For the provided service, if it is enabled, disable it; otherwise, if it's running, stop it; otherwise do nothing.
# Parameters:
# - $1: service name
function disable_service {
  if [[ $(systemctl is-enabled "$1") == "enabled" ]]
  then
    echo "$1 service enabled. Disabling."
    systemctl disable --now "$1"
    quit_on_error "Disabling $1"
  elif [[ $(systemctl show -p SubState --value "$1") == "running" ]]
  then
    echo "$1 service still running. Stopping."
    systemctl stop "$1"
    quit_on_error "Stopping $1"
  else
    echo "$1 service not running."
    quit_on_error "Skipping $1"
  fi
}

# ################
# Define constants
# ################
opencti_docker_url="https://github.com/OpenCTI-Platform/docker.git"

# OpenCTI
# This has to be in email address format, otherwise the opencti-server service will freak out and not start correctly. - KTW
# TODO: this e-mail needs to be scrubbed and read in from Terraform
while getopts e: flag
do
  case "${flag}" in
    e) opencti_email=${OPTARG}
    ;;

    *) opencti_email="user@example.com"
    ;;
  esac
done

opencti_ver="5.5.3"
opencti_dir="/opt/opencti"
opencti_worker_count=8

# ###########
# Main script
# ###########
print_banner
check_root
warn_user

# Enter script's root directory
script_pwd="$(dirname "$0")"

if [[ -d "${script_pwd}" ]]
then
  cd "${script_pwd}"
  log_section_heading "Entering script's root directory: ${script_pwd}"
fi

# The VMs we're running are not that big and we're going to quickly fill the system log with our work (and especially the connectors). This will max out the logs at 100M.
echo "SystemMaxUse=100M" >> /etc/systemd/journald.conf

# Ensure required packages are installed at latest (or specified) version. Repositories were updated in the wrapper script.
log_section_heading "Installing and updating required packages"
update_apt_pkg
upgrade_apt_all
check_apt_pkg 'apt-transport-https'
check_apt_pkg 'curl'
check_apt_pkg 'git'
check_apt_pkg 'jq'
check_apt_pkg 'openssl'
check_apt_pkg 'software-properties-common'
check_apt_pkg 'tar'
check_apt_pkg 'wget'

# Installing docker repos
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

update_apt_pkg
check_apt_pkg 'docker-ce'
check_apt_pkg 'docker-ce-cli'
check_apt_pkg 'containerd.io'
check_apt_pkg 'docker-compose-plugin'

# OpenCTI
log_section_heading "OpenCTI package installation"

echo "OpenCTI: Cloning Docker Repo"
mkdir -p "${opencti_dir}"
git clone -b tf-main https://github.com/ckane/opencti-docker.git "${opencti_dir}/opencti-docker"
cd "${opencti_dir}/opencti-docker"

echo "OpenCTI: Edit configs"
## Setting: .app.admin.password
# RADMINPASS="opencti"
RADMINPASS="$(openssl rand -base64 25 | tr -d '/')"
MINIOPASS="$(openssl rand -base64 25 | tr -d '/')"
RABBITPASS="$(openssl rand -base64 25 | tr -d '/')"
## Setting: .app.admin.token
RADMINTOKEN="$(uuidgen -r | tr -d '\n' | tr '[:upper:]' '[:lower:]')"
OCTIID="$(uuidgen -r | tr -d '\n' | tr '[:upper:]' '[:lower:]')"
MITREID="$(uuidgen -r | tr -d '\n' | tr '[:upper:]' '[:lower:]')"
DISARMID="$(uuidgen -r | tr -d '\n' | tr '[:upper:]' '[:lower:]')"
CISAID="$(uuidgen -r | tr -d '\n' | tr '[:upper:]' '[:lower:]')"

cat > "${opencti_dir}/opencti-docker/.env" << END_DOT_ENV
OPENCTI_ADMIN_EMAIL=${opencti_email}
OPENCTI_ADMIN_PASSWORD=${RADMINPASS}
OPENCTI_ADMIN_TOKEN=${RADMINTOKEN}
OPENCTI_BASE_URL=http://localhost:8080
MINIO_ROOT_USER=opencti
MINIO_ROOT_PASSWORD=${MINIOPASS}
RABBITMQ_DEFAULT_USER=opencti
RABBITMQ_DEFAULT_PASS=${RABBITPASS}
CONNECTOR_EXPORT_FILE_STIX_ID=dd817c8b-abae-460a-9ebc-97b1551e70e6
CONNECTOR_EXPORT_FILE_CSV_ID=7ba187fb-fde8-4063-92b5-c3da34060dd7
CONNECTOR_EXPORT_FILE_TXT_ID=ca715d9c-bd64-4351-91db-33a8d728a58b
CONNECTOR_IMPORT_FILE_STIX_ID=72327164-0b35-482b-b5d6-a5a3f76b845f
CONNECTOR_IMPORT_DOCUMENT_ID=c3970f8a-ce4b-4497-a381-20b7256f56f0
CONNECTOR_OPENCTI_ID=${OCTIID}
CONNECTOR_MITRE_ID=${MITREID}
CONNECTOR_DISARM_ID=${DISARMID}
CONNECTOR_CISA_VULNS_ID=${CISAID}
SMTP_HOSTNAME=localhost
ELASTIC_MEMORY_SIZE=4G
END_DOT_ENV

echo "Setting vm.max_map_count to 1048575"
sysctl -w vm.max_map_count=1048575
echo vm.max_map_count=1048575 >> /etc/sysctl.conf

echo "OpenCTI: Cloning Connectors Repo"
git clone https://github.com/OpenCTI-Platform/connectors.git "${opencti_dir}/opencti-connectors"

connector_containers="internal-import-file/import-document internal-import-file/import-file-stix"
connector_containers="${connector_containers} internal-export-file/export-file-stix"
connector_containers="${connector_containers} internal-export-file/export-file-csv"
connector_containers="${connector_containers} internal-export-file/export-file-txt"
connector_containers="${connector_containers} external-import/opencti"
connector_containers="${connector_containers} external-import/mitre"
connector_containers="${connector_containers} external-import/disarm-framework"
connector_containers="${connector_containers} external-import/cisa-known-exploited-vulnerabilities"

for cdir in ${connector_containers}; do
    cd "${opencti_dir}/opencti-connectors/${cdir}"
    docker build -t "opencti/connector-$(basename $cdir):5.5.3" .
done

echo "Starting Docker"
cd "${opencti_dir}/opencti-docker"
set -a; source .env
docker compose up --wait

# Clean up packages
log_section_heading "Clean up packages"
apt-get clean
apt-get autoremove -y
