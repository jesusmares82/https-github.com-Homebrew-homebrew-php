require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Arcanist < Formula
  desc "Phabricator Arcanist Tool"
  homepage "https://secure.phabricator.com/book/phabricator/article/arcanist/"

  stable do
    url "https://github.com/phacility/arcanist/archive/conduit-5.tar.gz"
    sha256 "81a9599f0799f4a2b77a01ddb35275894b82d8e51f437b51f9342affd029aa8b"

    resource "libphutil" do
      url "https://github.com/phacility/libphutil/archive/conduit-5.tar.gz"
      sha256 "a4bc5d2e80ca3c127d26d7dd74ad4b979841c7a648a2891ef2affd6876af8b2b"
    end
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
