class Libsphinxclient < Formula
  homepage 'http://www.sphinxsearch.com'
  url 'http://sphinxsearch.com/files/sphinx-2.2.9-release.tar.gz'
  sha256 '79bcb9fca069ba630fd71fb40fba05bb16e19b475906fb6ae026334d50a6bf3a'

  head 'http://sphinxsearch.googlecode.com/svn/trunk/'

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    cellar :any
    sha256 "e505e2c85186e9b8fc3a137f169fe6e49f05b4907dbc0c34b9a2928aebc8f6f1" => :yosemite
    sha256 "202c7f72f6c1034eee2b581b007973d122da21499866fda2d383808408974e71" => :mavericks
    sha256 "e0f5dea2a25c527d8f5c957ad07e6c0fcbea6a1ad43c41dfd73bb1812e3d9b42" => :mountain_lion
  end

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
