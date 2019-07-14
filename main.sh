#!/bin/bash
# Install specified Ruby version on your EC2 via rbenv and change your global Ruby version.
CMDNAME=`basename $0`

function usage {
  cat <<EOM
Usage: $(basename "$0") [OPTION]...

  -h VALUE  server host name
  -v VALUE  ruby version
EOM
  exit 2
}

while getopts h:v: OPT
do
  case $OPT in
    "h" ) FLG_A="TRUE" ; HOST="$OPTARG" ;;
    "v" ) FLG_B="TRUE" ; RUBY_VERSION="$OPTARG" ;;
  esac
done

if [ "$FLG_A" = "TRUE" ] && [ "$FLG_B" = "TRUE" ]; then
  echo "Start Installing Ruby ${RUBY_VERSION} into ${HOST}..."
  ssh $HOST "sudo su --login -c 'cd /opt/rbenv/plugins/ruby_build &&\
              git pull origin master &&\
              ./install.sh &&\
              rbenv install ${RUBY_VERSION} &&\
              rbenv global ${RUBY_VERSION} &&\
              rbenv exec gem install bundler &&\
              rbenv rehash' root"
else
  usage
fi
