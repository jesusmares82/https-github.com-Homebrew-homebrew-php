require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Psysh < Formula
  include Language::PHP::Composer

  desc "Runtime developer console, interactive debugger & REPL"
  homepage "https://github.com/bobthecow/psysh"
  url "https://github.com/bobthecow/psysh/archive/v0.8.6.tar.gz"
  sha256 "f7b93aa5034a192054bda8cb5205ec2b71cc297f666489b2ab8fa377c3c4c16c"
  head "https://github.com/bobthecow/psysh.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c5782a853ea499fcdf24a160dc037acca91fc76c64e62c63a98441945535d7c3" => :sierra
    sha256 "8a9590a17a73286a93b24fa7a25885523977439d8149191b53b0ada6416214da" => :el_capitan
    sha256 "212990911d27aa011d679b556bce43dda83ee62432055077468148df32d34f22" => :yosemite
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
