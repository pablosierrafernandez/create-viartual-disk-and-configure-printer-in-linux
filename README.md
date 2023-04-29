# create-viartual-disk-and-configure-printer-in-linux
💿Two scripts in Bash to configure a virtual disk and a printer in Linux

## impresora.sh

### Overview

`impresora.sh` is a script to configure the printing system with CUPS 2.3.3. It also configures a virtual printer named `impresoraV` that converts the documents to be printed into PDF documents. By default, these documents are saved in a directory called `DocsPDF` followed by the user's login who is printing. This directory will hang from `/mnt/mem`. It will be the default printer and its options are horizontal pagination, black and white, and two pages per page.

### Usage

`impresora.sh [-h]` 

### Options

`-h: Displays help information about the script.` 

### Prerequisites

-   Run as root.
-   CUPS package should be installed.

### Examples

To execute the script, navigate to the directory containing the script and run the following command:

`sudo ./impresora.sh` 

## montar.sh

### Overview

`montar.sh` is a script to create two virtual memory disks. One disk is 100 MB in size and is mounted in the `Baixades` directory of the user. The other disk is in `tmpfs` format and is mounted on `/mnt/mem`. The disk mounted on `/mnt/mem` will be automatically loaded whenever the machine boots, and all system users can read and write to it. The disk mounted on `Baixades` will be mounted at the time the user logs in, and there will be one for each connected user. When the user logs out of the system, the disk can be deleted.

### Usage

`montar.sh [-h]` 

### Options

`-h: Displays help information about the script.` 

### Prerequisites

-   Run as root.

### Examples

To execute the script, navigate to the directory containing the script and run the following command:

`sudo ./montar.sh` 

That's it! Remember to provide proper file permissions to the scripts before executing them, and ensure that you have the required permissions to run the scripts.
