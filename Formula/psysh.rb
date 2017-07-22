require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Psysh < Formula
  include Language::PHP::Composer

  desc "Runtime developer console, interactive debugger & REPL"
  homepage "https://github.com/bobthecow/psysh"
  url "https://github.com/bobthecow/psysh/archive/v0.8.10.tar.gz"
  sha256 "986a40c75cfe22592b76ecae4170462a5cfd1372c9d3ac3884f11d9b2ae3d8b2"
  head "https://github.com/bobthecow/psysh.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1078f5fd3157860603824ac57785207ac0709897c68aee3b5e64e0d7c4007c54" => :sierra
    sha256 "d5990acbfa7a28c0f3304b9873a275b397a40dcfda39769c386900481e325553" => :el_capitan
    sha256 "2bd5bca11d53cba3c80b912463539c3033dd50733b22ffd45ad6d432b6201ad5" => :yosemite
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
