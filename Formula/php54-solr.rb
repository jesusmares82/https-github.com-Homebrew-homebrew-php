require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Solr < AbstractPhp54Extension
  init
  desc "The Apache Solr PHP extension is an extremely fast, light-weight, feature-rich library that allows PHP applications to communicate easily and efficiently with Apache Solr server instances using an object-oriented API."
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.3.0.tgz"
  sha256 "d90db2ea0a32b8190d65d931e144c01f6238e95e1b91f9d38ddcb2bf68aad7a0"
  head "https://svn.apache.org/repos/asf/lucene/dev/trunk/"

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
