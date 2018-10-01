#!/bin/bash
R_DIR=${1:-myapp}
SANDBOX_DIR=0_sandbox
ELEMENT_DIR=1_element
DOCUMENT_DIR=2_document
APPLICATION_DIR=3_application

function get {
    curl https://github.com/roine/elm-bootstrap/archive/master.tar.gz -LO
    tar xzf master.tar.gz
    mv elm-bootstrap-master $R_DIR
    rm master.tar.gz
}

function set_template {
    mkdir -p ${R_DIR}/src
    cp -r ${R_DIR}/templates/${1}/* ${R_DIR}/src
}

function clean_up {
    rm -rf templates
    rm install.sh
}

function question {
    echo "Which app do you want [0]sandbox, [1]element, [2]document, [3]application? Default: [3]"
    read response
    if [[ "$response" == "" ]] || [[ "$response" == "3" ]] || [[ "$response" == "application" ]]
    then
        get
        set_template $APPLICATION_DIR
    elif [[ "$response" == "0" ]] || [[ "$response" == "sandbox" ]]
    then
        get
        set_template $SANDBOX_DIR
    elif [[ "$response" == "1" ]] || [[ "$response" == "element" ]]
    then
        get
        set_template $ELEMENT_DIR
    elif [[ "$response" == "2" ]] || [[ "$response" == "document" ]]
    then
        get
        set_template $DOCUMENT_DIR
    else
        echo "Please select 0, 1, 2 or 3."
        question
    fi
}

question
clean_up
