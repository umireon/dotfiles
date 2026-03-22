#!/bin/bash

set -euxo pipefail

mkdir -p ~/.ssh

curl -fsSL https://github.com/umireon.gpg | gpg --import
curl -fsSL https://github.com/web-flow.gpg | gpg --import

echo "$(git config user.email) $(curl -s https://github.com/umireon.keys | grep 'ssh-ed25519' | head -n 1)" > ~/.ssh/allowed_signers

git config --global gpg.format ssh
git config --global user.signingkey "$(curl -s https://github.com/umireon.keys | head -n 1)"
git config --global commit.gpgsign true
git config --global tag.gpgsign true
git config --global gpg.ssh.allowedSignersFile "~/.ssh/allowed_signers"

cp .bash_profile ~/.bash_profile
