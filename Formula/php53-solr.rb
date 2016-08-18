require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Solr < AbstractPhp53Extension
  init
  desc "Fast and lightweight library to communicate with Apache Solr servers"
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.4.0.tgz"
  sha256 "22865dafb76fc5839e84a5bd423bb37d5062883e5dfc4d064b43129ac9f2752c"
  head "https://git.php.net/repository/pecl/search_engine/solr.git"

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
