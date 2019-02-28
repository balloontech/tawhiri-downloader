```
apt install -y build-essential rsync git libpcre3-dev libncurses-dev pkg-config m4 unzip aspcud autoconf bubblewrap
opam init --comp=4.07.0 -y
eval `opam env`

apt install -y libssl-dev libffi-dev libgrib-api-dev
opam pin cohttp-async 'https://github.com/danielrichman/ocaml-cohttp.git#v1.2.0-drichman'
opam install core async async_ssl cohttp-async ctypes ctypes-foreign
./build.sh
```
