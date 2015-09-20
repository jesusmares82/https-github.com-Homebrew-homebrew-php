require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phpctags < Formula
  desc "Ctags compatible index generator written in pure PHP"
  homepage "https://github.com/vim-php/phpctags"
  url "https://github.com/vim-php/phpctags/archive/v0.5.1.tar.gz"
  sha256 "65e875c326876016fc1c63341348fab24f6a5b01ce1010f1357e3d87084f832b"

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    system "make"
    bin.install "phpctags"
  end

  test do
    system "phpctags"
  end
end
