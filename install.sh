#!/bin/bash

### https://natelandau.com/bash-scripting-utilities/

#
# Set Colors
#

bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)

purple=$(tput setaf 171)
red=$(tput setaf 1)
green=$(tput setaf 76)
tan=$(tput setaf 3)
blue=$(tput setaf 38)

heart='\xE2\x99\xA5'
#
# Headers and  Logging
#

e_header() { printf "\n${bold}${purple}==========  %s  ==========${reset}\n" "$@"
}
e_header2() { printf "\n${bold}${blue}• %s ${reset}\n" "$@"
}
e_header3() { printf "\n${bold}${tan}- %s ${reset}\n" "$@"
}
e_arrow() { printf "➜ $@\n"
}
e_success() { printf "${green}✔ %s${reset}\n" "$@"
}
e_heart() { printf "${purple}${heart} %s${reset}\n" "$@"
}
e_underline() { printf "${underline}${bold}%s${reset}\n" "$@"
}
e_bold() { printf "${bold}%s${reset}\n" "$@"
}
e_note() { printf "${underline}${bold}${blue}Note:${reset}  ${blue}%s${reset}\n" "$@"
}
e_note2() { printf "· $@\n"
}
e_error() { printf "${red}✖ %s${reset}\n" "$@"
}

function has_coconut() {
  if [[ $(gem list | grep 'coconut') = *'coconut'* ]]; then
    echo "true"
  else
    echo "false"
  fi
}

function remove_previous_version() {
  if $(has_coconut) = "true"; then
    e_arrow "Previous version found!"
    gem cleanup coconut
    e_success "Old Coconut version was successfully removed"
  fi
}


function install_coconut() {
    e_header3 "Running bundle install"
    e_note "cmd: bundle install"
    bundle install
    output=$(gem build coconut.gemspec)
    gemfile=$(echo $output | tr -s ' ' | cut -d ' ' -f 9)

    e_header3 "Installing gem $gemfile"
    e_note "cmd: gem install ./$gemfile"
    gem install ./$gemfile

    if $(has_coconut) = "true"; then
        e_success "Coconut was successfully installed"
    else
        e_error "Something happens and coconut wasn't installed"
        exit
    fi
}

function setup_coconut() {
    coconut install
    e_success "Coconut was successfully setted up"
}


e_header "Welcome to Coconut"
e_note2 "Coconut is a friendy Gem to dinamically change the configurations of your project."

e_header2 "Remove previous version"
remove_previous_version

e_header2 "Installing coconut"
install_coconut

e_header2 "Setting coconut configuration"
setup_coconut
e_heart "Happy Coding! "
