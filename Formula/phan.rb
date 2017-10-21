require File.expand_path("../../language/php", __FILE__)

class Phan < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/phan/phan"
  url "https://github.com/phan/phan/archive/0.10.1.tar.gz"
  sha256 "fc5b70e8bf783f6afc46dd8b82d7b3c019563723378cae7952134d31ab9b2513"
  head "https://github.com/phan/phan.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "8ed95873bc2d678862f8289813484976d415ebec68d0c3b121bb7dccd18f1347" => :high_sierra
    sha256 "987284a04ac832e1e7a16e75edd1aa5568d21738fc0124973b9c0e18ea2f2e24" => :sierra
    sha256 "0533868e152bd859f5cdb2e466051951ad80a1ecc6cca856a46737f458fe7fee" => :el_capitan
  end

  depends_on "php71-ast"
  depends_on "php71"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "#{bin}/phan", "--help"
  end
end
