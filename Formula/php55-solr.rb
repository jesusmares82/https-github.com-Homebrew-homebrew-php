require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Solr < AbstractPhp55Extension
  init
  desc "The Apache Solr PHP extension is an extremely fast, light-weight, feature-rich library that allows PHP applications to communicate easily and efficiently with Apache Solr server instances using an object-oriented API."
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.3.0.tgz"
  sha256 "d90db2ea0a32b8190d65d931e144c01f6238e95e1b91f9d38ddcb2bf68aad7a0"
  head "https://svn.apache.org/repos/asf/lucene/dev/trunk/"

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
