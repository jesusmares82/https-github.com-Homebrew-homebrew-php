require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Xmldiff < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/xmldiff'
  url 'http://pecl.php.net/get/xmldiff-0.9.2.tgz'
  sha1 '7cc2b31a34ea9bbce23d163154f4a86bb819bc17'

  def install
    Dir.chdir "xmldiff-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/xmldiff.so"
    write_config_file if build.with? "config-file"
  end
end
