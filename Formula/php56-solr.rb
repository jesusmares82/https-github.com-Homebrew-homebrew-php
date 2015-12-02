require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Solr < AbstractPhp56Extension
  init
  desc "The Apache Solr PHP extension is an extremely fast, light-weight, feature-rich library that allows PHP applications to communicate easily and efficiently with Apache Solr server instances using an object-oriented API."
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.1.0.tgz"
  sha256 "9cf8a067ac79c0e6caa233e38aee9e9bd5d85d3d8cb5c85654ef701aa7cda4bc"
  head "https://svn.apache.org/repos/asf/lucene/dev/trunk/"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "cbbce0ab6708ea5707cf6577206efb454d61915c68b28d86b173ea26d221340e" => :el_capitan
    sha256 "dc4229284d3ff4907e601c98d461dba1da8253ea5654d10a10f3d900bf7f9e13" => :yosemite
    sha256 "7b3197bebb31b018964f18521e4ea065e9d404e02a1c4a63b3fe18ed15359511" => :mavericks
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
