require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Arcanist < Formula
  desc "Phabricator Arcanist Tool"
  homepage "https://secure.phabricator.com/book/phabricator/article/arcanist/"
  head "https://github.com/phacility/arcanist.git"

  depends_on PhpMetaRequirement

  resource "libphutil" do
    url "https://github.com/phacility/libphutil/archive/master.tar.gz"
  end

  def install
    libexec.install Dir["*"]

    resource("libphutil").stage do
      (buildpath/"libphutil").install Dir["*"]
    end

    prefix.install Dir["*"]

    bin.install_symlink libexec/"bin/arc" => "arc"
  end

  test do
    system "arc", "version"
  end
end
