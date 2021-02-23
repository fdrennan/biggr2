library(biggr2)
library(reticulate)
library(readr)

py_install("boto3")

key_file <- keyfile_create("biggr2")
write_file(key_file, "biggr2.pem")
#sudo chmod 400 biggr2.pem

ec2_instance_create()
