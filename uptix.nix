let
  flakeLock = builtins.fromJSON (builtins.readFile ./flake.lock);
  uptixRev = flakeLock.nodes.uptix.locked.rev;
in
import
  (builtins.fetchTarball
    "https://github.com/luizribeiro/uptix/archive/${uptixRev}.tar.gz"
  )
  ./uptix.lock
