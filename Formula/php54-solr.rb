require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Solr < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.1.0.tgz"
  sha1 "d7bb1ca0edc22bf83bf644bc5ab30d9d9fec59c7"
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
