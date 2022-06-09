# 以下注释是weed.sh命令的使用方法
#Example: weed upload -master=localhost:9333 file1 [file2 file3]
#         weed upload -master=localhost:9333 -dir=one_directory -include=*.pdf
#Default Usage:
#  -collection string
#        optional collection name
#  -dataCenter string
#        optional data center name
#  -debug
#        verbose debug information
#  -dir string
#        Upload the whole folder recursively if specified.
#  -disk string
#        [hdd|ssd|<tag>] hard drive or solid state drive or any tag
#  -include string
#        pattens of files to upload, e.g., *.pdf, *.html, ab?d.txt, works together with -dir
#  -master string
#        SeaweedFS master location (default "localhost:9333")
#  -maxMB int
#        split files larger than the limit (default 4)
#  -options string
#        a file of command line options, each line in optionName=optionValue format
#  -replication string
#        replication type
#  -ttl string
#        time to live, e.g.: 1m, 1h, 1d, 1M, 1y
#  -usePublicUrl
#        upload to public url from volume server
#Description:
#  upload one or a list of files, or batch upload one whole folder recursively.

#  If uploading a list of files:
#  It uses consecutive file keys for the list of files.
#  e.g. If the file1 uses key k, file2 can be read via k_1

#  If uploading a whole folder recursively:
#  All files under the folder and subfolders will be uploaded, each with its own file key.
#  Optional parameter "-include" allows you to specify the file name patterns.

#  If "maxMB" is set to a positive number, files larger than it would be split into chunks and uploaded separately.
#  The list of file ids of those chunks would be stored in an additional chunk, and this additional chunk's file id would be returned.


./weed upload -master=192.168.50.105:9333 -dir=/Users/yuzhiming/Downloads/nginx-1.20.2 -collection=uploadByMacTest -ttl=1y > ./$(date "+%Y%m%d-%H%M%S").log