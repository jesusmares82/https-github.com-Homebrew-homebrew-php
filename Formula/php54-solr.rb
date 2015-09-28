require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Solr < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.1.0.tgz"
  sha256 "9cf8a067ac79c0e6caa233e38aee9e9bd5d85d3d8cb5c85654ef701aa7cda4bc"
  head "https://svn.apache.org/repos/asf/lucene/dev/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "d3e443e169e6bd7761ff4bc53a4b58094f3f29ff0905017a5bd89c8be187a201" => :el_capitan
    sha256 "aedb28583de1251a4287daa79e3cf94be4c3c90197c3fdfccae4ffa125b3c201" => :yosemite
    sha256 "31b8db6d3d8bb8b47b3a72b4d26933c0f8231361e16cff1300f3f61b0ad438c6" => :mavericks
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
