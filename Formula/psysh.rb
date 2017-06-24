require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Psysh < Formula
  include Language::PHP::Composer

  desc "Runtime developer console, interactive debugger & REPL"
  homepage "https://github.com/bobthecow/psysh"
  url "https://github.com/bobthecow/psysh/archive/v0.8.8.tar.gz"
  sha256 "cff5d5dd20afc2bd039ca00fa436c9d43d7fef8aa49b3bf321f6358a05397715"
  head "https://github.com/bobthecow/psysh.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "60e06c9b90b7546956a709fb4f500ee1d2ca83480048240900043d41db22b12d" => :sierra
    sha256 "73415367e8119b9d6beeb407ec205bd5dd99002b2d7e46721356778ae4ea681a" => :el_capitan
    sha256 "9d0457e4e445daf5df1435f80e739fea5c2f514b4106aa7c5523b2046b06b8bc" => :yosemite
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
