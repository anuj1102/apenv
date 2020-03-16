# Might need to sudo apt install ruby-dev if this fails
# sudo apt-get install build-essential patch ruby-dev zlib1g-dev liblzma-dev
bundle install --path vendor/bundle
# {
#   "codeLens.enable": true,
#   "solargraph.useBundler": true
# }
# BUNDLE_GEMFILE=neovim/ruby/Gemfile bundle exec solargraph
