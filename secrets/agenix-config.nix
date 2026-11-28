let
  key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTKhcg9fqtN+tNG3fjKvxd2XV0jAaS1uaDR6Yu5hO1C";
in
{
  "users.age".publicKeys = [ key ];
}
