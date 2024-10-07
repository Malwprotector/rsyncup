# RSyncup
![SEPAQRcode logo](https://main.st4lwolf.org/media/rsyncup.png)

RSyncup is a Linux Bash script designed to help users back up important folders to different storage locations using the `rsync` utility. The script provides a simple interface to select source and destination paths for backup while ensuring that the data is synchronized correctly.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Script Details](#script-details)
- [Disclaimer](#Disclaimer)
- [License](#license)

## Features

- User-friendly command-line interface for selecting source and destination paths.
- Automatically checks for required utilities (`figlet` and `pv`).
- Displays the total size of files to be backed up.
- Confirmation prompt before proceeding with the backup operation.
- Supports file modification and deletion synchronization using `rsync`.

## Requirements

Before running the script, ensure that the following packages are installed on your system:

- `figlet`: For displaying the title in a stylized format.
- `pv`: For showing progress during the backup operation.
- `rsync`: For performing the backup itself.

You can install the required packages using the following commands:

```bash
sudo apt install figlet pv rsync
```

## Installation

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/malwprotector/rsyncup.git
   cd RSyncup
   ```

2. Make the script executable:

   ```bash
   chmod +x rsyncup.sh
   ```

## Usage

To run the script, simply execute it in your terminal:

```bash
bash rsyncup.sh
```

Follow the prompts to select the source and destination paths. The script will display a summary of the backup operation and ask for confirmation before proceeding.

### Example

```bash
*** Summary of Backup Operation ***
Source: /media/user/SSD DISK
Destination: /media/user/EXTENSION DISK T3
Total size to backup: 58,0G
Do you want to proceed with the backup? (y/n): 

```

Output will guide you through the process of selecting the source and destination for your backup.

## Script Details

### Color Codes

The script uses ANSI escape codes to format the output with colors:
- **Green**: Indicates success messages.
- **Red**: Indicates error messages.
- **Yellow**: Used for warnings or important notices.
- **Cyan**: General informational messages.

### Functions

- `select_device()`: Lists available drives, prompting the user to enter source and destination paths.
- `calculate_total_size()`: Calculates and displays the total size of the files to be backed up.
- `confirm_backup()`: Displays a summary of the backup operation and asks for user confirmation to proceed.
- `perform_backup()`: Executes the backup operation using `rsync`, showing a progress bar for the entire process.

## Disclaimer

This script is provided "as is," without any warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, and non-infringement. The author shall not be liable for any damages arising from the use of this script, including but not limited to direct, indirect, incidental, punitive, and consequential damages. Users are responsible for ensuring that they have appropriate backups and that they fully understand the implications of using this script.

## License

This project is licensed under the  [CC-BY-NC-SA 4.0 License.](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en)
