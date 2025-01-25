#!/bin/bash

git fetch --prune
git br -v | grep '\[gone\]' | awk '{print $1}' | xargs -r git branch -d
