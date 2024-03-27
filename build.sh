#!/bin/bash

function build() {
  echo "building assets..."

  echo "removing out directory..."
  rm -rf out
  
  echo "removing artifacts directory..."
  rm -rf artifacts

  echo "creating artifacts directory..."
  mkdir artifacts

  echo "building lambda assets..."
  node esbuild.js

  echo "installing sharp..."
  cd out
  npm init --y
  npm install sharp -q
  cd ../

  echo "zipping assets..."
  node zip.js

  echo "assets built"
}

build