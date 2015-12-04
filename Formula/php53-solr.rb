require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Solr < AbstractPhp53Extension
  init
  desc "The Apache Solr PHP extension is an extremely fast, light-weight, feature-rich library that allows PHP applications to communicate easily and efficiently with Apache Solr server instances using an object-oriented API."
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.3.0.tgz"
  sha256 "d90db2ea0a32b8190d65d931e144c01f6238e95e1b91f9d38ddcb2bf68aad7a0"
  head "https://svn.apache.org/repos/asf/lucene/dev/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "391ac946647d34b5837cb1ab8772394dd34d2e1d562e7e65bcef9cf68f342c1d" => :el_capitan
    sha256 "21fe87bcf754be09f8aa8729159d8f61ec2d3b5c1be4f6fd9d37b7b0cbd70971" => :yosemite
    sha256 "10d3b51043eeb221d420ef42048d924c8a6c672cd3c663317e1d651ec4ea0e0c" => :mavericks
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
