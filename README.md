# pup-apt

[sheepdoge](https://github.com/mattjmcnaughton/sheepdoge) pup for managing
dependencies installed through apt.

## Variables

`pup-apt` expects you to define the following variables:
- `pup_apt_vars_keyservers_to_add`: Keyservers we should add.
- `pup_apt_vars_repositories_to_add`: Apt repos we wish to add.
- `pup_apt_vars_packages_to_install`: Apt packages we wish to install.
- `pup_apt_vars_debs_to_install`: Debians to install directly.
- `pup_apt_vars_packages_to_uninstall`: Apt packages to uninstall.
