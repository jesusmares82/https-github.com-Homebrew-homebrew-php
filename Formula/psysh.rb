require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Psysh < Formula
  include Language::PHP::Composer

  desc "Runtime developer console, interactive debugger & REPL"
  homepage "https://github.com/bobthecow/psysh"
  url "https://github.com/bobthecow/psysh/archive/v0.8.0.tar.gz"
  sha256 "df8481e924896061abaa465bc312653c27f611a246d44c159a87dea6ce953177"
  head "https://github.com/bobthecow/psysh.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "dae9d486689c4b7603f646af0f884f4fd8c3c7642d0d2dffd937f2a7e63423f0" => :sierra
    sha256 "e2746aa430c7587f23d7c50c76258922e1499617822db024ce76df00569e6cb1" => :el_capitan
    sha256 "417901f1f06cfaaeeece7a61c9a058ab9e383256bebdae2de1a601312def6d53" => :yosemite
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
