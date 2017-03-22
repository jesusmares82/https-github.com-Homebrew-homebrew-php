require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Arcanist < Formula
  desc "Phabricator Arcanist Tool"
  homepage "https://secure.phabricator.com/book/phabricator/article/arcanist/"

  stable do
    url "https://github.com/wikimedia/arcanist/archive/release/2017-03-08/1.tar.gz"
    sha256 "8edb125944f9aa3dc5ea082f2b080543ae324dba3cb055476f1db40219f222e6"
    version "201703081"

    resource "libphutil" do
      url "https://github.com/wikimedia/phabricator-libphutil/archive/release/2017-03-08/1.tar.gz"
      sha256 "e15fe518cad38dea24bcf780b72089479dde1777f9ec23a9b0c9cd0edbd60f92"
      version "201703081"
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
