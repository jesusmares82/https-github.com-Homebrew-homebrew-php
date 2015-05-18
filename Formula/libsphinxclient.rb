class Libsphinxclient < Formula
  homepage 'http://www.sphinxsearch.com'
  url 'http://sphinxsearch.com/files/sphinx-2.2.9-release.tar.gz'
  sha256 '79bcb9fca069ba630fd71fb40fba05bb16e19b475906fb6ae026334d50a6bf3a'

  head 'http://sphinxsearch.googlecode.com/svn/trunk/'

  devel do
    url 'http://sphinxsearch.com/files/sphinx-2.3.1-beta.tar.gz'
    sha256 '0e5ebee66fe5b83dd8cbdebffd236dcd7cd33a7633c2e30b23330c65c61ee0e3'
  end

  def install
    Dir.chdir "api/libsphinxclient"

    # libsphinxclient doesn't seem to support concurrent jobs:
    #  https://bbs.archlinux.org/viewtopic.php?id=77214
    ENV.j1

    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end
