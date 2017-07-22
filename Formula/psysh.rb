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
    sha256 "3ebb1bae0061dbc4097ac351e06b439da5bb48e3a9778439e2429842c58283c1" => :sierra
    sha256 "cc47db7c3d51adc426ab93593d9519b454deec3468a6a4f9c03a1544d300ad27" => :el_capitan
    sha256 "75b2e227d5c093da8a4240c4c7ef4512a1c27857f9365e00c86c99ac58046791" => :yosemite
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
