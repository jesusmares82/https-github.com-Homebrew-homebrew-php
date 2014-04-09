require 'formula'
require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Sphinx < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/sphinx'
  url 'http://pecl.php.net/get/sphinx-1.3.0.tgz'
  sha1 '87a25a6dc8fecaade453ca55ff5d1822bbef0b1a'

  depends_on 'libsphinxclient'

  def install
    Dir.chdir "sphinx-#{version}"

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig

    safe_phpize

    system "./configure", *args
    system "make"
    prefix.install "modules/sphinx.so"
    write_config_file if build.with? "config-file"
  end
end
