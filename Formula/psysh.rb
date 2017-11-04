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
    sha256 "79acdcb2b2212900f13e7e042a9e235a43ff387d3091be3282e828b951fe8242" => :high_sierra
    sha256 "bd7c664a547f84f8d4cb2f58b4ab5abff276672f017a0e352f1861c0068cada2" => :sierra
    sha256 "4155d1ca804600be4eb3c81064fc297950c44f7275760072f46bf3ebac08dc46" => :el_capitan
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
