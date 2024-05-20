# Insalación de Ruby on Rails

1) sudo apt update && sudo apt upgrade -y

2) sudo apt install git curl autoconf bison build-essential libssl-dev libyaml−dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev

3) git clone https://github.com/rbenv/rbenv.git ~/.rbenv

4) echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc

5) echo 'eval "$(rbenv init -)"' >> ~/.bashrc

6) source ~./bashrc

7) git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

8) rbenv install 3.3.1

9) rbenv global 3.3.1

10) ruby -v

11) gem install rails

12) rbenv rehash

13) rails -v
