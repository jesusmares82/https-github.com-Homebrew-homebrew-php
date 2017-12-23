require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Arcanist < Formula
  desc "Phabricator Arcanist Tool"
  homepage "https://secure.phabricator.com/book/phabricator/article/arcanist/"

  stable do
    url "https://github.com/wikimedia/arcanist/archive/release/2017-11-29/1.tar.gz"
    sha256 "33eef2c3b88f143f7b87e121e54b9a10c7c976fe647ec5d65276458a54e43a25"
    version "201711291"

    resource "libphutil" do
      url "https://github.com/wikimedia/phabricator-libphutil/archive/release/2017-11-29/1.tar.gz"
      sha256 "d43338b02e24a91cf93b30da4f7d2a971d3e185b170df2bb490b7e01a4452524"
      version "201711291"
    end
  end
  bottle do
    cellar :any_skip_relocation
    sha256 "e8f9a27988c21df0ae8001403efef22822ba7fc95f26d8e178560ff684395799" => :high_sierra
    sha256 "e8f9a27988c21df0ae8001403efef22822ba7fc95f26d8e178560ff684395799" => :sierra
    sha256 "e8f9a27988c21df0ae8001403efef22822ba7fc95f26d8e178560ff684395799" => :el_capitan
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
