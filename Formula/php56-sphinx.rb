require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Sphinx < AbstractPhp56Extension
  init
  homepage 'http://pecl.php.net/package/sphinx'
  url 'http://pecl.php.net/get/sphinx-1.3.2.tgz'
  sha256 '0c3ada36833a44a8147d2dd1b907548010ae53de0a05041a77e68dee036130e6'

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
