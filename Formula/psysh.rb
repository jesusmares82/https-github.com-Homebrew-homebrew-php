require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Psysh < Formula
  include Language::PHP::Composer

  desc "Runtime developer console, interactive debugger & REPL"
  homepage "https://github.com/bobthecow/psysh"
  url "https://github.com/bobthecow/psysh/archive/v0.8.1.tar.gz"
  sha256 "e9e65a337df2c3c3c6ed3edce7fea0f2833e334f6cb511c813430668b26462b8"
  head "https://github.com/bobthecow/psysh.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "65698146ebec8959458e42dd128670d6082a5cbec37b2c0fd087d0fafd3b0b80" => :sierra
    sha256 "9c8a7bee20b6bcd38afad8636484e938b0c0395d582d20a779ac789b33d8893e" => :el_capitan
    sha256 "9a08a7095581294d366c669cc64415b5a4e24a925b63b89ce54b46b96e1a660c" => :yosemite
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
