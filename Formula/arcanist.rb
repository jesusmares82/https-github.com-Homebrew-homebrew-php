require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Arcanist < Formula
  desc "Phabricator Arcanist Tool"
  homepage "https://secure.phabricator.com/book/phabricator/article/arcanist/"

  stable do
    url "https://github.com/wikimedia/arcanist/archive/release/2017-09-27/1.tar.gz"
    sha256 "f3b5df137c2a5c14df957f9f0d267d17208143e0952948132deebaf2aad0566c"
    version "201709271"

    resource "libphutil" do
      url "https://github.com/wikimedia/phabricator-libphutil/archive/release/2017-09-27/1.tar.gz"
      sha256 "2a3ba7410c9ee15a2022da1fa1c51c680d0a880d52a5da21f3f81c22ce9c0d2c"
      version "201709271"
    end
  end
  bottle do
    cellar :any_skip_relocation
    sha256 "1e1bbd69be7dafbba74f408c19253dd7da9f0a59a2b99dd8881a36ca51329f4d" => :sierra
    sha256 "1e1bbd69be7dafbba74f408c19253dd7da9f0a59a2b99dd8881a36ca51329f4d" => :el_capitan
    sha256 "1e1bbd69be7dafbba74f408c19253dd7da9f0a59a2b99dd8881a36ca51329f4d" => :yosemite
  end


  head do
    url "https://github.com/phacility/arcanist.git"

    resource "libphutil" do
      url "https://github.com/phacility/libphutil.git"
    end
  end

  depends_on PhpMetaRequirement

  def install
    libexec.install Dir["*"]

    resource("libphutil").stage do
      (buildpath/"libphutil").install Dir["*"]
    end

    prefix.install Dir["*"]

    bin.install_symlink libexec/"bin/arc" => "arc"
  end

  test do
    system "#{bin}/arc", "help"
  end
end
