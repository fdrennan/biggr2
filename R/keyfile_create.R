#' keyfile_create
#' @importFrom utils write.table
#' @param keyname name for keyfile
#' @param save_to_directory save to working directory
#' @export keyfile_create
keyfile_create <- function(keyname = NA, save_to_directory = TRUE) {
  if (is.na(keyname)) {
    stop("Please supply a name for the keyfile")
  }
  key_pair <- client(service = "ec2")$create_key_pair(KeyName = keyname)
  key_pair$KeyMaterial
}
