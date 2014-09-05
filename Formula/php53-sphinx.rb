require 'formula'
require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Sphinx < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/sphinx'
  url 'http://pecl.php.net/get/sphinx-1.3.1.tgz'
  sha1 '969ecd6dbff65e7af67b5c448af8a0015fd494d0'

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
