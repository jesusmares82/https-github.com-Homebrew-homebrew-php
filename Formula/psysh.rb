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
    sha256 "4cbb712533da0710f85c640ab90922ab32372414bf14b5c65f75d9d643fa9602" => :high_sierra
    sha256 "3919c1f0fa38c98d948e81509dc3fc08297e3336aa373d7c52f5061a79a9b95d" => :sierra
    sha256 "641513148ad1ecb6eecc4c710509037080e4b089aa55c88364b1c475caaab3e2" => :el_capitan
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
