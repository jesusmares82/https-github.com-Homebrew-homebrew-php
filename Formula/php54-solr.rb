require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Solr < AbstractPhp54Extension
  init
  desc "Fast and lightweight library to communicate with Apache Solr servers"
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.4.0.tgz"
  sha256 "22865dafb76fc5839e84a5bd423bb37d5062883e5dfc4d064b43129ac9f2752c"
  head "https://git.php.net/repository/pecl/search_engine/solr.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c47e61bd9932fabc26ff765e541f291f332e9486daeb81f1aad974a766b3fe51" => :el_capitan
    sha256 "7de0c5da36f0fbc140cb7ee698b8736aea2a7a46d55a55e9e3b02331d51a03ce" => :yosemite
    sha256 "0646597120de5ffdd4e90b10f1b3bfe2887db13dd7235645352793824eec0a4b" => :mavericks
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
