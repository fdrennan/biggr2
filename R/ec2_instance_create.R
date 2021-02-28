#' ec2_instance_create
#' @param ImageId An aws ec2 id: i.e., 'ami-0174e69c12bae5410'
#' @param InstanceType See \url{https://aws.amazon.com/ec2/instance-types/}
#' @param min min instances
#' @param max max instances
#' @param KeyName A .pem file to ssh
#' @param SecurityGroupId SecurityGroupId of security group you have created in UI
#' @param InstanceStorage Size of the box in gb
#' @param user_data A shell script that runs on startup
#' @param DeviceName  "/dev/sda1"
#' @export ec2_instance_create
ec2_instance_create <- function(ImageId = "ami-0996d3051b72b5b2c",
                                InstanceType = "t2.nano",
                                min = 1,
                                max = 1,
                                KeyName = Sys.getenv("AWS_PEM"),
                                SecurityGroupId = Sys.getenv("AWS_SECURITY_GROUP"),
                                InstanceStorage = 10,
                                DeviceName = "/dev/sda1",
                                user_data = NA) {
  if (is.na(user_data)) {
    user_data <- ec2_instance_script()
  }

  tmp_location <- tempfile()
  user_data_file <- write_file(user_data, tmp_location)

  base_64_user_data <- read_file(encode(tmp_location))
  ec2 <- paws::ec2()
  response <-
    ec2$run_instances(
      ImageId = ImageId,
      InstanceType = InstanceType,
      MinCount = as.integer(min),
      MaxCount = as.integer(max),
      UserData = base_64_user_data,
      KeyName = KeyName,
      SecurityGroupIds = list(SecurityGroupId),
      BlockDeviceMappings = list(
        list(
          Ebs = list(
            VolumeSize = as.integer(InstanceStorage)
          ),
          DeviceName = DeviceName
        )
      )
    )

  response
}
