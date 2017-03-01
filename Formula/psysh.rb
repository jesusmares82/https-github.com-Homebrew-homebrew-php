require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Psysh < Formula
  include Language::PHP::Composer

  desc "Runtime developer console, interactive debugger & REPL"
  homepage "https://github.com/bobthecow/psysh"
  url "https://github.com/bobthecow/psysh/archive/v0.8.2.tar.gz"
  sha256 "c7c52777c3d2f72ff5784f84130df47967612a7d82e1c2f4d95edda04949e86a"
  head "https://github.com/bobthecow/psysh.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c247427f190da481a522e56086ecee871a621530fdea2554422dd61f325d5a21" => :sierra
    sha256 "f889811c37179d3e28d7580ec901a5eb78a57303d59b2ba6b137c060b535486b" => :el_capitan
    sha256 "bd99f3203ccd334c7fbbc4161bd3c7f4ca571b871cbc713aa7106ca73df0c530" => :yosemite
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
