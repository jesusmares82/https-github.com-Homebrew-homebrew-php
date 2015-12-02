require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Solr < AbstractPhp53Extension
  init
  desc "The Apache Solr PHP extension is an extremely fast, light-weight, feature-rich library that allows PHP applications to communicate easily and efficiently with Apache Solr server instances using an object-oriented API."
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.1.0.tgz"
  sha256 "9cf8a067ac79c0e6caa233e38aee9e9bd5d85d3d8cb5c85654ef701aa7cda4bc"
  head "https://svn.apache.org/repos/asf/lucene/dev/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "df0d72fbc92cf67cd8505982a3491b5c990551487de5fbcccdeab60889cbbaa2" => :el_capitan
    sha256 "0e7e857637967b0b8bb38d61dc76c57b16d92d76e16a43143c57642a8b9faec3" => :yosemite
    sha256 "b6490569e176c9bec643d591e0b3517d66314d9593b59680add83ad03f7a0f7e" => :mavericks
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
