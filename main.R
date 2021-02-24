library(biggr2)
<<<<<<< HEAD
library(glue)
# debugonce(ec2_instance_create)

user_data <- read_file("ubuntuinit.sh")

user_data <-
  glue_collapse(
    c(
      user_data,
      paste0("echo ", readLines(".Renviron"), ">> /home/ubuntu/.Renviron", collapse = "\n"),
      "cd /home/ubuntu && git clone https://github.com/fdrennan/redditstack.git",
      "mv /home/ubuntu/.Renviron /home/ubuntu/redditstack/.Renviron",
      "sudo chmod 777 -R /home/ubuntu/redditstack"
    ),
    sep = "\n"
  )


server <- ec2_instance_create(
  user_data = user_data,
  InstanceType = "t2.xlarge"
)
=======
library(reticulate)
library(readr)

py_install("boto3")

key_file <- keyfile_create("biggr2")
write_file(key_file, "biggr2.pem")
#sudo chmod 400 biggr2.pem

ec2_instance_create()
>>>>>>> d2a522f1796aa574cca3389de9e41811f2fa1d63
