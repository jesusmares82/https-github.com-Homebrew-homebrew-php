require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phpctags < Formula
  homepage "https://github.com/vim-php/phpctags"
  url "https://github.com/vim-php/phpctags/archive/v0.5.1.tar.gz"
  version "0.5.1"
  sha1 "a441be4a7bbd8d8c60df8c2650f27488714d47ed"

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    system "make"
    bin.install "phpctags"
  end

  test do
    system "#{bin}/phpctags"
  end
end
