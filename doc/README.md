# Description
*Losungen for Conky* shows daily Bible verses in German from the Moravian church (Herrnhuter Brüdergemeine). 
It is a Perl script. Its output is shown in Conky's window.

# Copyright
## Losungen
(C) Evangelische Brüder-Unität - Herrnhuter Brüdergemeine: www.herrnhuter.de
More information: www.losungen.de

## Losungen for Conky
(C) Sven Claussner. 
The program (not the Losungen texts) is licensed under the GPL, version 3 or later; see file COPYING.

# Requirements
The program requires Linux, a Perl interpreter and the system monitor Conky.
No internet connection is required, except for the initial download of the program itself, the system monitoring program Conky and if necessary the Losungen texts.
The archive file already contains a current version of the Losungen texts.
I successfully tested the program with Perl 5, Conky 1.7-1.10 and various Linux distributions and desktop environments. 

# How to
## Installation
1. Clone the Git repository to a local directory.
2. Run 'make && make dist' or 'make && make dist-zip'.
3. Change to folder 'dist' and extract the archive file. Change to
   folder 'losung4conky'.
4. Run 'sudo make install'. This will install the program files to
   /usr/local/bin. You can choose another program directory by typing 
   'make DEST=<program directory> install' (without arrow brackets).
5. Configure your file .conkyrc: 
   1. Add the following line to the configuration section (before the line TEXT)
      text_buffer_size 768
      This will tell Conky to show the whole text.
   2. Add a call of losung.pl to the TEXT section (after the line TEXT) at the desired position. You can find hints and templates to copy in the file conky-example-rc.
6. Start Conky, using your regular user account. If Conky was already running at step 3, the changes should apply after Conky's update interval (usually a few seconds). Otherwise stop Conky and restart it.

## Uninstallation
1. Clone the Git repository to a local directory.
2. Run 'make && make dist' or 'make && make dist-zip'.
3. Change to folder 'dist' and extract the archive file. Change to
   folder 'losung4conky'.
4. Run 'sudo make uninstall' from the temporary installation directory or remove the files losung.pl and losungen*.csv from the program directory manually.
5. Undo the changes in .conkyrc.
6. Start Conky. If Conky was already running at step 2, the changes should apply after Conky's update interval (usually a few seconds). Otherwise stop Conky and restart it.

## Development and test
1. Read the current [terms of use (in German)] (https://www.losungen.de/download/nutzungsbedingungen/).
2. Download the [watchwords] (https://www.losungen.de/download/) in the format "CSV/TXT (Tab getrennt)" (tabulator separated CSV/TXT). If they don't work, try "CSV / TXT MAC (Tab getrennt)".
3. Unzip the downloaded file.
4. Rename the unzipped CSV-file to losungen< year >.csv, e.g. losungen2011.csv und copy it to the directory *data*.
5. Change to the source code root directory.
6. Create the distribution packages:
   * only the TAR- and TAR.GZ package: *make dist*
   * only the ZIP package: *make dist-zip*
7. Copy the distribution packages to a test system or the target system and install the program there.

To test Losungen for Conky with a future date (e.g. 01.01.2012), enter *sudo date -s "01 Jan 2012"* and start Conky.

# Errors and solutions
Preface: Below the phrase <Year> stands for the current year, e.g. 2011. Solutions might take effect after a little delay, depending on the setting update_interval in your file .conkyrc.

## Instead of the Bible verses nothing is shown.
### Cause
1. Probably you didn't follow the installation steps properly.
2. The configuration settings in the file .conkyrc are unsuitable for your desktop environment (GNOME, KDE etc.).

### Solution
To 1.:
Repeat the installation. If you installed the program to another than the default directory, insert the right directory name to the call in .conkyrc. You can find a template in the files conkyrc-1.9-example (for Conky 1.9) and conkyrc-1.10-example (for Conky 1.10).
To 2.:
Open the file .conkyrc in your home directory.
Find out which desktop environment you use. 
Remove the heading remarks '# '/'-- ' from the settings for your desktop environment.
Save the file.


## Instead of the Bible verses the message "The file losungen<year>.csv is missing." is shown.
### Cause
The program can't find the file "losungen<year>.csv".
### Solution
The required file is in the archive file. Copy the file there to the program directory of losungen.pl.


## Instead of the Bible verses the message "You don't have read permissions for file losungen<year>.csv." is shown.
### Cause
You don't have read access permissions for the file "losungen<year>.csv".
### Solution
Change the access permissions for this file to make it readable, or ask your system admin to do this for you (command 'chmod +r losungen<year>.csv').


## Instead of the Bible verses the message "The file losungen<year>.csv is corrupted." is shown.
### Cause
The file "losungen<year>.csv" is broken.
### Solution
Replace it with a valid version from the archive file. Copy the file there to the program directory of losungen.pl.


## The displayed text contains unreadable symbols instead of German umlauts.
### Cause
The file "losungen<year>.csv" is broken.
### Solution
Replace it with a valid version from the archive file.
Copy the file there to the program directory of losungen.pl.


## In KDE 4 the Bible verses are shown overlayed two or more times and thus are unreadable.
### Cause
Conky was started two or more times. For instance it could have been started at logon and additionally by the KDE 4 autostart mechanisms.
### Solution
1. Open a terminal window ('Shell').
2. Run ps -ef | grep conky
3. From all lines having only the word 'conky' in the last column note the value from column 2 (the process id).
4. Run kill -9 $process_id (where $process_id is each number from step 3). Repeat this step until you have only one Conky process left.
5. Check the file .profile in your HOME directory. If it has a line 'conky &', then remove this line.
