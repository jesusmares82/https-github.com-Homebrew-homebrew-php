require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Solr < AbstractPhp55Extension
  init
  desc "Fast and lightweight library to communicate with Apache Solr servers"
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.4.0.tgz"
  sha256 "22865dafb76fc5839e84a5bd423bb37d5062883e5dfc4d064b43129ac9f2752c"
  head "https://git.php.net/repository/pecl/search_engine/solr.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "98815b7ca20b6948797b4a12f84eb63033a9e1a5bf6082a33bb063fbbb459e7c" => :el_capitan
    sha256 "373b5883c559fee2cc114d2b1016214f625f85f5dbe95cb1d7aab8a95a4fd015" => :yosemite
    sha256 "98f4965a76a2c8cc1506279f44b33c2c8e5f0be39097e1497066278d7e647500" => :mavericks
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
