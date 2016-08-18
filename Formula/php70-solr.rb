require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Solr < AbstractPhp70Extension
  init
  desc "Fast and lightweight library to communicate with Apache Solr servers"
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.4.0.tgz"
  sha256 "22865dafb76fc5839e84a5bd423bb37d5062883e5dfc4d064b43129ac9f2752c"
  head "https://git.php.net/repository/pecl/search_engine/solr.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "bf7252eaac1b0b543cbae6d72b984c811257196901d1165628948be242adab38" => :el_capitan
    sha256 "c15a4a96e2f3b580aea13c40ff4c0f3e8b8d07e12b6d2d39ed5e4135f9068bc7" => :yosemite
    sha256 "dd14234622be8307b17fb9a4d75257996d9897a20614ee631a0627ceab08b6b3" => :mavericks
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
