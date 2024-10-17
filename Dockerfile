FROM ocaml/opam:debian-10-ocaml-4.12

USER root

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y build-essential rsync git libpcre3-dev libncurses-dev pkg-config m4 unzip aspcud autoconf bubblewrap
RUN apt-get install -y libssl-dev libgmp-dev libffi-dev libeccodes-dev libcurl4-gnutls-dev
RUN apt-get install -y python3 python3-boto3

RUN opam init -y --compiler=4.12.0
RUN eval $(opam env) && opam install "core=v0.14.1" "async=v0.14.0" "ctypes=0.18.0" "ctypes-foreign=0.18.0" "ocurl=0.9.1" dune

RUN mkdir /tawhiri-downloader
ADD *.ml *.mli dune* *.py /tawhiri-downloader/
WORKDIR /tawhiri-downloader

RUN eval $(opam env) && dune build --profile=release main.exe

RUN mkdir -p /srv/tawhiri-datasets

CMD ["/tawhiri-downloader/_build/default/main.exe", "daemon"]
