#' ec2_instance_script
#' @param postgres_password Password for airflow database
#' @param phone_number Number to sent you a ding. Message is pointless and nondescript
#' @param null_user Blank file for nothing to load on server.
#' @return A bash script
#' @export ec2_instance_script
ec2_instance_script <- function() {
  user_data <- paste("#!/bin/bash",
    # Install R
    "apt-get update",
    "cd /home/ubuntu && git clone https://github.com/fdrennan/redditstack.git",
    "cd /home/ubuntu/redditstack && sh pre-install.sh >> /home/ubuntu/logs.txt",
    # Something else
    sep = "\n"
  )

  message(user_data)

  user_data
}
