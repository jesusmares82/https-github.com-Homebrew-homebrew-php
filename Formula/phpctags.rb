require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpctags < AbstractPhpPhar
  init
  desc "Ctags compatible index generator written in pure PHP"
  homepage "https://github.com/vim-php/phpctags"
  url "https://github.com/vim-php/phpctags/archive/v0.5.1.tar.gz"
  sha256 "65e875c326876016fc1c63341348fab24f6a5b01ce1010f1357e3d87084f832b"

  def install
    system "make"
    bin.install "phpctags"
  end

  test do
    system "phpctags", "--version"
  end
end
