#!/bin/bash
curl https://github.com/roine/elm-bootstrap/archive/master.tar.gz -LO
tar xzf master.tar.gz
mv elm-bootstrap-master $1
rm master.tar.gz