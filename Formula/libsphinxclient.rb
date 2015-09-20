class Libsphinxclient < Formula
  desc "Client for sphinx"
  homepage "http://www.sphinxsearch.com"
  url "http://sphinxsearch.com/files/sphinx-2.2.9-release.tar.gz"
  sha256 "79bcb9fca069ba630fd71fb40fba05bb16e19b475906fb6ae026334d50a6bf3a"

  head "http://sphinxsearch.googlecode.com/svn/trunk/"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "a3f3c02f42e61e59267a347f428ca16da4fbcff71ee6103d4c6d14ae4212d945" => :el_capitan
    sha256 "d8b289ba7618135d6ecf837134cbf42ca5d733fb9c3b1b4ad0e222327d1526c7" => :yosemite
    sha256 "6a8d4c603d302b80ce36065c82b89d0600e5eb1751fbf2016ebf1c4828631683" => :mavericks
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
