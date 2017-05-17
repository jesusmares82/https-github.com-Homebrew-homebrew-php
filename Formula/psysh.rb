require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Psysh < Formula
  include Language::PHP::Composer

  desc "Runtime developer console, interactive debugger & REPL"
  homepage "https://github.com/bobthecow/psysh"
  url "https://github.com/bobthecow/psysh/archive/v0.8.5.tar.gz"
  sha256 "d836c661b6d0b6a8b88458c715bb415cec1714cb5d8703f67573c0de6745b98c"
  head "https://github.com/bobthecow/psysh.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5fc05d856ec91c8ae38a22bde6bfbeab2add85836b80d2c51544c70d4667d325" => :sierra
    sha256 "d25b583a9de743a95e00c2138b4971f740844b14e833f31e5f410c6cfc69cecf" => :el_capitan
    sha256 "2bf5be4516525d1a6a778b070249c041bcff311c297ed42da27f028d152b4de2" => :yosemite
  end

  depends_on PhpMetaRequirement

  def install
    composer_install "--no-dev"
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/psysh"
  end

  test do
    system "#{bin}/psysh", "--version"
  end
end
