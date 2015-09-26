require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Solr < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.1.0.tgz"
  sha256 "9cf8a067ac79c0e6caa233e38aee9e9bd5d85d3d8cb5c85654ef701aa7cda4bc"
  head "https://svn.apache.org/repos/asf/lucene/dev/trunk/"

  def install
    Dir.chdir "solr-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/solr.so"
    write_config_file if build.with? "config-file"
  end
end
