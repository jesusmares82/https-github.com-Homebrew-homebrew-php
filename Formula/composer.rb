require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.1.2/composer.phar"
  sha256 "7af2409080619e2ba98e78d7675710c23acf2ccf088d4439a4f79c33ed85c505"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "49e5eec052149f600166334a59893372ebe34ae75e8009269868e2ee12dca627" => :el_capitan
    sha256 "c6fbd4e71a958b80d1508baf424e0e01d3a115ecfd1aaac906ea7056b0d46197" => :yosemite
    sha256 "78162814ab8b303f970c32a243620a738b64444c93db3370f6082c13f9644a28" => :mavericks
  end

  test do
    system "composer", "--version"
  end
end
