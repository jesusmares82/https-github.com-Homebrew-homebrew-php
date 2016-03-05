class Libsphinxclient < Formula
  desc "Client for sphinx"
  homepage "http://www.sphinxsearch.com"
  url "https://github.com/sphinxsearch/sphinx/archive/2.2.10-release.tar.gz"
  version "2.2.10"
  sha256 "982dc31ce7bd3a97174d8159d5ee4db9605500a9544b457b53d973ab2e300c1f"

  head "https://github.com/sphinxsearch/sphinx.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "00039e35f77fa4ea271fb838f5aede3a7d2f65424762cf082d5cebf0e78ea6e0" => :el_capitan
    sha256 "027ca884e72d2ad080ba9dd869d26aabe7cb712b2a170dc0283b99ec97d5884f" => :yosemite
    sha256 "abee7ac618acd832be5127e09ca4f21baac3f0102c959d2ce88c8935849cffbb" => :mavericks
  end

  devel do
    url "http://sphinxsearch.com/files/sphinx-2.3.1-beta.tar.gz"
    sha256 "0e5ebee66fe5b83dd8cbdebffd236dcd7cd33a7633c2e30b23330c65c61ee0e3"
  end

  def install
    Dir.chdir "api/libsphinxclient"

    # libsphinxclient doesn"t seem to support concurrent jobs:
    #  https://bbs.archlinux.org/viewtopic.php?id=77214
    ENV.j1

    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert File.exist?("#{include}/sphinxclient.h")
    assert File.exist?("#{lib}/libsphinxclient.a")
  end
end
