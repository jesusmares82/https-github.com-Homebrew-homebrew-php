require File.expand_path("../../language/php", __FILE__)

class PhanAT08 < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/etsy/phan"
  url "https://github.com/etsy/phan/archive/0.8.4.tar.gz"
  sha256 "b32c40c0edbd54fdd48d411f6a68a368983f8c9429aae98fba41e68ffe7efde0"
  head "https://github.com/etsy/phan.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c6f13a32c2985c324fba4fc6acc9cf5bc70bd2c331cc4fbce4cb91026cc1913a" => :sierra
    sha256 "2b4ce7207550ed9a27d8ed04cb8836aac8bb9de3440182197bff3e08cdce4d8d" => :el_capitan
    sha256 "f150453dd9c1467bc080d3fb8388b6b16ff26195071cc3ed61e9315b4a1d3141" => :yosemite
  end

  depends_on "php70-ast"
  depends_on "php70"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "#{bin}/phan", "--help"
  end
end
