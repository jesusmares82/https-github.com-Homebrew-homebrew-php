require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Psysh < Formula
  include Language::PHP::Composer

  desc "Runtime developer console, interactive debugger & REPL"
  homepage "https://github.com/bobthecow/psysh"
  url "https://github.com/bobthecow/psysh/archive/v0.8.12.tar.gz"
  sha256 "6a4623d2310ff897c099ec291a3a2d5cf5b4cf5bc7a7cbb723a023f55841c6a0"
  head "https://github.com/bobthecow/psysh.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "d749ee307c5c0bdc4995ddc8d78372857cdac2baae2f6052571cf2653548088a" => :high_sierra
    sha256 "e01a712b2a59b1dc7d77992ae3db1a14e794adc8e8952cd9707f74391018675e" => :sierra
    sha256 "43a670ca3344c2be57774050beb43d0070eb747c2e06d514a7d15d370603ba9f" => :el_capitan
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
