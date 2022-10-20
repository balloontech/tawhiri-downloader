FROM ocaml/opam:debian-10-ocaml-4.12

RUN sudo apt-get update && sudo apt-get -y upgrade
RUN sudo apt-get install -y build-essential rsync git libpcre3-dev libncurses-dev pkg-config m4 unzip aspcud autoconf bubblewrap
RUN sudo apt-get install -y libssl-dev libgmp-dev libffi-dev libeccodes-dev libcurl4-gnutls-dev
RUN sudo apt-get install -y python3 python3-boto3

RUN opam init -y
RUN eval $(opam env) && opam install "core=v0.14.1" async ctypes ctypes-foreign ocurl dune

RUN mkdir -p /home/opam/tawhiri-downloader
ADD *.ml *.mli dune* *.py /home/opam/tawhiri-downloader/
WORKDIR /home/opam/tawhiri-downloader

RUN eval $(opam env) && dune build --profile=release main.exe

RUN sudo mkdir -p /srv/tawhiri-datasets
RUN sudo chown opam /srv/tawhiri-datasets

CMD ["/home/opam/tawhiri-downloader/_build/default/main.exe", "daemon"]
