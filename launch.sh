#!/bin/bash


deploy() {
    __help_text="
    \rUsage: deploy PORT PACKAGE IMAGE
    \r       deploy --help
    \r
    \r    Deploy model as webservice
    \r
    \rExample:
    \r    deploy 5000 iris_prediction mydockerapp
    "
    if [ "$1" == '--help' ] || [ ${#} -lt 1 ]; then
        echo -e "$__help_text"
        return
    fi
    __port=$1
    __package=$2
    __image=$3
    __name=$__package
    __terminal_mode="-d"

    __options=$(echo " \
        $__terminal_mode \
        --net=host \
        -p $__port:$__port \
        --name=$__name \
        $__image \
    " | tr -s ' ')

    __cmd=" \
    git clone https://github.com/mconley-kaizen/deployment_app.git /home/deployment_app && \
    mv -v /home/deployment_app/* /home/webapp/ && \
    cd /home/webapp && \
    if [[ -e requirements.txt ]]; then pip install -r requirements.txt; fi && \
    python /home/webapp/app.py ${__port} ${__package}" 

    for i in $(docker ps -aqf name=${__name} ); do
       echo -n "${__name} stop......" && docker stop $i
       echo -n "${__name} rm........" && docker rm $i
    done

    docker run $__options /bin/bash -c "$__cmd"
}