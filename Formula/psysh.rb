require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Psysh < Formula
  include Language::PHP::Composer

  desc "Runtime developer console, interactive debugger & REPL"
  homepage "https://github.com/bobthecow/psysh"
  url "https://github.com/bobthecow/psysh/archive/v0.8.14.tar.gz"
  sha256 "7413bf2223aef2edbebed18fd32175ee80313fe5be91c771bf60b2debce36418"
  head "https://github.com/bobthecow/psysh.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "99cf663c1a776c3510f8d14b717178af6dce982fefbb7f04a8898f655107171f" => :high_sierra
    sha256 "39e2b71345aa5184dbbbe1033bd2b8b7f8c3c4d0295d4bef7dee7623107b0b10" => :sierra
    sha256 "9eaadcd7dee5b712040aeb56e33a2914ce26dc986cc37603eedf403c3bbbe2ef" => :el_capitan
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
