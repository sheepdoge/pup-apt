#!/bin/bash

set -e

test::check_syntax() {
  ansible-playbook playbook.yml -i 'localhost' -e '{"keyservers_to_add": [{"keyserver": "keyserver.ubuntu.com", "id": "0DF731E45CE24F27EEEB1450EFDC8610341D9410"}], "apt_repositories_to_add": ["deb http://repository.spotify.com stable non-free"], "packages_to_install": ["i3", "spotify-client"], "debs_to_install": ["https://downloads.slack-edge.com/linux_releases/slack-desktop-2.6.2-amd64.deb"], "packages_to_uninstall": ["git"]}' --syntax-check
}

test::run_ansible() {
  ansible-playbook playbook.yml -i 'localhost' -e '{"keyservers_to_add": [{"keyserver": "keyserver.ubuntu.com", "id": "0DF731E45CE24F27EEEB1450EFDC8610341D9410"}, { "url": "https://download.docker.com/linux/ubuntu/gpg" }], "apt_repositories_to_add": ["deb http://repository.spotify.com stable non-free"], "packages_to_install": ["i3", "spotify-client"], "debs_to_install": ["https://downloads.slack-edge.com/linux_releases/slack-desktop-2.6.2-amd64.deb"], "packages_to_uninstall": ["git"]}'
}

test::assert_output() {
  for package in slack-desktop spotify-client i3; do
    if ! apt list --installed | grep -q $package; then
      echo "$package is not installed"
      exit 1
    fi
  done

  for package in git; do
    if which "$package"; then
      echo "$package is installed, and should not be"
      exit 1
    fi
  done

  cron_length=$(crontab -l | wc -l)

  if [ "$cron_length" -lt 2 ]
  then
    echo "Cron file is the following:"
    crontab -l
    exit 1
  fi
}

test::check_syntax
test::run_ansible
test::assert_output
