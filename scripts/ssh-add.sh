#!/bin/bash

shopt -s extglob
ssh-add ~/.ssh/@(id_!(*.pub))
