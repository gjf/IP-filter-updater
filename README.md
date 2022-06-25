# IP filter updater
IP filter updater for torrent downloaders

Now this tool downloads filters from the following URLs by default:
https://github.com/DavidMoore/ipfilter/releases/download/lists/ipfilter.dat.gz

http://upd.emule-security.org/ipfilter.zip

If you want to add your own filters - you can add them in command line using local files or URLS using the following syntax:
IPfilterDL.exe <key1> <path1> <key2> <path2>, where:
<key>: if it is "+" symbol (without quotes) - it means the appropriate <path> is URL, if it is "-" symbol (without quotes) - it means the appropriate <path> is path to local file.

Examples:
 
-----------------------------------------------------------------------
1) 
IPfilterDL.exe
 
Two default sources will be downloaded
 
-----------------------------------------------------------------------
2)
IPfilterDL.exe - myfilter.dat
 
Two default sources will be downloaded, after that local file myfilter.dat will be added. 
Please note: local filter should not be an archive, but normal filter!

If local file will be presented with a path, for instance:
 
IPfilterDL.exe - "d:\My Folder\myfilter.dat"
and this path is not the same folder where IPfilterDL.exe was started - the initial myfilter.dat will not be changed. If myfilter.dat is in the same folder with IPfilterDL.exe - it will be ranamed into myfilter.dat.some_numbers.bak to avoid possible conflicts.
 
-----------------------------------------------------------------------
3)
IPfilterDL.exe + https://mydomain.com/mypath/myfilter.gzip

Two default sources will be downloaded, after that the user's filter will be downloaded from https://mydomain.com/mypath/myfilter.gzip.
Please note: the remote filter should be an archive, not an unpacked filter!
 
-----------------------------------------------------------------------
4)
Combinations are also possible:
 
IPfilterDL.exe + https://mydomain.com/mypath/myfilter.gzip - myfilter.dat
IPfilterDL.exe - yourfilter.dat - myfilter.dat
IPfilterDL.exe + https://mydomain.com/mypath/myfilter.gzip + https://yourdomain.com/yourpath/yourfilter.rar

Please note: only one or two (max) additional sources could be added in command line at the moment.
 
-----------------------------------------------------------------------

Please note: now the utility works with IP filters in dat format. They should looks like the following:
001.002.004.000 - 001.002.004.255 , 000 , China Internet Information Center (CNNIC)
001.002.008.000 - 001.002.008.255 , 000 , China Internet Information Center (CNNIC)
001.009.096.105 - 001.009.096.105 , 000 , Botnet on Telekom Malaysia
001.009.102.251 - 001.009.102.251 , 000 , Botnet on Telekom Malaysia

 
If your filter looks like:
China Internet Information Center (CNNIC):1.2.4.0-1.2.4.255
China Internet Information Center (CNNIC):1.2.8.0-1.2.8.255
Botnet on Telekom Malaysia:1.9.96.105-1.9.96.105
Botnet on Telekom Malaysia:1.9.102.251-1.9.102.251

it is p2p format and it is not supported. If you will try to put such file in command line parameters - you will find a file named "your.file" in the same folder with IPFilterDL.exe. It means the utility found unsupported р2р format and ignored it during final ipfilter.dat compilation.
(Normally all IP filter sources allow to choose the format to download - so please choose the correct dat format)
 
After all files were downloaded the utility unpacks archives, combine all data in a whole single ipfilter.dat and cleans it from comments and duplicates. The file is been sorted and you will find a resulted compact ipfilter.dat. The path to this file can be added to your torrent client.
 
If some other ipfilter.dat was already in the same folder with IPFilterDL.exe - it will be renamed (with overwrite if necessary) to ipfilter.bak.
 
If the system has %userprofile%\AppData\Roaming\uTorrent\ folder - the resulting ipfilter.dat file will be copied there. 
 
If you need to automate this process - you can easily create the job in your Task Scheduler.
