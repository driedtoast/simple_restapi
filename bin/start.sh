#!/bin/sh

basedir=`dirname $0`
basedir=$basedir/..

cd $basedir/web
ruby -rubygems simplerest.rb