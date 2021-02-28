library(biggr2)
library(glue)
library(readr)


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
