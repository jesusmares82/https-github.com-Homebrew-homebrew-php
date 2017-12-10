require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Psysh < Formula
  include Language::PHP::Composer

  desc "Runtime developer console, interactive debugger & REPL"
  homepage "https://github.com/bobthecow/psysh"
  url "https://github.com/bobthecow/psysh/archive/v0.8.16.tar.gz"
  sha256 "18abe38037ccfac7329897a871d76118b3a639c5e872ea9fafb0d29a1130c1d3"
  head "https://github.com/bobthecow/psysh.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1833174a7fed24f7917886288fd5957b34124dca30fd76823c41d5de964d5103" => :high_sierra
    sha256 "d38324667bd06c03849936c0b141b6880af9f5560107141816459817f288dee3" => :sierra
    sha256 "6d114ac924e5a3237b75a3b952a449702c375f07dd63ae729bf7590b1e2b87d0" => :el_capitan
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
