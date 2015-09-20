require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Solr < AbstractPhp56Extension
  init
  homepage 'https://pecl.php.net/package/solr'
  url 'https://pecl.php.net/get/solr-2.1.0.tgz'
  sha256 '9cf8a067ac79c0e6caa233e38aee9e9bd5d85d3d8cb5c85654ef701aa7cda4bc'
  head 'http://svn.apache.org/repos/asf/lucene/dev/trunk/'

  bottle do
    cellar :any
    sha256 "fe93d5ecba64fb5d93e4fde0cae97830e5f63a9178a5ab09e42f5f6175632fd8" => :el_capitan
    sha256 "6b9cc2307986ecb5c7c6cb6b5ae6a12989509aa115150adf5ef857bc45e25a7b" => :yosemite
    sha256 "ad5fcc87eac5bc5ddcaab2e98d3bc0ab6be0d9748b174551b7663e289c40f55b" => :mavericks
  end

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
