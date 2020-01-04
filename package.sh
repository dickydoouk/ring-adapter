#!/bin/bash

rm -rf node_modules
npm install --production
rm -rf ./node_modules/.bin
rm -f SHA256SUMS
sha256sum README.md manifest.json package.json *.js LICENSE > SHA256SUMS
find lib -type f -exec sha256sum {} \; >> SHA256SUMS
find node_modules -type f -exec sha256sum {} \; >> SHA256SUMS
TARFILE=$(npm pack)
tar xzf ${TARFILE}
cp -r node_modules ./package
tar czf ${TARFILE} package
rm -rf package
shasum --algorithm 256 ${TARFILE} > ${TARFILE}.sha256sum
echo "Created ${TARFILE}"