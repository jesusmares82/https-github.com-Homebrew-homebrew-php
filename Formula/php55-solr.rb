require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Solr < AbstractPhp55Extension
  init
  desc "The Apache Solr PHP extension is an extremely fast, light-weight, feature-rich library that allows PHP applications to communicate easily and efficiently with Apache Solr server instances using an object-oriented API."
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.1.0.tgz"
  sha256 "9cf8a067ac79c0e6caa233e38aee9e9bd5d85d3d8cb5c85654ef701aa7cda4bc"
  head "https://svn.apache.org/repos/asf/lucene/dev/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "bf4980ac19d54a9c38c3aa9ebb642bdefa2d5cceff4b8998f09aa8036263faa2" => :el_capitan
    sha256 "9b4fb732450637f6cea292efbf53c5ce3018bbc571bf6c16cbe91aff185d2002" => :yosemite
    sha256 "7c399d466efec1cae5b6257410e784f00ce4457edb5038f3e29c3c28fd6b50c7" => :mavericks
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
