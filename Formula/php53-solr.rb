require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Solr < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/solr'
  url 'http://pecl.php.net/get/solr-2.0.0.tgz'
  sha1 'e8181a0411aa30211fc99cc82ceb4eb9788530e6'
  head 'http://svn.apache.org/repos/asf/lucene/dev/trunk/'

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
